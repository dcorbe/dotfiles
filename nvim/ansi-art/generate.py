#!/usr/bin/env python3
"""Generate the truecolor ANSI art used by the snacks dashboard.

Writes the .ans files next to this script. Both pieces are sized to fit
the snacks dashboard default content width of 60 columns; the dashboard
renders them through a `terminal` section (normal buffers don't
interpret escape sequences).

Rendering technique: each character cell is a `▀` half-block carrying
two vertically stacked pixels (foreground = top, background = bottom),
so an art of W x H pixels occupies W x H/2 character cells.
"""

import os

OUT_DIR = os.path.dirname(os.path.abspath(__file__))

# Right half of the bat emblem, x = 0 (center) .. 22 (wing tip).
# For each column, black pixels span rows TOP[x]..BOT[x] (bat-local).
# Mirrored around the center column, so the emblem is always symmetric.
TOP = [1, 1, 0, 0, 1, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5, 6]
BOT = [13, 12, 11, 10, 10, 11, 12, 12, 11, 10, 9, 10, 11, 11, 10, 9, 8, 8, 7, 7, 7, 7, 6]

YELLOW = (255, 201, 0)
BLACK = (8, 8, 8)
NAVY = (9, 13, 32)
STAR = (215, 220, 235)
DISC = (250, 244, 212)
BAT = (14, 17, 33)
BEAM = (222, 228, 208)
BUILDING = (4, 6, 16)
WINDOW = (255, 196, 80)
WINDOW_DIM = (150, 118, 60)


def lerp(c1, c2, t):
    return tuple(round(a + (b - a) * t) for a, b in zip(c1, c2))


def bat_spans(cx, bat_y):
    """Canvas-column -> (y_top, y_bot) covered by the bat emblem."""
    spans = {}
    for xo in range(23):
        for x in {cx - xo, cx + xo}:
            spans[x] = (bat_y + TOP[xo], bat_y + BOT[xo])
    return spans


def render(canvas, captions):
    lines = []
    for y in range(0, len(canvas), 2):
        row = []
        for x in range(len(canvas[0])):
            tr, tg, tb = canvas[y][x]
            br, bg, bb = canvas[y + 1][x]
            row.append(f"\033[38;2;{tr};{tg};{tb}m\033[48;2;{br};{bg};{bb}m▀")
        lines.append("".join(row) + "\033[0m")
    lines.extend(captions)
    return "\n".join(lines) + "\n"


def captions(width, title, subtitle):
    return [
        "",
        "\033[1;38;2;255;201;0m" + title.center(width) + "\033[0m",
        "\033[3;38;2;125;130;150m" + subtitle.center(width) + "\033[0m",
    ]


def gen_batman():
    """The classic emblem: black bat on a ringed yellow oval, night sky."""
    W, H = 59, 28
    CX, CY, A, B = 29, 14, 28.0, 13.0
    BAT_Y = 8
    STARS = [(3, 2), (10, 1), (22, 0), (38, 1), (50, 2), (56, 4),
             (1, 9), (57, 12), (1, 19), (56, 21), (6, 25), (44, 27),
             (52, 26), (14, 27)]

    def v(x, y):
        return ((x - CX) / A) ** 2 + ((y - CY) / B) ** 2

    spans = bat_spans(CX, BAT_Y)
    canvas = [[NAVY] * W for _ in range(H)]
    for sx, sy in STARS:
        if v(sx, sy) > 1.08:
            canvas[sy][sx] = STAR
    for y in range(H):
        for x in range(W):
            e = v(x, y)
            if e <= 1.0:
                canvas[y][x] = BLACK if e >= 0.80 else YELLOW
                span = spans.get(x)
                if e < 0.80 and span and span[0] <= y <= span[1]:
                    canvas[y][x] = BLACK
    return render(canvas, captions(
        W, "B  A  T  M  A  N",
        "“I am vengeance. I am the night. I am Batman.”"))


