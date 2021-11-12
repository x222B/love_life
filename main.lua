local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

function love.load()
    love.graphics.setFont(love.graphics.setNewFont(16))
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
        centered = true
    })
end

function love.keypressed(key)
    if key == 'q' then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.clear(8/255, 8/255, 8/255, 255/255)
    love.graphics.printf('Game of Life!',4, 0, WINDOW_WIDTH, 'left')
    love.graphics.printf('(P) Play/Pause',4, 18, WINDOW_WIDTH, 'left')
    love.graphics.printf('(R) Reset',4, 38, WINDOW_WIDTH, 'left')
    love.graphics.printf('(Q) Quit',4,56, WINDOW_WIDTH, 'left')
end
