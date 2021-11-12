local matrix = {}

matrix.init = function(dim)
    for i=1, dim+1 do
        matrix[i] = {}
        for j=1, dim+1 do
            matrix[i][j]=false
        end
    end
end

matrix.start = function ()
    os.execute("clear")
    local x,y,nc;
    print("Enter the number of cells to make alive: ")
     nc = io.read("*n")
    for i=1,nc do
        print("Enter the coordinates of cell" .. i+1 .. " : ")
        x =io.read("*n")
        y =io.read("*n")
        matrix[x+1][y+1] = true
        os.execute("clear")
    end
end

matrix.iterate = function(dim)

    local matrix_2 = {}
    for i = 1,dim+1 do
        matrix_2[i] = {}
        for j = 1,dim+1 do
            matrix_2[i][j] = matrix[i][j]
        end
    end

    for a = 2,dim do
        for b = 2,dim do

            local alive = 0
            for c=-1,1 do
                for d=-1,1 do
                    if not (c==0 and d==0) then
                        if matrix_2[a+c][b+d]==true then
                            alive = alive+1
                        end
                    end
                end
            end

            if alive < 2 then
                matrix[a][b] = false
            elseif alive == 3 then
                matrix[a][b] = true
            elseif alive > 3 then
                matrix[a][b] = false
            end
        end
    end
end
return matrix
