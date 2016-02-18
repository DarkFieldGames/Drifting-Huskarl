require "map7"

musicflag = false
mainmenu = true


function printmap (roommap)
arrayteststring = ""
for i = 1, #roommap do
  for j = 1, #roommap[i] do
      arrayteststring = arrayteststring .. roommap[i][j] .. " "
  end
  print (arrayteststring)
  arrayteststring = ""
end
end

function table.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

function table.spincopy(t)
	copyt = {}
	for i=1,24 do
		newrow = {}
		for j=1,32 do
			table.insert(newrow,t[j][i])
		end
		table.insert(copyt,newrow)
	end
	return copyt
end

function isWall(n)
	return n == 2 or n == 50 or n==51 or n==52 or n==53 or n==60 or n==122 or n==123 or n==132 or n==102 or n==160 or n==101 or n==103 or n==150 or n==102 or n==104
end

function isFloor(n)
	return n == 1 or n==70 or n==71 or n==100 or n==120 or n==121 or n==130 or n==131 or n==140 or n==141 or n==142 or n==143 or n==144 or n==161
end

function wallset(wallnums)
	if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- hwall
		if isFloor(wallnums[2]) then 
			if isFloor(wallnums[8]) then
				return 30
			else
				return 3 
			end
		else 
			return 2 
		end
	elseif isWall(wallnums[2]) and not isWall(wallnums[4]) and not isWall(wallnums[6]) and isWall(wallnums[8]) then -- vwall
		if isFloor(wallnums[4]) then 
			if isFloor(wallnums[6]) then
				return 31
			else
				return 5 
			end
		else 
			return 4 
		end
	
	elseif isWall(wallnums[2]) and isWall(wallnums[4]) and not isWall(wallnums[6]) and not isWall(wallnums[8]) then -- _|
		if isFloor(wallnums[1]) then 
			if isFloor(wallnums[9]) then
				return 32
			else
				return 9 
			end
		else 
			return 10 
		end
	elseif isWall(wallnums[2]) and not isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- |_
		if isFloor(wallnums[3]) then 
			if isFloor(wallnums[7]) then
				return 33
			else
				return 8 
			end
		else 
			return 11 
		end
	elseif not isWall(wallnums[2]) and isWall(wallnums[4]) and not isWall(wallnums[6]) and isWall(wallnums[8]) then -- -|
		if isFloor(wallnums[7]) then 
			if isFloor(wallnums[3]) then
				return 34
			else
				return 7 
			end
		else 
			return 12 
		end
	elseif not isWall(wallnums[2]) and not isWall(wallnums[4]) and isWall(wallnums[6]) and isWall(wallnums[8]) then -- |-
		if isFloor(wallnums[9]) then 
			if isFloor(wallnums[1]) then
				return 35
			else
				return 6 
			end
		else 
			return 13 
		end
		
	--else return wallnums[2] + wallnums[4] + wallnums[6] + wallnums[8]
		
	elseif isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and isWall(wallnums[8]) then -- 4way
		return 99
	
	else -- probably 3split
		if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and isWall(wallnums[8]) then -- T
			if wallnums[2] == 0 then return 23
			elseif wallnums[7] == 0 then return 24
			elseif wallnums[9] == 0 then return 25
			else return 22
			end
		elseif isWall(wallnums[2]) and not isWall(wallnums[4]) and isWall(wallnums[6]) and isWall(wallnums[8]) then -- |-
			if wallnums[4] == 0 then return 15
			elseif wallnums[3] == 0 then return 16
			elseif wallnums[9] == 0 then return 17
			else return 14
			end
		elseif isWall(wallnums[2]) and isWall(wallnums[4]) and not isWall(wallnums[6]) and isWall(wallnums[8]) then -- -|
			if wallnums[6] == 0 then return 19
			elseif wallnums[1] == 0 then return 20
			elseif wallnums[7] == 0 then return 21
			else return 18
			end
		elseif isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- _|_
			if wallnums[8] == 0 then return 27
			elseif wallnums[3] == 0 then return 28
			elseif wallnums[1] == 0 then return 29
			else return 26
			end
			return 26
		end
	
	end
	
	
	return 99
end

function doorset(wallnums)
	if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- hwall
		if isFloor(wallnums[2]) then 
			if isFloor(wallnums[8]) then
				return 50
			else
				return 52
			end
		else 
			return 51
		end
	elseif isWall(wallnums[2]) and not isWall(wallnums[4]) and not isWall(wallnums[6]) and isWall(wallnums[8]) then -- vwall
		if isFloor(wallnums[4]) then 
			if isFloor(wallnums[6]) then
				return 54
			else
				return 56
			end
		else 
			return 55
		end
	end
	return 50
end

function opendoorset(wallnums)
	if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- hwall
		return 53
	else 
		return 57
	end
end



function ydoorset(wallnums)
	if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- hwall
		if isFloor(wallnums[2]) then 
			if isFloor(wallnums[8]) then
				return 60
			else
				return 62
			end
		else 
			return 61
		end
	elseif isWall(wallnums[2]) and not isWall(wallnums[4]) and not isWall(wallnums[6]) and isWall(wallnums[8]) then -- vwall
		if isFloor(wallnums[4]) then 
			if isFloor(wallnums[6]) then
				return 64
			else
				return 66
			end
		else 
			return 65
		end
	end
	return 60
end

function yopendoorset(wallnums)
	if     not isWall(wallnums[2]) and isWall(wallnums[4]) and isWall(wallnums[6]) and not isWall(wallnums[8]) then -- hwall
		return 53
	else 
		return 57
	end
end

function uniques(inlist)
	local flags = {}
	local outlist = {}
	for i=1,#inlist do
		if not flags[inlist[i]] and inlist[i] ~= 0 and inlist[i] ~= 99 then
			table.insert(outlist, inlist[i])
			flags[inlist[i]] = true
		end
	end
	return outlist
end



