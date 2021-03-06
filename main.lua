local board = require("board")

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local block_size = 20
local dimY = math.floor(WINDOW_WIDTH / block_size)
local dimX = math.floor(WINDOW_HEIGHT / block_size)

local generation = 0
local running = false
local speed = 1

local mouseX = -1
local mouseY = -1

function love.load()
    board.init(dimX,dimY)
    love.graphics.setFont(love.graphics.setNewFont(16))
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })
end

function love.keypressed(key)
    -- quit
    if key == 'q' then
        love.event.quit()
    end
    -- pause / unpause
    if key == 'p' then
        running = not running
    end
    -- reset
    if key == 'r' then
        running = false
        board.init(dimX,dimY)
        generation = 0
    end
    -- speed up
    if key == 'k' then
        if speed >= 0.1 then
            speed = speed * 0.1
        end
    end
    -- speed down
    if key == 'j' then
        if speed <= 1 then
            speed = speed * 10
        end
    end
end

function love.mousepressed(x, y)
    running = false
    mouseX = math.floor(x / block_size)+1
    mouseY = math.floor(y / block_size)+1
    board[mouseY][mouseX] = not board[mouseY][mouseX]
end

local dttotal = 0
function love.update(dt)
    dttotal = dttotal+dt
    if running == true then
        if dttotal >= speed then
            board.iterate(dimX,dimY)
            generation = generation + 1
            dttotal=0
        end
    end
end

function love.draw()
    -- background
    love.graphics.clear(8/255, 8/255, 8/255, 255/255)

    love.graphics.printf('Game of Life!', 4, 0, WINDOW_WIDTH, 'left')
    love.graphics.printf('(P) Play/Pause', 4, 20, WINDOW_WIDTH, 'left')
    love.graphics.printf('(R) Reset', 4, 40, WINDOW_WIDTH, 'left')
    love.graphics.printf('(Q) Quit', 4, 60, WINDOW_WIDTH, 'left')

    love.graphics.printf('(K/J) Speed Up/Down', 4, 660, WINDOW_WIDTH, 'left')
    love.graphics.printf('Speed: ' .. 1/speed .. ' generations / sec', 4, 680, WINDOW_WIDTH, 'left')
    love.graphics.printf('Generation: ' .. generation, 4, 700, WINDOW_WIDTH, 'left')

    for y=1, #board do
        for x=1, #board[y] do
            if board[y][x] == true then
                love.graphics.rectangle("fill", (x-1)*block_size, (y-1)*block_size, block_size, block_size)
            else
                love.graphics.rectangle("line", (x-1)*block_size, (y-1)*block_size, block_size, block_size)
            end
        end
    end

end
