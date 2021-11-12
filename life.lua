local board = {}

board.init = function(dim)
    for i=1, dim+1 do
        board[i] = {}
        for j=1, dim+1 do
            board[i][j]=false
        end
    end
end

board.start = function ()
    os.execute("clear")
    local x,y,nc;
    print("Enter the number of cells to make alive: ")
     nc = io.read("*n")
    for i=1,nc do
        print("Enter the coordinates of cell" .. i+1 .. " : ")
        x =io.read("*n")
        y =io.read("*n")
        board[x+1][y+1] = true
        os.execute("clear")
    end
end

board.iterate = function(dim)

    local board_2 = {}
    for i = 1,dim+1 do
        board_2[i] = {}
        for j = 1,dim+1 do
            board_2[i][j] = board[i][j]
        end
    end

    for a = 2,dim do
        for b = 2,dim do

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