function love.load()
	
	loadcheck = false
	loadcheck2 = false
	mloadcheck = false
	mloadcheck2 = false
	runsim = false
	if musicflag ~= true then
		music = love.audio.newSource("DocSteppe.mp3")
		love.audio.play(music)
		musicflag = true
	end
	conclicked = false
	
   huskarl = love.graphics.newImage("huskarl.png")
   dhtitle = love.graphics.newImage("dhtitle.png")
   newgame = love.graphics.newImage("newgame2.png")
   controls = love.graphics.newImage("controls2.png")
   arrowkeys = love.graphics.newImage("arrowkeys.png")
   quit = love.graphics.newImage("quit2.png")
   loading = love.graphics.newImage("loading.png")
   
   grid = love.graphics.newImage("grid3.png")
   dude = love.graphics.newImage("dude.png")
   grid2 = love.graphics.newImage("grid2.png")
   
   wall_h1 = love.graphics.newImage("wall_h1.png")
   wall_h2 = love.graphics.newImage("wall_h2.png")
   wall_h3 = love.graphics.newImage("wall_h3.png")
   wall_v1 = love.graphics.newImage("wall_v1.png")
   wall_v2 = love.graphics.newImage("wall_v2.png")
   wall_v3 = love.graphics.newImage("wall_v3.png")
   corner_1 = love.graphics.newImage("corner_1.png")
   corner_2 = love.graphics.newImage("corner_2.png")
   corner_3 = love.graphics.newImage("corner_3.png")
   corner_4 = love.graphics.newImage("corner_4.png")
   anticorner_1 = love.graphics.newImage("anticorner_1.png")
   anticorner_2 = love.graphics.newImage("anticorner_2.png")
   anticorner_3 = love.graphics.newImage("anticorner_3.png")
   anticorner_4 = love.graphics.newImage("anticorner_4.png")
   tsplit_1 = love.graphics.newImage("3split_1.png")
   tsplit_1a = love.graphics.newImage("3split_1a.png")
   tsplit_1b = love.graphics.newImage("3split_1b.png")
   tsplit_1c = love.graphics.newImage("3split_1c.png")
   tsplit_2 = love.graphics.newImage("3split_2.png")
   tsplit_2a = love.graphics.newImage("3split_2a.png")
   tsplit_2b = love.graphics.newImage("3split_2b.png")
   tsplit_2c = love.graphics.newImage("3split_2c.png")
   tsplit_3 = love.graphics.newImage("3split_3.png")
   tsplit_3a = love.graphics.newImage("3split_3a.png")
   tsplit_3b = love.graphics.newImage("3split_3b.png")
   tsplit_3c = love.graphics.newImage("3split_3c.png")
   tsplit_4 = love.graphics.newImage("3split_4.png")
   tsplit_4a = love.graphics.newImage("3split_4a.png")
   tsplit_4b = love.graphics.newImage("3split_4b.png")
   tsplit_4c = love.graphics.newImage("3split_4c.png")
   fsplit = love.graphics.newImage("4split_1111.png")
   
   fullcorner_1 = love.graphics.newImage("fullcorner_1.png")
   fullcorner_2 = love.graphics.newImage("fullcorner_2.png")
   fullcorner_3 = love.graphics.newImage("fullcorner_3.png")
   fullcorner_4 = love.graphics.newImage("fullcorner_4.png")
   
   
   dooryh_closed = love.graphics.newImage("doorh_closed.png")
   dooryh_closed1 = love.graphics.newImage("doorh_closed1.png")
   dooryh_closed2 = love.graphics.newImage("doorh_closed2.png")
   dooryh_open = love.graphics.newImage("doorh_open.png")
   dooryv_closed = love.graphics.newImage("doorv_closed.png")
   dooryv_closed1 = love.graphics.newImage("doorv_closed1.png")
   dooryv_closed2 = love.graphics.newImage("doorv_closed2.png")
   dooryv_open = love.graphics.newImage("doorv_open.png")
   
   doorh_closed = love.graphics.newImage("doorbh_closed.png")
   doorh_closed1 = love.graphics.newImage("doorbh_closed1.png")
   doorh_closed2 = love.graphics.newImage("doorbh_closed2.png")
   doorh_open = love.graphics.newImage("doorbh_open.png")
   doorv_closed = love.graphics.newImage("doorbv_closed.png")
   doorv_closed1 = love.graphics.newImage("doorbv_closed1.png")
   doorv_closed2 = love.graphics.newImage("doorbv_closed2.png")
   doorv_open = love.graphics.newImage("doorbv_open.png")
   
   doornh_closed = love.graphics.newImage("doornh_closed.png")
   doornh_closed1 = love.graphics.newImage("doornh_closed1.png")
   doornh_closed2 = love.graphics.newImage("doornh_closed2.png")
   doornv_closed = love.graphics.newImage("doornv_closed.png")
   doornv_closed1 = love.graphics.newImage("doornv_closed1.png")
   doornv_closed2 = love.graphics.newImage("doornv_closed2.png")
   
   computer = love.graphics.newImage("computer.png")
   computer_2 = love.graphics.newImage("computer_2.png")
   computer_e = love.graphics.newImage("computer_e.png")
   computer_e2 = love.graphics.newImage("computer_e2.png")
   computer_ded = love.graphics.newImage("computer_ded.png")
   computer_ded1 = love.graphics.newImage("computer_ded1.png")
   
   computer_l = love.graphics.newImage("computer_l.png")
   computer_l2 = love.graphics.newImage("computer_l2.png")
   computer_ly = love.graphics.newImage("computer_ly.png")
   computer_ly2 = love.graphics.newImage("computer_ly2.png")
   
   roomtable = love.graphics.newImage("table1.png")
   roomtable_a = love.graphics.newImage("table_a.png")
   computer_f = love.graphics.newImage("computer_f1.png")
   computer_f2 = love.graphics.newImage("computer_f3.png")
   
   engine1 = love.graphics.newImage("engine1.png")
   engine2a = love.graphics.newImage("engine4a.png")
   engine2b = love.graphics.newImage("engine4b.png")
   engine2c = love.graphics.newImage("engine4c.png")
   engine2d = love.graphics.newImage("engine4d.png")
   
   bed1 = love.graphics.newImage("bed1.png")
   helmconsole1 = love.graphics.newImage("helmconsole1.png")
   helmconsole2 = love.graphics.newImage("helmconsole2.png")
   helmscreen = love.graphics.newImage("helmscreen_2.png")
   helmconsole1_ded = love.graphics.newImage("helmconsole1_ded.png")
   helmconsole2_ded = love.graphics.newImage("helmconsole2_ded.png")
   helmscreen_ded = love.graphics.newImage("helmscreen_ded2.png")
   
   helpscrawl = love.graphics.newImage("wall_help2.png")
   
   co2scrub = love.graphics.newImage("co2scrub.png")
   co2scrub_dep = love.graphics.newImage("co2scrub_dep.png")
   computer_co2 = love.graphics.newImage("computer_co2.png")
   computer_co22 = love.graphics.newImage("computer_co22.png")
   

	stars = {}
	for i=0, 40, 1 do
		table.insert(stars,	{math.random(1024),math.random(768)} )
	end
   
	spin = 0
--   loadgame()
end
   
