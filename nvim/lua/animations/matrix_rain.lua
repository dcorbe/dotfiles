local M = {
    name = "matrix_rain"
}

-- Character pool built from buffer content
local char_pool = {}

-- Initialize character pool from grid
local function build_char_pool(grid)
    char_pool = {}

    for i = 1, #grid do
        for j = 1, #grid[i] do
            local cell = grid[i][j]
            if cell.char and cell.char ~= " " and cell.char ~= "" then
                table.insert(char_pool, {
                    char = cell.char,
                    hl_group = cell.hl_group or "Normal"
                })
            end
        end
    end

    -- Fallback if buffer is empty or all whitespace
    if #char_pool == 0 then
        char_pool = {
            { char = "0", hl_group = "Normal" },
            { char = "1", hl_group = "Normal" },
        }
    end
end

-- Check if cell is empty/inactive
local function is_empty(cell)
    return not cell.active or cell.char == " " or cell.char == ""
end

-- Get random character from pool
local function pick_random_char()
    if #char_pool == 0 then
        return { char = "0", hl_group = "Normal" }
    end
    return char_pool[math.random(#char_pool)]
end

-- Determine if character should fall based on speed
-- Speed multiplier: 0.5x (every other frame) to 2.0x (every frame)
local frame_counter = 0

local function should_fall_this_frame(speed)
    -- Fast characters (>1.5x) fall every frame
    if speed >= 1.5 then
        return true
    end

    -- Slow characters (<0.75x) fall every other frame
    if speed <= 0.75 then
        return frame_counter % 2 == 0
    end

    -- Medium speed falls based on counter
    return frame_counter % 2 == 0 or speed > 1.0
end

-- Initialize grid state
function M.init(grid)
    -- Seed random number generator for different behavior each time
    math.randomseed(os.time())

    -- Build character pool from buffer content
    build_char_pool(grid)

    -- Initialize all cells with metadata and clear original content
    for i = 1, #grid do
        for j = 1, #grid[i] do
            local cell = grid[i][j]
            cell.char = " "  -- Clear original buffer text
            cell.age = 0
            cell.speed = 0
            cell.active = false
        end
    end
end

-- Update grid each frame
function M.update(grid)
    frame_counter = frame_counter + 1
    local state_changed = false

    -- Step 1: Age only stationary characters (not ones that will fall this frame)
    for i = 1, #grid do
        for j = 1, #grid[i] do
            local cell = grid[i][j]
            if cell.active then
                -- Only age if character won't fall this frame (stationary)
                if not should_fall_this_frame(cell.speed) or i == #grid then
                    cell.age = cell.age + 1

                    -- Remove characters older than 10 frames (~0.3 seconds at 30 FPS)
                    if cell.age > 10 then
                        cell.char = " "
                        cell.active = false
                        cell.age = 0
                        state_changed = true
                    end
                end
            end
        end
    end

    -- Step 2: Move characters down based on speed (bottom to top to avoid double-processing)
    for i = #grid, 1, -1 do
        for j = 1, #grid[i] do
            local cell = grid[i][j]

            if cell.active and should_fall_this_frame(cell.speed) then
                -- Check if can move down
                if i < #grid then
                    local below = grid[i + 1][j]

                    if is_empty(below) then
                        -- Move character down
                        below.char = cell.char
                        below.hl_group = cell.hl_group
                        below.age = cell.age
                        below.speed = cell.speed
                        below.active = true

                        -- Clear old position
                        cell.char = " "
                        cell.active = false
                        cell.age = 0
                        cell.speed = 0

                        state_changed = true
                    end
                end
                -- If at bottom row, character stays and ages naturally
            end
        end
    end

    -- Step 3: Spawn new cascades (8% probability per column for heavy density)
    for j = 1, #grid[1] do
        -- Random spawn check (8% = 0.08)
        if math.random() < 0.08 then
            local top_cell = grid[1][j]

            if is_empty(top_cell) then
                local random_char = pick_random_char()

                top_cell.char = random_char.char
                top_cell.hl_group = random_char.hl_group
                top_cell.age = 0
                top_cell.speed = 0.5 + (math.random() * 1.5)  -- Random speed 0.5 to 2.0
                top_cell.active = true

                state_changed = true
            end
        end
    end

    return true  -- Always loop
end

return M
