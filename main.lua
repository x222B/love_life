local life = require("life")

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local block_size = 40
local dimY = math.floor(WINDOW_WIDTH / block_size)
local dimX = math.floor(WINDOW_HEIGHT / block_size)

local generation = 0

local running = true
local speed = 1

function love.load()
    life.init(dimX,dimY)
    life.testFill()
    love.graphics.setFont(love.graphics.setNewFont(16))
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false,
    })
end

function love.keypressed(key)
    if key == 'q' then
        love.event.quit()
    end
    if key == 'p' then
        running = not running
    end
    if key == 'r' then
        life.init(dimX,dimY)
        generation = 0
    end
    if key == 'j' then
        if speed <= 1 then
            speed = speed * 10
        end
    end
    if key == 'k' then
        if speed >= 0.01 then
            speed = speed * 0.1
        end
    end
end

local dttotal = 0
function love.update(dt)
    dttotal = dttotal+dt
    if running == true then
        if dttotal > speed then
            life.iterate(dimX,dimY)
            generation = generation + 1
            dttotal=0
        end
    end
end

function love.draw()
    love.graphics.clear(8/255, 8/255, 8/255, 255/255)
    love.graphics.printf('Game of Life!', 4, 0, WINDOW_WIDTH, 'left')
    love.graphics.printf('(P) Play/Pause', 4, 20, WINDOW_WIDTH, 'left')
    love.graphics.printf('(R) Reset', 4, 40, WINDOW_WIDTH, 'left')
    love.graphics.printf('(Q) Quit', 4, 60, WINDOW_WIDTH, 'left')
    love.graphics.printf('(K/J) Speed Up/Down', 4, 660, WINDOW_WIDTH, 'left')
    love.graphics.printf('Speed: ' .. 1/speed .. ' generations / sec', 4, 680, WINDOW_WIDTH, 'left')
    love.graphics.printf('Generation: ' .. generation, 4, 700, WINDOW_WIDTH, 'left')

    for y=1, #life do
        for x=1, #life[y] do
            if life[y][x] == true then
                love.graphics.rectangle("fill", (x-1)*40, (y-1)*40, 40, 40)
            else
                love.graphics.rectangle("line", (x-1)*40, (y-1)*40, 40, 40)
            end
        end
    end

end
