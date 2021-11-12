local life = require("life")

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local block_size = 40
local dim = math.floor(WINDOW_WIDTH / block_size)

local run = false

function love.load()
    life.init(dim)
    life.testFill()
    love.graphics.setFont(love.graphics.setNewFont(16))
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })
end

function love.keypressed(key)
    if key == 'q' then
        love.event.quit()
    end
    if key == 'p' then
        run = not run
    end
    if key == 'r' then
        life.init(dim)
    end
end

local dttotal = 0
function love.update(dt)
    dttotal = dttotal+dt
    if run == true then
        if dttotal > 0.3 then
            life.iterate(dim)
            dttotal=0
        end
    end
end

function love.draw()
    love.graphics.clear(8/255, 8/255, 8/255, 255/255)
    love.graphics.printf('Game of Life!',4, 0, WINDOW_WIDTH, 'left')
    love.graphics.printf('(P) Play/Pause',4, 18, WINDOW_WIDTH, 'left')
    love.graphics.printf('(R) Reset',4, 38, WINDOW_WIDTH, 'left')
    love.graphics.printf('(Q) Quit',4,56, WINDOW_WIDTH, 'left')

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