def gen_batsignal():
    """Searchlight beam from a rooftop onto a signal disc, Gotham skyline."""
    W, H = 60, 44
    DCX, DCY, DA, DB = 27, 11, 25.0, 10.5   # signal disc
    BAT_Y = 4
    SRC = (52, 29)                           # searchlight position
    BP1, BP2 = (5, 14), (49, 9)              # beam edges on the disc rim
    BUILDINGS = [(0, 6, 36), (6, 11, 32), (11, 16, 38), (16, 22, 34),
                 (22, 26, 40), (26, 32, 31), (32, 37, 37), (37, 42, 33),
                 (42, 47, 39), (47, 57, 29), (57, 60, 35)]
    STARS = [(2, 3), (10, 5), (46, 2), (57, 4), (44, 12), (58, 10),
             (1, 20), (50, 17), (7, 24), (57, 16), (33, 26), (14, 26),
             (3, 28), (58, 22)]

    roof = [0] * W
    for x0, x1, top in BUILDINGS:
        for x in range(x0, x1):
            roof[x] = top

    def v(x, y):
        return ((x - DCX) / DA) ** 2 + ((y - DCY) / DB) ** 2

    def cross(ox, oy, ax, ay, bx, by):
        return (ax - ox) * (by - oy) - (ay - oy) * (bx - ox)

    def in_beam(x, y):
        d1 = cross(*SRC, *BP1, x, y)
        d2 = cross(*BP1, *BP2, x, y)
        d3 = cross(*BP2, *SRC, x, y)
        return (d1 >= 0 and d2 >= 0 and d3 >= 0) or \
               (d1 <= 0 and d2 <= 0 and d3 <= 0)

    def centerline_dist(x, y):
        ax, ay = SRC
        dx, dy = DCX - ax, DCY - ay
        return abs((x - ax) * dy - (y - ay) * dx) / (dx * dx + dy * dy) ** 0.5

    spans = bat_spans(DCX, BAT_Y)
    canvas = []
    for y in range(H):
        row = []
        for x in range(W):
            c = lerp((6, 9, 24), (30, 38, 76), y / (H - 1))    # sky gradient
            e = v(x, y)
            if e > 1.0 and in_beam(x, y):
                f = 0.26 + (0.14 if centerline_dist(x, y) < 5 else 0.0)
                c = lerp(c, BEAM, f)
            if 1.0 < e <= 1.6:
                c = lerp(c, DISC, (1.6 - e) / 0.6 * 0.35)      # halo
            elif e <= 1.0:
                c = lerp(DISC, BEAM, e * 0.35)                 # disc, soft edge
                span = spans.get(x)
                if span and span[0] <= y <= span[1]:
                    c = BAT
            if y >= roof[x]:                                   # skyline
                c = BUILDING
                if y >= roof[x] + 2 and y < H - 1 and (x * 31 + y * 17) % 23 == 0:
                    c = WINDOW if (x + y) % 3 else WINDOW_DIM
            row.append(c)
        canvas.append(row)

    for sx, sy in STARS:
        if v(sx, sy) > 1.7 and not in_beam(sx, sy) and sy < roof[sx] - 1:
            canvas[sy][sx] = STAR

    # searchlight housing + glow at the beam source
    sx, sy = SRC
    for gx, gy, gc in [(sx - 1, sy - 1, (120, 125, 140)),
                       (sx + 1, sy - 1, (120, 125, 140)),
                       (sx, sy - 1, (255, 252, 235)),
                       (sx, sy - 2, (255, 252, 235))]:
        canvas[gy][gx] = gc

    return render(canvas, captions(
        W, "T H E   B A T - S I G N A L", "Gotham City — 11:47 PM"))


def main():
    for name, gen in (("batman.ans", gen_batman),
                      ("batsignal.ans", gen_batsignal)):
        path = os.path.join(OUT_DIR, name)
        with open(path, "w") as f:
            f.write(gen())
        print(f"wrote {path}")


if __name__ == "__main__":
    main()
