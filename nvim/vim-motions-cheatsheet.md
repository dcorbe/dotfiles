# Vim Motions Cheat Sheet

## Text Objects: `i` (inner) vs `a` (around)

These work with operators like `d`, `c`, `y`, `v`:

| Motion | Meaning |
|--------|---------|
| `diw` | Delete inner word (just the word) |
| `daw` | Delete a word (word + surrounding space) |
| `di"` | Delete inside quotes |
| `da"` | Delete quotes + contents |
| `dip` | Delete inner paragraph |
| `dib` / `di(` | Delete inside parentheses |
| `diB` / `di{` | Delete inside braces |
| `dit` | Delete inside tag (HTML/XML) |

Works with `c` (change), `y` (yank), `v` (select) too: `ciw`, `yi"`, `vap`, etc.

## Treesitter Text Objects

Language-aware selections that understand code structure:

| Motion | Selects |
|--------|---------|
| `af` / `if` | Around/inner function |
| `ac` / `ic` | Around/inner class |
| `aa` / `ia` | Around/inner argument/parameter |
| `al` / `il` | Around/inner loop |
| `ai` / `ii` | Around/inner conditional (if/else) |

## Treesitter Movement

| Key | Does |
|-----|------|
| `]m` / `[m` | Next/prev function start |
| `]M` / `[M` | Next/prev function end |
| `]a` / `[a` | Next/prev parameter |

## Treesitter Swap

| Key | Does |
|-----|------|
| `<leader>sn` | Swap parameter with next |
| `<leader>sp` | Swap parameter with previous |

## Various Text Objects

| Motion | Selects |
|--------|---------|
| `aS` / `iS` | Subword (camelCase/snake_case parts) |
| `U` | URL |
| `an` / `in` | Number |
| `av` / `iv` | Value in key-value pair |
| `ak` / `ik` | Key in key-value pair |
| `aI` / `iI` | Indentation block |

## Line Position

| Motion | Goes to |
|--------|---------|
| `0` | Column 0 (absolute start) |
| `^` | First non-blank character (indent-aware) |
| `_` | Same as `^` (first non-blank) |
| `$` | End of line |
| `g_` | Last non-blank character |

## Navigation

| Motion | Does |
|--------|------|
| `%` | Jump to matching bracket |
| `f{char}` | Jump to next `{char}` on line |
| `t{char}` | Jump to just before `{char}` |
| `F{char}` | Jump to previous `{char}` on line |
| `T{char}` | Jump to just after previous `{char}` |
| `;` / `,` | Repeat `f`/`t` forward/backward |
| `*` / `#` | Search word under cursor forward/backward |
| `{` / `}` | Jump paragraph up/down |
| `gg` / `G` | Go to start/end of file |
| `H` / `M` / `L` | Jump to top/middle/bottom of screen |
| `Ctrl-d` / `Ctrl-u` | Half-page down/up |
| `Ctrl-o` / `Ctrl-i` | Jump back/forward in jump list |

## Useful Commands

| Command | Does |
|---------|------|
| `gi` | Go to last insert position and enter insert mode |
| `gv` | Reselect last visual selection |
| `gd` | Go to local definition |
| `gD` | Go to global definition |
| `gf` | Go to file under cursor |
| `J` | Join lines |
| `~` | Toggle case |
| `gu{motion}` | Lowercase |
| `gU{motion}` | Uppercase |
| `.` | Repeat last change |
| `@:` | Repeat last command-line command |

## Common Combos

```
ci"      Change inside quotes
ct)      Change up to (not including) )
dt,      Delete up to comma
d^       Delete from cursor to first non-blank
y$       Yank to end of line
vip      Select paragraph
ya{      Yank braces + contents
das      Delete a sentence
>ip      Indent paragraph
=i{      Auto-indent inside braces

# Treesitter combos
daf      Delete entire function
cii      Change inside if-block
yia      Yank inner argument
vac      Select around class
]m       Jump to next function

# Various textobjs combos
ciS      Change subword (e.g., "get" in "getUserName")
dU       Delete URL under cursor
cin      Change number
civ      Change value in { key: value }
viI      Select indentation block

# Swap args: foo(a, |b, c) → foo(a, c, |b)
<leader>sn
```

## Registers

| Register | Purpose |
|----------|---------|
| `""` | Default (last yank/delete) |
| `"0` | Last yank only |
| `"1-9` | Delete history |
| `"+` | System clipboard |
| `"*` | Selection clipboard |
| `"_` | Black hole (delete without saving) |

Usage: `"ayy` (yank line to register a), `"ap` (paste from register a)

## Marks

| Mark | Purpose |
|------|---------|
| `ma` | Set mark `a` |
| `'a` | Jump to line of mark `a` |
| `` `a `` | Jump to exact position of mark `a` |
| `''` | Jump to last jump position |
| ``` `` ``` | Jump to exact last position |
| `'.` | Jump to last edit |
