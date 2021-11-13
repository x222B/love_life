local board = {}

board.init = function(dimX,dimY)
    for i=1, dimX+1 do
        board[i] = {}
        for j=1, dimY+1 do
            board[i][j]=false
        end
    end
end

board.iterate = function(dimX,dimY)

    local board_2 = {}
    for i = 1,dimX+1 do
        board_2[i] = {}
        for j = 1,dimY+1 do
            board_2[i][j] = board[i][j]
        end
    end

    for a = 2,dimX do
        for b = 2,dimY do

            local alive = 0
            for c=-1,1 do
                for d=-1,1 do
                    if not (c==0 and d==0) then
                        if board_2[a+c][b+d]==true then
                            alive = alive+1
                        end
                    end
                end
            end

            if alive < 2 then
                board[a][b] = false
            elseif alive == 3 then
                board[a][b] = true
            elseif alive > 3 then
                board[a][b] = false
            end
        end
    end
end

return board
