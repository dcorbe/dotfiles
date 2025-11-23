# Matrix Rain Animation Design

**Date:** 2025-11-23
**Type:** Custom cellular-automaton.nvim Animation
**Keybinding:** `<leader>fmx`

## Overview

A "Code Rain" animation where actual buffer content becomes digital rain. Characters are randomly sampled from the user's code, spawn at the top of the screen, and fall down at variable speeds while fading based on age.

## Core Features

- **Heavy density:** 50%+ columns active simultaneously
- **Variable speed:** Each cascade has randomized fall speed (0.5x to 2.0x)
- **Age-based fading:** Characters fade progressively (bright → dim → disappear)
- **Syntax highlighting:** Preserved from original buffer content
- **Continuous loop:** Runs until user manually exits (q/Esc/Enter)

## Technical Specifications

### Animation Parameters

- **Name:** `matrix_rain`
- **Frame Rate:** 30 FPS
- **Character Lifespan:** 30 frames (~1 second)
- **Spawn Rate:** 3-5% probability per column per frame
- **Speed Range:** 0.5x to 2.0x (random per cascade)

### Grid Cell State

Each cell tracks:
- `char`: The character to display
- `hl_group`: Original Treesitter highlight group
- `age`: Frame count since character started falling (0-30)
- `speed`: Fall speed multiplier (0.5-2.0)
- `active`: Boolean indicating active falling character

### Character Pool

On initialization:
- Scan entire buffer to build character pool
- Store each non-whitespace character with its highlight group
- Format: `{ char = "x", hl_group = "String" }`
- Pool is used for random cascade spawning

## Animation Logic

### Initialization (`init()`)

1. Scan buffer to build character pool
2. Filter out whitespace characters
3. Initialize all grid cells: active=false, age=0
4. Store character pool for spawn operations

### Update Loop (`update()`)

Each frame executes:

1. **Age Management:**
   - Increment age for all active characters
   - Remove characters with age > 30 (set to space, active=false)

2. **Gravity Simulation:**
   - Process cells bottom-to-top (avoid double-processing)
   - Check if character should fall based on speed:
     - Fast (2.0x): Falls every frame
     - Slow (0.5x): Falls every other frame
   - When falling:
     - Move char/hl_group/age/speed to row below
     - Clear old position
   - Characters reaching bottom row disappear

3. **Cascade Spawning:**
   - For each column: 3-5% spawn probability
   - When spawning:
     - Pick random character from pool
     - Place at row 1 with age=0
     - Assign random speed (0.5-2.0)
     - Preserve original highlight group

4. **Return true** (loops forever)

### Fade Implementation

Since Neovim doesn't support opacity:
- Track age (0-30 frames)
- Characters older than 30 disappear
- Future enhancement: Could create custom dimmed highlight groups

## Implementation Structure

### File Organization

**Animation File:**
`/Users/daniel/.config/nvim/lua/animations/matrix_rain.lua`

**Plugin Config Update:**
`/Users/daniel/.config/nvim/lua/plugins/cellular-automaton.lua`

### Code Structure

```lua
-- Global state
local char_pool = {}

-- init(grid): Initialize character pool and grid state
-- update(grid): Execute animation logic, return true

-- Helper functions:
-- - is_empty(cell): Check if cell is inactive
-- - should_fall_this_frame(speed, frame_count): Speed-based falling
-- - pick_random_char(): Random selection from pool
```

### Keybinding

Add to cellular-automaton plugin config:
```lua
{
    "<leader>fmx",
    "<cmd>CellularAutomaton matrix_rain<cr>",
    desc = "Matrix Rain",
}
```

## Design Decisions

### Why age-based fading?
More natural effect than position-based. Characters dim as they age regardless of screen position.

### Why variable speed?
Creates dynamic, organic feel closer to Matrix movie effect.

### Why heavy density?
User specifically requested intense, screen-filling rain.

### Why character pool from buffer?
Unique twist: user's own code becomes the Matrix. More personal than random glyphs.

### Why 30 frame lifespan?
At 30 FPS, this equals 1 second - enough to see the fade but not clutter the screen.

## Future Enhancements

- Custom highlight groups for proper fade gradient
- Configurable density/speed parameters
- Optional Matrix katakana character mode
- Trail length configuration
- Brightness boost for cascade heads
