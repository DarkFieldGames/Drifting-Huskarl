function bucketfill(pixmap,x,y,target,replace)
--print("BUCKETFILL",x,y,target,replace)
--[[
 1. Set Q to the empty queue.
 2. If the color of node is not equal to target-color, return.
 3. Add node to the end of Q.
 4. While Q is not empty: 
 5.     Set n equal to the first element of Q
 6.     If the color of n is equal to target-color, set the color of n to replacement-color.
 7.     Remove first element from Q
 8.     If the color of the node to the west of n is target-color:
 9.         Set the color of that node to replacement-color
10.         Add that node to the end of Q
11.     If the color of the node to the east of n is target-color: 
12.         Set the color of that node to replacement-color
13.         Add that node to the end of Q
14.     If the color of the node to the north of n is target-color:
15.         Set the color of that node to replacement-color
16.         Add that node to the end of Q
17.     If the color of the node to the south of n is target-color:
18.         Set the color of that node to replacement-color
19.         Add that node to the end of Q
]]--

Q = {}
if pixmap[x][y] ~= target then return pixmap end
table.insert(Q,{x,y})
    resolution_x = 32
    resolution_y = 24
    while #Q > 0 do
        nx = Q[#Q][1]
        ny = Q[#Q][2]
        if pixmap[nx][ny] == target then pixmap[nx][ny] = replace end
        r = table.remove(Q,#Q)
        if nx < resolution_x-1 then
        if pixmap[nx+1][ny] == target then 
            pixmap[nx+1][ny] = replace
            table.insert(Q,{nx+1,ny})
        end end
        if nx > 1 then
        if pixmap[nx-1][ny] == target then 
            pixmap[nx-1][ny] = replace
            table.insert(Q,{nx-1,ny})
        end end
        if ny < resolution_y-1 then
        if pixmap[nx][ny+1] == target then 
            pixmap[nx][ny+1] = replace
            table.insert(Q,{nx,ny+1})
        end end
        if ny > 1 then
        if pixmap[nx][ny-1] == target then 
            pixmap[nx][ny-1] = replace
            table.insert(Q,{nx,ny-1})
        end end
    end
    return pixmap
end