function loadgame()

	loadcheck = false
	loadcheck2 = false
	mloadcheck = false
	mloadcheck2 = false
    player = {
        grid_x = 2*32,
        grid_y = 2*32,
        act_x =  2*32,
        act_y =  2*32,
		want_x = 2*32,
		want_y = 2*32,
        speed = 10,
		real_oxy = 100,
		see_oxy = 100,
    }
	
	life = {
		nom = 100,
		oxy = 100,
		oxydepletion = 0,
		water = 100,
		sleep = 100,
		security = 0,
		seerooms = {},
		dead = 0,
		explosivedecompression = 200,
		explodir = 0,
		energy = 10,
		deathrooms = {},
		roomdeath = 200,
		
	}
		
	local _ = 0
	
--	print("Starting map generation...")
	theshinymap,theshinyrooms, startry,startrx = mapgen()
--	print("Finished map generation.")
	world = table.spincopy(theshinymap)
	rooms = table.spincopy(theshinyrooms)
	
--	printmap(world)
--	print(" ")
--	printmap(rooms)
	--[[
	startrx = 2
	startry = 2
	world = {
		{2,  2,  2,  2,  2,  2,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{2,  1,  1,  1,  1,  1,  2,  _,  _,  _,  _,  _,  2,  2,132,  2,  2,  _,  2,  2,  2,  2,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{2,  1,100,  1,100,  1,  2,  _,  _,  _,  _,  _,  2,  1,  1,  1,  2,  _,  2,  1,  1,  1,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{2,  1,  1,  1,  1,  1, 50,  _,  _,  _,  _,  _,  2,130,  1,130,  2,  _,  2,  1,  1,  1,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{2,  1,100,  1,  1,  1,  2,  _,  _,  _,  _,  _,  2,130,  1,131,  2,  _,  2,  1,  1,  1,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{2,  2,  2,  2,  1,  1,  2,  _,  _,  _,  _,  _,  2,  2,  1,  2,  2,  _,  2,  2,  1,  2,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _},  
		{_,  _,  _,  2,  1,  1,  2,  _,  _,  _,  _,  _,  _,  2,  1,  2,  _,  _,  _,  2, 50,  2,  _,  _,  2,  2,  2,  2,  2,160,  2,  2},  
		{2,  2,  2,  2, 50, 50,  2,  2,123,  2,  _,  _,  _,  2, 60,  2,  _,  2,  2,  2,  1,  2,  2,  2,  2,  1,  2,  2,  1,  1,  1,  2},  
		{2,  1,  1,  1,  1,  1,  1,120,  1,  2,  2,  2,  2,  2,  1,  2,  2,  2,  1,  1,  1,  1,  1,  2,  2,  1,  2,  2,161,  1,161,  2},  
		{2,120,120,  1,  1,  1,  1,  1,  1,  1, 50,  1,  1,  1,  1,  1, 50,  1,  1,  _,  1,  1,  1, 50,  1,  1,  1, 50,  1,  1,  1,  2},  
		{2,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2,  2,  2,  1,  1,  1,  1,  1,  2,  2,  1,  2,  2,  1,  1,  1,  2},  
		{2,120,121,  1,  1,120,120,120,  1,  2,  _,  _,  _,  _,  _,  _,  _,  2,  2,  2,  2,  2,  2,  2,  2,  1,  2,  2,161,  1,161,  2},  
		{2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  _,  _,  2,  2,  2,  2,  2,  2,  2,  1,  2,  2,  2,  2,  2,  1,  2,  2,  2,  2,  2,  2},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  1,  2,  _,  _,  _,  _,  _},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  1,  2,  2,  2,  2,  2,  2},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  1,  2,  2,  1,  1,  1,  2},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  2,  2,  2,  2,  2,  2,  2,  2, 50,  2,  2,  2,  1,  1, 50,  1,  1,  1,  2},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  2,  2,  2,  2,  2,  2,  1,  2,  2,  2,  1,  2,  2,  1,  1,  1,  2},  
		{_,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  1,  1,  1,  1,  1,  1,  1,  1, 50,  1,  1,  2,  2,  2,  2,  2,  2},  
		{2,  2,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2, 50,  2,  2,  2,  2,  2,  2,  2,  2,  2,  1,  2,  2,  2,  2,  2,  2},  
		{2,  1,  2,  2,  2,  2,  2,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  _,  2,  1,  2,  2,  1,  1,140,  2},  
		{2,  1,  1, 50,  1,  1,  2,  2,  2, 50,  2,  2,  2,102,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 50,  2,  2,  1,141,142,  2},  
		{2,  1,  2,  2,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, 60,140,143,144,  2},  
		{2,  2,  2,  _,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2},  
	}

	rooms = {
		{0, 0, 0, 0, 0, 0, 0, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{0, 1, 1, 1, 1, 1, 0, _, _, _, _, _, 0, 0, 0, 0, 0, _, 0, 0, 0, 0, 0, _, _, _, _, _, _, _, _, _}, 
		{0, 1, 1, 1, 1, 1, 0, _, _, _, _, _, 0, 4, 4, 4, 0, _, 0, 5, 5, 5, 0, _, _, _, _, _, _, _, _, _}, 
		{0, 1, 1, 1, 1, 1, 0, _, _, _, _, _, 0, 4, 4, 4, 0, _, 0, 5, 5, 5, 0, _, _, _, _, _, _, _, _, _}, 
		{0, 1, 1, 1, 1, 1, 0, _, _, _, _, _, 0, 4, 4, 4, 0, _, 0, 5, 5, 5, 0, _, _, _, _, _, _, _, _, _}, 
		{0, 0, 0, 0, 1, 1, 0, _, _, _, _, _, 0, 0, 4, 0, 0, _, 0, 0, 5, 0, 0, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, 0, 1, 1, 0, _, _, _, _, _, _, 0, 4, 0, _, _, _, 0,99, 0, _, _, 0, 0, 0, 0, 0, 0, 0, 0}, 
		{0, 0, 0, 0,99,99, 0, 0, 0, 0, _, _, _, 0,99, 0, _, 0, 0, 0, 6, 0, 0, 0, 0, 7, 0, 0, 8, 8, 8, 0}, 
		{0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 7, 0, 0, 8, 8, 8, 0}, 
		{0, 2, 2, 2, 2, 2, 2, 2, 2, 2,99, 3, 3, 3, 3, 3,99, 6, 6, 6, 6, 6, 6,99, 7, 7, 7,99, 8, 8, 8, 0}, 
		{0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 0, 0, 7, 0, 0, 8, 8, 8, 0}, 
		{0, 2, 2, 2, 2, 2, 2, 2, 2, 0, _, _, _, _, _, _, _, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 8, 8, 8, 0}, 
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, _, _, 0, 0, 0, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, 0,14,14,14,14,14,14,14,14,14,14, 0, 0, 7, 0, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, 0,14,14,14,14,14,14,14,14,14,14, 0, 0, 7, 0, 0, 0, 0, 0, 0}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, 0,14,14,14,14,14,14,14,14,14,14, 0, 0, 7, 0, 0, 9, 9, 9, 0}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, 0, 0, 0, 0, 0, 0, 0, 0, 0,99, 0, 0, 0, 7, 7,99, 9, 9, 9, 0}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, 0, 0, 0, 0, 0, 0, 0,13, 0, 0, 0, 7, 0, 0, 9, 9, 9, 0}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, 0,13,13,13,13,13,13,13,13,99, 7, 7, 0, 0, 0, 0, 0, 0}, 
		{0, 0, 0, _, _, _, _, _, _, _, _, _, _, _, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0}, 
		{0,12, 0, 0, 0, 0, 0, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, 0, 7, 0, 0,10,10,10, 0}, 
		{0,12,12,99,11,11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,99, 0, 0,10,10,10, 0}, 
		{0,12, 0, 0, 0,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,99,10,10,10, 0}, 
		{0, 0, 0, _, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
	}
	]]--
	map = {
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		{_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}, 
		
	}
		
	
	startrc = {0,0}
	for r in ipairs(world) do
		for c in ipairs(world[r]) do
			if world[r][c] == 1 then
				startrc[1] = r
				startrc[2] = c
			end
		end
	end
	--startrx = 2
	--startry = 2
	
	
	roomoxylist = {}
	
	local therooms = {}
	
	
	
	--[[
	for n in ipairs(rooms) do
		for m in ipairs(rooms[n]) do
			print(rooms[n][m])
		end
	end
	]]--
	
	
	for n in ipairs(rooms) do 
		local lis = uniques(rooms[n])
		for l in ipairs(lis) do
			table.insert(therooms,lis[l])
		end
	end
	local therooms = uniques(therooms)
	
	for r in ipairs(therooms) do
		roomoxylist[therooms[r]] = math.random(0,100)
	end
	
	for i in ipairs(rooms) do
		for j in ipairs(rooms[i]) do
			if world[i][j] == 140 then
			table.insert(life.deathrooms,rooms[i][j])
			end
		end
	end
	
	roomoxylist[99] = 99

	
--	print(startry," ",startrx)
	
	player.grid_x = startry*32
    player.grid_y = startrx*32
	
	player.act_x = startry*32
    player.act_y = startrx*32
	
	player.want_x = startry*32
    player.want_y = startrx*32
	
--	print(player.want_x," ",player.want_y)
	
	startoxy = math.random(50,100)
	roomoxylist[rooms[startrx][startry]] = startoxy
	life.oxy = startoxy+5
		
	roomsee()
end

function roomsee()
	playerpt = {player.want_y/32,player.want_x/32}
	
--	print("Player point  " .. playerpt[1] .. " " .. playerpt[2])
	--for each point in the 3x3 around the current player do
		-- add room to the visible rooms list
	for i=-1,1,1 do 
		for j=-1,1,1 do 
			--if rooms[playerpt[1]+i][playerpt[2]+j] ~= 0 then
				--print(playerpt[1]+i , playerpt[2]+j, rooms[playerpt[1]+i][playerpt[2]+j])
				table.insert(life.seerooms,rooms[playerpt[1]+i][playerpt[2]+j])
			--end
		end
	end

	-- remove duplicates
	--for x=1,#life.seerooms do print(life.seerooms[x]) end
--	print(" ")
	life.seerooms = uniques(life.seerooms)
	
	-- new blank map
	map = {}
	for i=1,24 do
		newrow = {}
		for j=1,32 do
			table.insert(newrow,0)
		end
		table.insert(map,newrow)
	end
	
	-- for each point on the room grid do
		-- if it's on the visible rooms list
			--copy its world value onto the map
	for i=1,#rooms do
		for j=1,#rooms[i] do
			if rooms[i][j] ~= 0 then
				for n=1,#life.seerooms do
					if rooms[i][j] == life.seerooms[n] then
						map[i][j] = world[i][j]
					end
				end
			end
		end
	end
	
	-- for each point on the world do
	-- if it's a wall
		-- check its 3x3 on the map
		-- if there's a visible point in the 3x3 then
			-- mark it as a generic wall
	-- if it's a door
		-- check its 3x3
		-- if there's a visible point then
			-- mark it as a door
	
	wallmap = {}
	for i=1,24 do
		newrow = {}
		for j=1,32 do
			table.insert(newrow,0)
		end
		table.insert(wallmap,newrow)
	end
	
		for i=1,#world do
			for j=1,#world[i] do
				--if world[i][j] == 2 then -- walls
					local wallvis = false
					for k=-1,1,1 do
						for l=-1,1,1 do
							if i+k > 0 and i+k <= 24 
							and j+l > 0 and j+l <= 32 then
								if map[i+k][j+l] ~= 0 then wallvis = true end
							end
						end
					end
					if wallvis then wallmap[i][j] = world[i][j] end
				--elseif world[i][j] == 23 then -- h door
					
				--end
			end
		end

		for i=1,#world do
			for j=1,#world[i] do
				if wallmap[i][j] ~= 0 then
					map[i][j] = wallmap[i][j]
				end
			end
		end
		
	wallslots = {}
	for i=1,24 do
		newrow = {}
		for j=1,32 do
			table.insert(newrow,0)
		end
		table.insert(wallslots,newrow)
	end
		
		-- Identify each wall!
	
	for i=1,#map do
		for j=1,#map[i] do
			if map[i][j] == 2 or map[i][j] == 50 or map[i][j] == 53 
			or map[i][j] == 60 or map[i][j] == 63
			then
				wallstring = {}
				
				if i-1 < 1 or j-1 < 1 then table.insert(wallstring,0) 
				elseif isFloor(map[i-1][j-1]) then table.insert(wallstring,1)
				elseif isWall(map[i-1][j-1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				if i-1 < 1 then table.insert(wallstring,0)
				elseif isFloor(map[i-1][j]) then table.insert(wallstring,1)
				elseif isWall(map[i-1][j]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				if i-1 < 1 or j+1 > 32 then table.insert(wallstring,0)
				elseif isFloor(map[i-1][j+1]) then table.insert(wallstring,1)
				elseif isWall(map[i-1][j+1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				
				if j-1 < 1 then table.insert(wallstring,0)
				elseif isFloor(map[i][j-1]) then table.insert(wallstring,1)
				elseif isWall(map[i][j-1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				table.insert(wallstring,1)
								
				if j+1 > 32 then table.insert(wallstring,0)
				elseif isFloor(map[i][j+1]) then table.insert(wallstring,1)
				elseif isWall(map[i][j+1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				
				if i+1 > 24 or j-1 < 1 then table.insert(wallstring,0)
				elseif isFloor(map[i+1][j-1]) then table.insert(wallstring,1)
				elseif isWall(map[i+1][j-1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				if i+1 > 24 then table.insert(wallstring,0)
				elseif isFloor(map[i+1][j]) then table.insert(wallstring,1)
				elseif isWall(map[i+1][j]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				if i+1 > 24 or j+1 > 32 then table.insert(wallstring,0)
				elseif isFloor(map[i+1][j+1]) then table.insert(wallstring,1)
				elseif isWall(map[i+1][j+1]) then table.insert(wallstring,2)
				else table.insert(wallstring,0) end
				
				if map[i][j] == 2 then
					wallslots[i][j] = wallset(wallstring)
				elseif map[i][j] == 50 then
					wallslots[i][j] = doorset(wallstring)
				elseif map[i][j] == 53 then
					wallslots[i][j] = opendoorset(wallstring)
				elseif map[i][j] == 60 then
					wallslots[i][j] = ydoorset(wallstring)
				elseif map[i][j] == 63 then
					wallslots[i][j] = yopendoorset(wallstring)
					
				end
			end
		end
	end
	
	for i=1,#map do
		for j=1,#map[i] do
			if wallslots[i][j] ~= 0 then
				map[i][j] = wallslots[i][j]
			end
		end
	end
	
	--[[
	-- Old algorithm
		for i=1,#map do
			for j=1,#map[i] do
				if map[i][j] == 2 then -- it's a wall
					if i+1 > 24 then --0___
					end
					if j+1 > 32 then --_0__
					end
					if i-1 < 1 then  --
					end
					if j-1 < 1 then
					end
				
				
				
				
					if i+1 <= 24 and map[i+1][j] == 1 then 					--1
						if j+1 <= 32 and map[i][j+1] == 1 then 				--11
							if i-1 > 0 and map[i-1][j] == 1 then 			--111
								if j-1 > 0 and map[i][j-1] == 1 then 			--1111
									wallslots[i][j] = 3
								else 											--1110
									wallslots[i][j] = 4
								end
							else 											--110
								if j-1 > 0 and map[i][j-1] == 1 then 			--1101
									wallslots[i][j] = 5
								else											--1100
									wallslots[i][j] = 6
								end
							end
						else												--10
							if i-1 > 0 and map[i-1][j] == 1 then 			--101
								if j-1 > 0 and map[i][j-1] == 1 then 			--1011
									wallslots[i][j] = 7
								else 											--1010
									wallslots[i][j] = 8
								end
							else 											--100
								if j-1 > 0 and map[i][j-1] == 1 then 			--1001
									wallslots[i][j] = 9
								else											--1000
									wallslots[i][j] = 10
								end
							end
						end
					else													--0
						if j+1 <= 32 and map[i][j+1] == 1 then 				--01
							if i-1 > 0 and map[i-1][j] == 1 then 			--011
								if j-1 > 0 and map[i][j-1] == 1 then 			--0111
									wallslots[i][j] = 11
								else 											--0110
									wallslots[i][j] = 12
								end
							else 											--010
								if j-1 > 0 and map[i][j-1] == 1 then 			--0101
									wallslots[i][j] = 13
								else											--0100
									wallslots[i][j] = 4
								end
							end
						else												--00
							if i-1 > 0 and map[i-1][j] == 1 then 			--001
								if j-1 > 0 and map[i][j-1] == 1 then 			--0011
									wallslots[i][j] = 15
								else 											--0010
									wallslots[i][j] = 16
								end
							else 											--000
								if j-1 > 0 and map[i][j-1] == 1 then 			--0001
									wallslots[i][j] = 17
								else											--0000
									wallslots[i][j] = 30
								end
							end
						end
					end
				end
			end
		end
		
		for i=1,#map do
			for j=1,#map[i] do
				if wallslots[i][j] ~= 0 then
					map[i][j] = wallslots[i][j]
				end
			end
		end
	]]--
	
	-- for each point on the map do
		-- if it's a wall
			-- check neighbours, mark the type of wall it should be
		-- if it's a door
			-- check neighbours, mark the type of door it should be
end

local function unlock()
	for i in ipairs(world) do
		for j in ipairs(world[i]) do
			if world[i][j] == 60 then
				world[i][j] = 50
			elseif world[i][j] == 61 then
				world[i][j] = 51
			elseif world[i][j] == 62 then
				world[i][j] = 52
			elseif world[i][j] == 63 then
				world[i][j] = 53
			elseif world[i][j] == 64 then
				world[i][j] = 54
			elseif world[i][j] == 65 then
				world[i][j] = 55
			elseif world[i][j] == 66 then
				world[i][j] = 56
			elseif world[i][j] == 67 then
				world[i][j] = 57
			end

			if map[i][j] == 60 then
				map[i][j] = 50
			elseif map[i][j] == 61 then
				map[i][j] = 51
			elseif map[i][j] == 62 then
				map[i][j] = 52
			elseif map[i][j] == 63 then
				map[i][j] = 53
			elseif map[i][j] == 64 then
				map[i][j] = 54
			elseif map[i][j] == 65 then
				map[i][j] = 55
			elseif map[i][j] == 66 then
				map[i][j] = 56
			elseif map[i][j] == 67 then
				map[i][j] = 57
			end
		end
	end
end

function love.update(dt)
	local simspeed = 1
	if dt>1 then deltat = simspeed else deltat = simspeed*dt end
	
	if #stars < 40 then
		table.insert(stars,	{1025,math.random(768)} )
	end
	
	for star in ipairs(stars) do
		stars[star][1] = stars[star][1] - 10*deltat
		if stars[star][1] < 0 then
			table.remove(stars,star)
		end
	end
	
if mainmenu then
	spin = spin + 0.02*deltat
else
	if runsim then
		
	if life.explodir == 0 then
		player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * deltat)
		player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * deltat)
	end
	if life.explosivedecompression>50 then
	if life.explodir == 1 then
		player.act_y = player.act_y + 0.6*(life.explosivedecompression-50)*10 * deltat
	elseif life.explodir == 2 then
		player.act_y = player.act_y - 0.6*(life.explosivedecompression-50)*10 * deltat
	elseif life.explodir == 3 then
		player.act_x = player.act_x + 0.6*(life.explosivedecompression-50)*10 * deltat
	elseif life.explodir == 4 then
		player.act_x = player.act_x - 0.6*(life.explosivedecompression-50)*10 * deltat
	end
	end
	

	
	life.energy = life.energy + 1*deltat
	
	life.oxydepletion = life.oxydepletion + 2.5*deltat
	local oxyavgl = {}
	for n in ipairs(life.seerooms) do
		table.insert(oxyavgl,roomoxylist[life.seerooms[n]])
	end
	oxyavg = 0
	for n in ipairs(oxyavgl) do
		oxyavg = oxyavg + oxyavgl[n]
	end
	oxyavg = oxyavg / #oxyavgl
	life.oxy = oxyavg - life.oxydepletion + #oxyavgl*5
	
	player.see_oxy = player.see_oxy - (player.see_oxy - life.oxy)*1*deltat
	
	if life.oxy < 0 then
		life.dead = 3
	end
	
	if life.nom > 100 then life.nom = 100 end
	life.nom = life.nom - 1.0*deltat
	
	if life.nom < 0 then 
		life.dead = 1 
	end
	
	if life.explosivedecompression < 200 then
		life.explosivedecompression = life.explosivedecompression - 100*deltat
		if life.explosivedecompression < 0 then
			life.dead = 2
		end
	end
	if life.roomdeath < 200 and life.explosivedecompression == 200 then
		life.roomdeath = life.roomdeath -100*deltat
		if life.roomdeath < 0 then
			life.dead = 7
		end
	end
	
	local nomspeed = 1
	if life.nom < 40 then nomspeed = life.nom/40 end
	local oxyspeed = 1
	if life.oxy < 30 then oxyspeed = life.oxy/30 end
	
	player.speed = 10 * nomspeed * oxyspeed
	
end
	
end
end

function love.draw()

if mainmenu then
	for star in ipairs(stars) do
		love.graphics.rectangle("fill", stars[star][1], stars[star][2], 2, 2)
--		love.graphics.draw(grid, stars[star][1],stars[star][2],0, 1, 1)
	end
	
	love.graphics.draw(huskarl, 700,350,spin, 1, 1, 580/2,580/2)
	love.graphics.draw(dhtitle, 89,290,0, 0.5, 0.5)
	love.graphics.draw(newgame, 89,393,0, 1,1)
	love.graphics.draw(controls,89,393+28,0, 1,1)
	if conclicked then
		love.graphics.draw(arrowkeys,89+122,393+28,0, 1,1)
	end
	love.graphics.draw(quit,    89,393+28+28,0, 1,1)
	
	
	if mloadcheck2 then
		mainmenu = false
		loadgame()
	end
	if mloadcheck then
		love.graphics.draw(loading, 89+122,393,0, 1,1)
		mloadcheck2 = true
	end
		
	
	
else
	if life.nom < 40 then
		love.graphics.setColor( 255,255,255,255*(life.nom/40) )
	else
		love.graphics.setColor( 255,255,255,255 )
	end
	
	for star in ipairs(stars) do
		love.graphics.rectangle("fill", stars[star][1], stars[star][2], 2, 2)
--		love.graphics.draw(grid, stars[star][1],stars[star][2],0, 1, 1)
	end
	
	
	for i=1,table.getn(map) do
		for j=1,table.getn(map[i]) do
			if map[i][j] == 1 then
				love.graphics.draw(grid, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 2 then
--				love.graphics.draw(wall_h1, 32*j-32,32*i-32,0, 1, 1)
				love.graphics.draw(wall_h1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 3 then
				love.graphics.draw(wall_h2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 4 then
				love.graphics.draw(wall_v1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 5 then
				love.graphics.draw(wall_v2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 6 then
				love.graphics.draw(corner_1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 7 then
				love.graphics.draw(corner_2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 8 then
				love.graphics.draw(corner_3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 9 then
				love.graphics.draw(corner_4, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 10 then
				love.graphics.draw(anticorner_1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 11 then
				love.graphics.draw(anticorner_2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 12 then
				love.graphics.draw(anticorner_3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 13 then
				love.graphics.draw(anticorner_4, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 14 then
				love.graphics.draw(tsplit_1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 15 then
				love.graphics.draw(tsplit_1a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 16 then
				love.graphics.draw(tsplit_1b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 17 then
				love.graphics.draw(tsplit_1c, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 18 then
				love.graphics.draw(tsplit_2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 19 then
				love.graphics.draw(tsplit_2a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 20 then
				love.graphics.draw(tsplit_2b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 21 then
				love.graphics.draw(tsplit_2c, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 22 then
				love.graphics.draw(tsplit_3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 23 then
				love.graphics.draw(tsplit_3a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 24 then
				love.graphics.draw(tsplit_3b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 25 then
				love.graphics.draw(tsplit_3c, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 26 then
				love.graphics.draw(tsplit_4, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 27 then
				love.graphics.draw(tsplit_4a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 28 then
				love.graphics.draw(tsplit_4b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 29 then
				love.graphics.draw(tsplit_4c, 32*j-32,32*i-32,0, 1, 1)
				
			elseif map[i][j] == 30 then
				love.graphics.draw(wall_h3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 31 then
				love.graphics.draw(wall_v3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 32 then
				love.graphics.draw(fullcorner_1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 33 then
				love.graphics.draw(fullcorner_2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 34 then
				love.graphics.draw(fullcorner_3, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 35 then
				love.graphics.draw(fullcorner_4, 32*j-32,32*i-32,0, 1, 1)
				
			--[[				
			elseif map[i][j] == 30 then
				love.graphics.draw(computer, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 31 then
				love.graphics.draw(computer_2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 32 then
				love.graphics.draw(computer_l, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 33 then
				love.graphics.draw(computer_l2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 34 then
				love.graphics.draw(computer_ly, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 35 then
				love.graphics.draw(computer_ly2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 36 then
				love.graphics.draw(computer_e, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 37 then
				love.graphics.draw(computer_e2, 32*j-32,32*i-32,0, 1, 1)
				

				
				]]--
				
			elseif map[i][j] == 50 then
				if life.energy > 5 then
					love.graphics.draw(doorh_closed, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornh_closed, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 51 then
				if life.energy > 5 then
					love.graphics.draw(doorh_closed1, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornh_closed1, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 52 then
				if life.energy > 5 then
					love.graphics.draw(doorh_closed2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornh_closed2, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 53 then
				love.graphics.draw(doorh_open, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 54 then
				if life.energy > 5 then
					love.graphics.draw(doorv_closed, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornv_closed, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 55 then
				if life.energy > 5 then
					love.graphics.draw(doorv_closed1, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornv_closed1, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 56 then
				if life.energy > 5 then
					love.graphics.draw(doorv_closed2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(doornv_closed2, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 57 then
				love.graphics.draw(doorv_open, 32*j-32,32*i-32,0, 1, 1)
				
			elseif map[i][j] == 60 then
				love.graphics.draw(dooryh_closed, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 61 then
				love.graphics.draw(dooryh_closed1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 62 then
				love.graphics.draw(dooryh_closed2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 63 then
				love.graphics.draw(dooryh_open, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 64 then
				love.graphics.draw(dooryv_closed, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 65 then
				love.graphics.draw(dooryv_closed1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 66 then
				love.graphics.draw(dooryv_closed2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 67 then
				love.graphics.draw(dooryv_open, 32*j-32,32*i-32,0, 1, 1)
				
				--[[
			elseif map[i][j] == 70 then
				love.graphics.draw(engine1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 71 then
				love.graphics.draw(engine2a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 72 then
				love.graphics.draw(engine2b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 73 then
				love.graphics.draw(engine2c, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 74 then
				love.graphics.draw(engine2d, 32*j-32,32*i-32,0, 1, 1)
				
				]]--
			elseif map[i][j] == 99 then
				love.graphics.draw(fsplit, 32*j-32,32*i-32,0, 1, 1)
				
				
			elseif map[i][j] == 100 then
				love.graphics.draw(bed1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 101 then
				if life.energy > 5 then
					love.graphics.draw(computer_2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 102 then
				if life.energy > 5 then
					love.graphics.draw(computer_ly2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 103 then
				love.graphics.draw(computer_e2, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 104 then
				if life.energy > 5 then
					love.graphics.draw(computer_l2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
				
				
			elseif map[i][j] == 120 then
				love.graphics.draw(roomtable, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 121 then
				love.graphics.draw(roomtable_a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 122 then
				if life.energy > 30 then
					love.graphics.draw(computer_f2, 32*j-32,32*i-32,0, 1, 1)
				elseif life.energy > 5 then
					love.graphics.draw(computer_2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 123 then
				if life.energy > 30 then
					love.graphics.draw(computer_f, 32*j-32,32*i-32,0, 1, 1)
				elseif life.energy > 5 then
					love.graphics.draw(computer, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
				
				
				
				
			elseif map[i][j] == 130 then
				if life.energy > 5 then
					love.graphics.draw(helmconsole1, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(helmconsole1_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 131 then
				if life.energy > 5 then
					love.graphics.draw(helmconsole2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(helmconsole2_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 132 then
				love.graphics.draw(helmscreen, 32*j-32,32*i-32,0, 1, 1)
				if life.energy > 50 then
					love.graphics.draw(helmscreen, 32*j-32,32*i-32,0, 1, 1)
					if life.nom < 40 then
						love.graphics.setColor( 0,255,0,255*(life.nom/40) )
					else
						love.graphics.setColor( 0,255,0,255 )
					end
					love.graphics.rectangle("fill",32*j-32 +4, 32*i-32 +10, 24, 10)
					if life.nom < 40 then
						love.graphics.setColor( 255,255,255,255*(life.nom/40) )
					else
						love.graphics.setColor( 255,255,255,255 )
					end
				else
					love.graphics.draw(helmscreen_ded, 32*j-32,32*i-32,0, 1, 1)
					if life.nom < 40 then
						love.graphics.setColor( 255,0,0,255*(life.nom/40) )
					else
						love.graphics.setColor( 255,0,0,255 )
					end
					love.graphics.rectangle("fill",32*j-32 +4, 32*i-32 +10, life.energy * (24/50), 10)
					if life.nom < 40 then
						love.graphics.setColor( 255,255,255,255*(life.nom/40) )
					else
						love.graphics.setColor( 255,255,255,255 )
					end
				end
			elseif map[i][j] == 133 then
				love.graphics.draw(helmconsole1_ded, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 134 then
				love.graphics.draw(helmconsole2_ded, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 135 then
				love.graphics.draw(helmscreen_ded, 32*j-32,32*i-32,0, 1, 1)
				
			elseif map[i][j] == 140 then
				love.graphics.draw(engine1, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 141 then
				love.graphics.draw(engine2a, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 142 then
				love.graphics.draw(engine2b, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 143 then
				love.graphics.draw(engine2c, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 144 then
				love.graphics.draw(engine2d, 32*j-32,32*i-32,0, 1, 1)
				
			elseif map[i][j] == 150 then
				love.graphics.draw(helpscrawl, 32*j-32,32*i-32,0, 1, 1)
				
			elseif map[i][j] == 160 then
				if life.energy > 35 then
					love.graphics.draw(computer_co22, 32*j-32,32*i-32,0, 1, 1)
				elseif life.energy > 5 then
					love.graphics.draw(computer_2, 32*j-32,32*i-32,0, 1, 1)
				else
					love.graphics.draw(computer_ded, 32*j-32,32*i-32,0, 1, 1)
				end
			elseif map[i][j] == 161 then
				love.graphics.draw(co2scrub, 32*j-32,32*i-32,0, 1, 1)
			elseif map[i][j] == 162 then
				love.graphics.draw(co2scrub_dep, 32*j-32,32*i-32,0, 1, 1)
			end
		end
	end
			
	
    love.graphics.draw(dude, player.act_x-32, player.act_y-32,0, 1,1)
	
	love.graphics.setColor( 80,80,80,255 )
			love.graphics.rectangle("fill",736,0,32*9,32*4)
--	for i=1,5 do
--		for j=32-8,32 do
--			love.graphics.rectangle("fill",32*j-32,32*i-32,32,32)
--		end
--	end
	love.graphics.setColor( 255,255,255,255 )
	
	love.graphics.print("Food:",746,12*1)
	love.graphics.rectangle("fill",816,12*1,2*life.nom,12)
	
	love.graphics.print("Oxygen:",746,12*3)
	love.graphics.rectangle("fill",816,12*3,2*life.oxy,12)
	
	love.graphics.print("Pressure:",746,12*5)
	love.graphics.rectangle("fill",816,12*5,life.explosivedecompression,12)
	
	love.graphics.print("Energy:",746,12*7)
	love.graphics.rectangle("fill",816,12*7,4*life.energy,12)
			
	
	--[[
	love.graphics.print(life.nom, 824, 26)
	love.graphics.print(rooms[player.want_y/32][player.want_x/32],824,40)
	if roomoxylist[rooms[player.want_y/32][player.want_x/32] ] then
		love.graphics.print(roomoxylist[rooms[player.want_y/32][player.want_x/32] ],824,66)
	end
	love.graphics.print(life.oxy,824,88)
	love.graphics.print(life.energy,824,110)
	love.graphics.print(life.explosivedecompression, 824, 66)
	]]--
	
	
	if player.see_oxy < 40 then
		love.graphics.setColor( 255,255,255,255-255*(player.see_oxy/40) )
		love.graphics.rectangle("fill", 0, 0, 1024, 768)
	end
	
	
	
	
	if life.dead ~= 0 then
		runsim = false
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle("fill", 0, 0, 1024, 768)
		love.graphics.setColor(255,255,255,255)
		love.graphics.print("Press any key to retry.",312,410)
		if life.dead == 99 then
			love.graphics.print("Congratulations!", 312, 350)
			love.graphics.print("You reactivated the helm computer and put the spacecraft back on course", 312, 370)
			love.graphics.print("towards, um, probably somewhere with more food and oxygen and stuff.", 312, 390)
		elseif life.dead == 1 then
			love.graphics.print("You died of starvation.", 312, 350)
		elseif life.dead == 2 then
			love.graphics.print("You died of explosive decompression.", 312, 350)
			--love.graphics.print("You died in some bizarre way that I don't really understand. What were you doing there?", 412, 350)
		elseif life.dead == 3 then
			love.graphics.print("You died of oxygen depletion.", 312, 350)
		elseif life.dead == 7 then
			love.graphics.print("You found the engine, and died of engine radiation poisoning.", 312, 350)
		else
			love.graphics.print("You died in some bizarre way that I don't really understand. What were you doing there?", 312, 350)
		end
	end
	if loadcheck2 then
		loadgame()
	end
	if loadcheck then
		love.graphics.print("Loading...",312,470)
		loadcheck2 = true
	end
end

end
	
	

function love.keypressed(key)
if key == 'escape' then love.event.push('q') end
	
if not mainmenu then
	runsim = true
	
	if life.dead ~= 0 then
		loadcheck = true
	end
	
	if life.explosivedecompression == 200 and life.roomdeath == 200 then
		
		if key == "up" then
			player.want_y = player.grid_y - 32
		elseif key == "down" then
			player.want_y = player.grid_y + 32
		elseif key == "left" then
			player.want_x = player.grid_x - 32
		elseif key == "right" then
			player.want_x = player.grid_x + 32
		end
		
	end

		
	if world[player.want_y/32][player.want_x/32] == 102
	then
		world[player.want_y/32][player.want_x/32] = 104
		map[player.want_y/32][player.want_x/32] = 104
		unlock()
		if life.security < 1 then life.security = 1 end
		
	elseif world[player.want_y/32][player.want_x/32] == 121 -- apple on table
	then
		world[player.want_y/32][player.want_x/32] = 120
		map[player.want_y/32][player.want_x/32] = 120
		life.nom = life.nom + 60
		
	elseif world[player.want_y/32][player.want_x/32] == 122 and life.energy > 30 -- food dispenser
	then
		life.nom = life.nom + 60
		life.energy = life.energy - 10
		
	elseif world[player.want_y/32][player.want_x/32] == 123 and life.energy > 30-- food dispenser
	then
		life.nom = life.nom + 60
		life.energy = life.energy - 10
		
	elseif world[player.want_y/32][player.want_x/32] == 103 -- energy computer
	then
		world[player.want_y/32][player.want_x/32] = 101
		map[player.want_y/32][player.want_x/32] = 101
		life.energy = life.energy + 10
		
		
	elseif world[player.want_y/32][player.want_x/32] == 161 -- co2 scrubber
	--and life.energy > 30 -- co2 scrubber
	then
		--life.energy = life.energy - 10
		life.oxydepletion = 0
		map[player.want_y/32][player.want_x/32] = 162
		world[player.want_y/32][player.want_x/32] = 162
		
	elseif world[player.want_y/32][player.want_x/32] == 160 and life.energy > 35 -- co2 computer
	then
		for i in ipairs(world) do
			for j in ipairs(world[i]) do
				if world[i][j] == 162 then
					world[i][j] = 161
					map[i][j] = 161
				end
			end
		end
		life.energy = life.energy - 20
		
	elseif (world[player.want_y/32][player.want_x/32] == 130
	or      world[player.want_y/32][player.want_x/32] == 131)
	and life.energy > 50 -- helm
	then
		life.dead = 99
		--energy
		
--[[	elseif world[player.want_y/32][player.want_x/32] == 37
	then
		world[player.want_y/32][player.want_x/32] = 31
		map[player.want_y/32][player.want_x/32] = 31
		--energy
]]--
		
	elseif world[player.want_y/32][player.want_x/32] == 50 and life.energy > 5
	then
		life.energy = life.energy - 5
		world[player.want_y/32][player.want_x/32] = 53
		map[player.want_y/32][player.want_x/32] = 53
		player.grid_x = player.want_x
		player.grid_y = player.want_y
		roomsee()
		
		for f in ipairs(life.seerooms) do
			for g in ipairs(life.deathrooms) do
				if life.seerooms[f] == life.deathrooms[g] then
					life.roomdeath = 120
				end
			end
		end
		
		
		if map[(player.want_y/32) +1][player.want_x/32] == 0
		then 
			life.explosivedecompression = 100 -- explosive decompression
			life.explodir = 1
		
		elseif map[(player.want_y/32) -1][player.want_x/32] == 0
		then 
			life.explosivedecompression = 100 -- explosive decompression
			life.explodir = 2
		elseif map[player.want_y/32][(player.want_x/32)+1] == 0
		then 
			life.explosivedecompression = 100 -- explosive decompression
			life.explodir = 3
		elseif map[player.want_y/32][(player.want_x/32)-1] == 0
		then 
			life.explosivedecompression = 100 -- explosive decompression
			life.explodir = 4
		end
		
		
	end
		
	if world[player.want_y/32][player.want_x/32] == 1 
	or world[player.want_y/32][player.want_x/32] == 53 
	or world[player.want_y/32][player.want_x/32] == 57 
	or world[player.want_y/32][player.want_x/32] == 120
	or world[player.want_y/32][player.want_x/32] == 161
	then
		player.grid_x = player.want_x
		player.grid_y = player.want_y
		if rooms[player.want_y/32][player.want_x/32] == 99 then roomsee()
		end
	else 
		player.want_x = player.grid_x
		player.want_y = player.grid_y
	end
	

end
end

function love.mousereleased(x, y, button)
	if mainmenu then
		if button == 'l' then
			--[[
			love.graphics.draw(huskarl, 700,350,spin, 1, 1, 580/2,580/2)
			love.graphics.draw(dhtitle, 89,290,0, 0.5, 0.5)
			love.graphics.draw(newgame, 89,393,0, 1,1)
			love.graphics.draw(controls,89,393+28,0, 1,1)
			]]--
			if y > 393 and y < 393+28 then 
				mloadcheck = true
			end
			if y > 393+28 and y < 393+28+28 then conclicked = true end
			if y > 393+28+28 and y < 393+28+28+28 then love.event.push('q') end
		end
	end
end
