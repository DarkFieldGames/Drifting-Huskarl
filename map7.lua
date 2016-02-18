require "bucketfill"
function mapgen ()



math.randomseed( os.time() )
map = {}    -- map array
uncorrimap = {} -- map to revert to if corridor generation fails so can restart with the corridor generation
corrimap = {} -- corrigentest array
testjoinmap = {}
roommap = {}

finalcheckmap = {}

mapmax_x = 32
mapmax_y = 24

hungerarea_x = 9
hungerarea_y = 6

game_playable = false
while game_playable == false do
buckettest = false
buckettestfinal = false
while buckettest == false do
buckettest = true
corridor_generation_test_confirm = false
while corridor_generation_test_confirm == false do
corridor_level_generation_attempt = 0
map_gen_fine = false

corri_start_loc_x = {}
corri_start_loc_y = {}
corri_end_loc_x = {}
corri_end_loc_y = {}
corri_start_direction = {}
corri_end_direction = {}

while map_gen_fine == false do
-- resets the specialist rooms
air_purification_number = 0
helm_room_number = 0
engine_room_number = 0
dining_room_number = 0

check_rad_helm = 10 -- position of helm from the bedroom
rad_terminal_from_bedroom = 9
rad_terminal_from_helm = 5
rad_engine_from_terminal = 5
rad_engine_from_bedroom = 2
rad_engine_from_helm = 2


map_room_cord_x = {}
map_room_cord_y = {}
map_room_size_x = {}
map_room_size_y = {}
roommap = {}
corridorbucket = {}
total_rooms_placed = 0

-- 0 is no connection
-- 1 is connection

map_room_count = math.random(6,8)
corridor_number_spawn = map_room_count + math.random(5,9)

-- creates and sets the array to 0 (i.e default)
for i=1, mapmax_x do
   map[i] = {}
   uncorrimap[i] = {}
   corrimap[i] = {}
   testjoinmap[i] = {}
   roommap[i] = {}
   corridorbucket[i] = {}
   finalcheckmap[i] = {}
   for j=1, mapmax_y do
      map[i][j] = 0
      uncorrimap[i][j] = 0
      corrimap[i][j] = 0
      testjoinmap[i][j] = 0
      roommap[i][j] = 0
      corridorbucket[i][j] = 0
      finalcheckmap[i][j] = 0
   end
end

for i=1, map_room_count do
  map_room_cord_x[i] = 0
  map_room_cord_y[i] = 0
  map_room_size_x[i] = 0
  map_room_size_y[i] = 0
end


-- auto room generation.


-- create start and end areas

-- first room = start area
-- other rooms = other rooms


for gen = 1,map_room_count do
    failure_placement_counter = 0
    roomplaced = false
    check = false
    room_place_attempt = false
    while roomplaced == false and failure_placement_counter < 15 do
      room_place_attempt = false
      failure_placement_counter = failure_placement_counter + 1
      array_sum = 0 -- checks to see if all empty space values are 0
      if gen == 1 then -- (spawn the start area) anywhere
      room_size_x = math.random(3,6)
      room_size_y = math.random(3,6)
      room_x = math.random(2, (mapmax_x - room_size_x - 1)) -- the 1 is to allow for wall tiles
      room_y = math.random(2, (mapmax_y - room_size_y - 1)) -- the 1 is to allow for wall tiles#
      elseif gen == 2 then -- spawn a room approximatly in the top left
      room_size_x = math.random(5,7)
      room_size_y = math.random(5,7)
      room_x = math.random(2, (mapmax_x - hungerarea_x - room_size_x - 8)) -- the 1 is to allow for wall tiles
      room_y = math.random(2, (14 - room_size_y - 1)) -- the 1 is to allow for wall tiles#
      elseif gen == 3 then -- spawn a room approximatly in the bottom left
      room_size_x = math.random(5,7)
      room_size_y = math.random(5,7)
      room_x = math.random(2, (mapmax_x - hungerarea_x - room_size_x - 2)) -- the 1 is to allow for wall tiles
      room_y = math.random(15, (mapmax_y - room_size_y - 1)) -- the 1 is to allow for wall tiles
      elseif gen == 4 then  -- spawn a room approximatly in the bottom right
      room_size_x = math.random(5,7)
      room_size_y = math.random(5,7)
      room_x = math.random(20, (mapmax_x - room_size_x - 1)) -- the 1 is to allow for wall tiles
      room_y = math.random(14, (mapmax_y - room_size_y - 1)) -- the 1 is to allow for wall tiles
      else 
      room_size_x = math.random(3,7)
      room_size_y = math.random(3,7)
      room_x = math.random(3, (mapmax_x - room_size_x - 1)) -- the 1 is to allow for wall tiles
      room_y = math.random(3, (mapmax_y - room_size_y - 1)) -- the 1 is to allow for wall tiles
      end


    -- test to see if roomplacement is possible

--------------------------------------------------------
    -- more centeral rooms
      if room_place_attempt == false then
      if room_x > 4 and room_x < mapmax_x - room_size_x - 3 and room_y > 4 and room_y < mapmax_y - room_size_y - 3 then
      for i = (room_x - 3), (room_x + room_size_x + 2) do
        for j = (room_y - 3), (room_y + room_size_y + 2) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end           
        end
      end
      room_place_attempt = true
      end
      end


     -- top left corner

      if room_place_attempt == false then
      if room_x == 2 or room_x == 3 then 
      if room_y == 2 or room_y == 3 then
      for i = (room_x - 1), (room_x + room_size_x + 2) do
        for j = (room_y - 1), (room_y + room_size_y + 2) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end
         end
      end
      room_place_attempt = true
      end
      end
      end
     -- bottom left corner

      if room_place_attempt == false then
      if room_x == 2 or room_x == 3 then
      if room_y == mapmax_y - room_size_y or room_y == mapmax_y - room_size_y - 1 then
      for i = (room_x - 1), (room_x + room_size_x + 2) do
        for j = (room_y - 3), (room_y + room_size_y) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end
         end
      end
      room_place_attempt = true
      end
      end
      end

     -- bottom right corner

      if room_place_attempt == false then
      if room_x == mapmax_x - room_size_x or room_x == mapmax_x - room_size_x - 1 then
      if room_y == mapmax_y - room_size_y or room_y == mapmax_y - room_size_y - 1 then
      for i = (room_x - 3), (room_x + room_size_x) do
        for j = (room_y - 3), (room_y + room_size_y) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end
         end
      end
      room_place_attempt = true
      end
      end
      end


      -- top edge
      if room_place_attempt == false then
      if room_x > 4 and room_x < mapmax_x - room_size_x - 3 then
      if room_y == 2 or room_y == 3 then
      for i = (room_x - 3), (room_x + room_size_x + 2) do
        for j = (room_y - 1), (room_y + room_size_y + 2) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end                   
        end
      end
      room_place_attempt = true
      end
      end
      end

      -- left edge
      if room_place_attempt == false then
      if room_x == 2 or room_x == 3 then
      if room_y > 4 and room_y < mapmax_y - room_size_y - 3 then
      for i = (room_x - 1), (room_x + room_size_x + 2) do
        for j = (room_y - 3), (room_y + room_size_y + 2) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end         
        end
      end
      room_place_attempt = true
      end
      end
      end

      -- bottom edge
      if room_place_attempt == false then
      if room_x > 4 and room_x < mapmax_x - room_size_x - 3 then
      if room_y == mapmax_y - room_size_y or room_y == mapmax_y - room_size_y - 1 then
      for i = (room_x - 3), (room_x + room_size_x + 2) do
        for j = (room_y - 3), (room_y + room_size_y) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end     
        end
      end
      room_place_attempt = true
      end
      end
      end

      -- right edge

      if room_place_attempt == false then
      if room_x == mapmax_x - room_size_x or room_x == mapmax_x - room_size_x - 1 then
      if room_y > hungerarea_y and room_y < mapmax_y - room_size_y - 3 then
      for i = (room_x - 3), (room_x + room_size_x) do
        for j = (room_y - 3), (room_y + room_size_y + 2) do
           array_sum = array_sum + map[i][j]
             if i >=23 and j <= 7 then
               array_sum = array_sum + 999
             end          
        end
      end
      room_place_attempt = true
      end
      end
      end


-----

-- if 0, i.e no conflicts. then room can spawn

      if array_sum > 0 then
         check = false
         array_sum = 0
         room_place_attempt = false
      end

      if array_sum == 0 and room_place_attempt == true then
         roomplaced = true
         check = true
         room_place_attempt = true
         array_sum = 0
      end

      if failure_placement_counter >= 15 then
        map_gen_fine = false
        room_place_attempt = false
        roomplaced = true  -- dummys this so that we can get out of the loop
      end
    end  -- ends the room generation while loop
    
    if check == false then
       map_gen_fine = false
    end

    if check == true and room_place_attempt == true then
    room_place_attempt = false
    failure_placement_counter = 0
    total_rooms_placed = total_rooms_placed + 1
    for i = room_x, (room_x + room_size_x - 1) do
       for j = room_y, (room_y + room_size_y - 1) do
          map[i][j] = 1
       end
    end
-- counts number of rooms, for future refference
    map_room_cord_x[gen] = room_x
    map_room_cord_y[gen] = room_y
    map_room_size_x[gen] = room_size_x
    map_room_size_y[gen] = room_size_y
    if gen == map_room_count and total_rooms_placed == map_room_count then
      map_gen_fine = true
    end
    end

end
-- map made - if map_gen_fine = false, then restart the entire process again
end




-- room generation successful


--- corridor generation


-- copy room generated modules into backup map arrays

for i=1, mapmax_x do
   for j=1, mapmax_y do
      uncorrimap[i][j] = map[i][j]
      corrimap[i][j] = map[i][j]
   end
end

-- establish initial corridor connections


-- now to generate corridors
-- semi random walk algorithm.


-- generate map_room_count - 1 to map_room_count * 2 corridors
-- 0.65 chance of corridor starting facing the room
-- 0.45 chance of corridor starting in the opposite direction
-- not all rooms need to be connected linearally
-- apply this both to the x and y side
-- probability of randomly turning on the path = 0.3
-- probability of carrying on this path = 0.4
-- probability of turning the corridor generator to the right room when corridor location is within the same values as the room itself = 0.7

-- initiall corridor generation algoritm

-- create initial corridor


--mapstring =  "Sx " .. map_room_cord_x[1] .. " Sy " .. map_room_cord_y[1] .. " Sxlen " .. map_room_size_x[1] .. " Sylen " .. map_room_size_y[1] ..  ""

-- we need all things to be probably the same as accuratly as possible. So if corridor start location not suitable, rerun it

-- this algorithm also takes into the possibility of not wanting to start corridors that are right next to walls or other rooms except the one it wants to connect to

-- nearest room algorithm for the first to second room connection, will make this down to probability sometime soon
-- we shall be doing this radially



-- 1 = up
-- 2 = down
-- 3 = left
-- 4 = right



for i=1, corridor_number_spawn do
   corri_start_loc_x[i] = 0
   corri_start_loc_y[i] = 0
   corri_end_loc_x[i] = 0
   corri_end_loc_y[i] = 0
   corri_start_direction[i] = 0
   corri_end_direction[i] = 0
end

corridor_level_generation_attempt = corridor_level_generation_attempt + 1
for corri_j = 1,corridor_number_spawn do
   connection = false
   cori_gen_start = false
   attempt_counter = 0
   corri_gen_attempt_counter = 0
   connection_check = false
   cori_gen_start_check = false
   while connection_check == false and corridor_level_generation_attempt < 1000 do
     while cori_gen_start == false and corridor_level_generation_attempt < 1000 do
       corridor_level_generation_attempt = corridor_level_generation_attempt + 1
       corri_gen_attempt_counter = 0
       connection = false
       cori_gen_start_check = false
       for i=1, mapmax_x do
         for j=1, mapmax_y do
          uncorrimap[i][j] = corrimap[i][j] -- port over buffer map
         end
       end

       if corri_j > map_room_count then
         room_selected = math.random(1,map_room_count)
       else
         room_selected = corri_j
       end
       room_init_select_x = map_room_cord_x[room_selected]
       room_init_select_y = map_room_cord_y[room_selected]
       room_init_size_x = map_room_size_x[room_selected]
       room_init_size_y = map_room_size_y[room_selected]

-- more intellegent corridor start algorithm

  
        x_dom = math.random() -- determins if the corridor spawns at the left or the top of a room
        if x_dom >= 0.5 and cori_gen_start == false and cori_gen_start == false and connection_check == false and cori_gen_start_check == false  then
        -- coridor starts along the top or bottom
        corri_start_x = math.random((room_init_select_x), (room_init_select_x + room_init_size_x - 1))
        corri_current_x = corri_start_x
        y_place = math.random()
        if y_place >= 0.5 then
        -- corridor placed at the top
          corri_start_y = (room_init_select_y - 1)
        -- final check
          if (corri_start_y - 2) > 2 then
             if corri_start_y - 3 > hungerarea_y and corri_start_x + 3 < (mapmax_x - hungerarea_x) and cori_gen_start == false then
              if uncorrimap[corri_start_x - 1][corri_start_y] == 0 and uncorrimap[corri_start_x - 1][corri_start_y - 1] == 0 and uncorrimap[corri_start_x][corri_start_y - 1] == 0  and uncorrimap[corri_start_x + 1][corri_start_y - 1] == 0  and uncorrimap[corri_start_x + 1][corri_start_y] == 0  then
              cori_gen_start_check = true
              corri_direction = 1
              end
             end
          end
        else
          corri_start_y = (room_init_select_y + room_init_size_y)
--        don't spawn coridoors facing edges of the map
          if (corri_start_y + 2) < mapmax_y - 1 and cori_gen_start == false and connection_check == false and cori_gen_start_check == false  then
              if uncorrimap[corri_start_x - 1][corri_start_y] == 0 and uncorrimap[corri_start_x - 1][corri_start_y + 1] == 0 and uncorrimap[corri_start_x][corri_start_y + 1] == 0  and uncorrimap[corri_start_x + 1][corri_start_y + 1] == 0  and uncorrimap[corri_start_x + 1][corri_start_y] == 0  then
             cori_gen_start_check = true
             corri_direction = 2
              end
          end
        end
        else
       -- corridor starts along the left or right
          corri_start_y = math.random((room_init_select_y), (room_init_select_y + room_init_size_y - 1))
          corri_current_y = corri_start_y
          x_place = math.random()
          if x_place >= 0.5 then
          -- corridor placed to the left
          corri_start_x = (room_init_select_x - 1)
            if (corri_start_x - 2) > 2 and cori_gen_start == false and connection_check == false and cori_gen_start_check == false then
              if uncorrimap[corri_start_x][corri_start_y - 1] == 0 and uncorrimap[corri_start_x - 1][corri_start_y - 1] == 0 and uncorrimap[corri_start_x - 1][corri_start_y] == 0  and uncorrimap[corri_start_x - 1][corri_start_y + 1] == 0  and  uncorrimap[corri_start_x][corri_start_y + 1] == 0 then
                cori_gen_start_check = true
                corri_direction = 3
              end
            end
          else
            corri_start_x = (room_init_select_x + room_init_size_x)
            if (corri_start_x + 2) < mapmax_x - 1 then
            -- don't go into the hunger area
              if corri_start_x + 3 < (mapmax_x - hungerarea_x) and corri_start_y - 3 > hungerarea_y and cori_gen_start == false and connection_check == false and cori_gen_start_check == false  then
                if uncorrimap[corri_start_x][corri_start_y - 1] == 0 and uncorrimap[corri_start_x + 1][corri_start_y - 1] == 0 and uncorrimap[corri_start_x + 1][corri_start_y] == 0  and uncorrimap[corri_start_x + 1][corri_start_y + 1] == 0  and  uncorrimap[corri_start_x][corri_start_y + 1] == 0  then
                cori_gen_start_check = true
                corri_direction = 4
                end
              end
             end
        end
        end  -- if statements closed for this big if statement. while loop still around

     if cori_gen_start_check == true then  -- checks to see if corridor start location is not the same as one that already exists
       for i = 1, corridor_number_spawn do
         if corri_start_loc_x[i] == corri_start_x and corri_start_loc_y[i] == corri_start_y then
          corri_gen_attempt_counter = corri_gen_attempt_counter + 1
         end
       end
       if corri_gen_attempt_counter == 0 then
        cori_gen_start = true
       end

     end

     
     if cori_gen_start == true then
        corri_current_x = corri_start_x
        corri_current_y = corri_start_y
        corri_start_loc_x[corri_j] = corri_current_x
        corri_start_loc_y[corri_j] = corri_current_y
        uncorrimap[corri_current_x][corri_current_y] = 2
        corri_start_direction[corri_j] = corri_direction
     end
     if cori_gen_start == true then
     end

    end
-- ends the initial placement algorithm while loop

-- 1 = up
-- 2 = down
-- 3 = left
-- 4 = right

    corridor_level_generation_attempt = corridor_level_generation_attempt + 1

    if corri_direction == 1 and connection == false and cori_gen_start == true and connection_check == false then
       if corri_current_y - 1 > 1 then
       if corri_current_x - 2 < (mapmax_x - hungerarea_x - 1) and corri_current_y - 2 > hungerarea_y then
       if uncorrimap[corri_current_x][corri_current_y - 1] == 1 or uncorrimap[corri_current_x][corri_current_y - 1] == 2 then
          connection = true
          cori_end_dir_thing = 1
       else
         if uncorrimap[corri_current_x - 1][corri_current_y - 1] == 0 and uncorrimap[corri_current_x + 1][corri_current_y - 1] == 0 then
          corri_current_y = corri_current_y - 1
          uncorrimap[corri_current_x][corri_current_y] = 2
         end
       end
       end
       end
    end


    if corri_direction == 2 and connection == false and cori_gen_start == true and connection_check == false then
       if corri_current_y + 1 < mapmax_y - 1 then
       if uncorrimap[corri_current_x][corri_current_y + 1] == 1 or uncorrimap[corri_current_x][corri_current_y + 1] == 2 then
          connection = true
          cori_end_dir_thing = 2
       else
         if uncorrimap[corri_current_x - 1][corri_current_y + 1] == 0 and uncorrimap[corri_current_x + 1][corri_current_y + 1] == 0 then
          corri_current_y = corri_current_y + 1
          uncorrimap[corri_current_x][corri_current_y] = 2
         end
       end
       end
    end

    if corri_direction == 3 and connection == false and cori_gen_start == true and connection_check == false then
       if corri_current_x - 1 > 1 then
       if uncorrimap[corri_current_x - 1][corri_current_y] == 1 or uncorrimap[corri_current_x - 1][corri_current_y] == 2 then
          connection = true
          cori_end_dir_thing = 3
       else
         if uncorrimap[corri_current_x - 1][corri_current_y - 1] == 0 and uncorrimap[corri_current_x - 1][corri_current_y + 1] == 0 then
          corri_current_x = corri_current_x - 1
          uncorrimap[corri_current_x][corri_current_y] = 2
         end
       end
       end
    end

    if corri_direction == 4 and connection == false and cori_gen_start == true and connection_check == false then
       if corri_current_x + 1 < mapmax_x then
       if corri_current_x + 2 < (mapmax_x - hungerarea_x - 1) and corri_current_y - 2 > hungerarea_y then
       if uncorrimap[corri_current_x + 1][corri_current_y] == 1 or uncorrimap[corri_current_x + 1][corri_current_y] == 2 then
          connection = true
          cori_end_dir_thing = 4
       else
         if uncorrimap[corri_current_x + 1][corri_current_y - 1] == 0 and uncorrimap[corri_current_x + 1][corri_current_y + 1] == 0 then
          corri_current_x = corri_current_x + 1
          uncorrimap[corri_current_x][corri_current_y] = 2
         end
       end
       end
       end
    end

    if connection == false and connection_check == false and cori_gen_start == true then
    attempt_counter = attempt_counter + 1
    change_direction = math.random(1,20) -- if 18, then change direction
    if change_direction >= 18 then
       initial_direction = true
       initial_direction_value = corri_direction
       while initial_direction == true do
         corri_direction = math.random(1,4)
         if initial_direction_value == corri_direction then
           initial_direction = true
         else
           initial_direction = false
         end
       end
    end
    end

    if cori_gen_start == true and attempt_counter >= 10 then
      cori_gen_start = false
      connection = false
      attempt_counter = 0
    end


-- make sure that the end point connections are.. loose so to speak so that the door will not spawn next to another door etc.

    if connection == true then
      attempt_counter = attempt_counter + 1
      corridor_connection_end_check_counter = 0
       if cori_end_dir_thing == 1 then
         if uncorrimap[corri_current_x][corri_current_y + 1] == 2 and uncorrimap[corri_current_x - 1][corri_current_y] == 0 and uncorrimap[corri_current_x + 1][corri_current_y] == 0 then  -- checks that there will be a corrdor behind it
           for i = 1,corridor_number_spawn do -- checks to see if the door is not spawning right in front of another one
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x - 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x - 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x + 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x + 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
           end
           if corridor_connection_end_check_counter == 0 then
             connection_check = true
           end
         end
       end
       if cori_end_dir_thing == 2 then
         if uncorrimap[corri_current_x][corri_current_y - 1] == 2 and uncorrimap[corri_current_x - 1][corri_current_y] == 0 and uncorrimap[corri_current_x + 1][corri_current_y] == 0 then
           for i = 1,corridor_number_spawn do -- checks to see if the door is not spawning right in front of another one
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x - 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x - 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x + 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x + 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
           end
           if corridor_connection_end_check_counter == 0 then
             connection_check = true
           end
         end
       end
       if cori_end_dir_thing == 3 then
         if uncorrimap[corri_current_x + 1][corri_current_y] == 2 and uncorrimap[corri_current_x][corri_current_y + 1] == 0 and uncorrimap[corri_current_x][corri_current_y - 1] == 0 then
           for i = 1,corridor_number_spawn do -- checks to see if the door is not spawning right in front of another one
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x - 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x - 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x + 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x + 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
           end
           if corridor_connection_end_check_counter == 0 then
             connection_check = true
           end
         end
       end
       if cori_end_dir_thing == 4 then 
          if uncorrimap[corri_current_x - 1][corri_current_y + 1] == 2 and uncorrimap[corri_current_x][corri_current_y + 1] == 0 and uncorrimap[corri_current_x][corri_current_y - 1] == 0 then
           for i = 1,corridor_number_spawn do -- checks to see if the door is not spawning right in front of another one
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y - 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == corri_current_x and corri_end_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == corri_current_x and corri_start_loc_y[i] == (corri_current_y + 1) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x - 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x - 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_end_loc_x[i] == (corri_current_x + 1) and corri_end_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
             if corri_start_loc_x[i] == (corri_current_x + 1) and corri_start_loc_y[i] == (corri_current_y) then
             corridor_connection_end_check_counter = corridor_connection_end_check_counter + 1
             end
           end
           if corridor_connection_end_check_counter == 0 then
             connection_check = true
           end
          end
       end
    end

    corridor_connection_end_check_counter = 0 -- resets that check

    if connection == true and connection_check == false then
      connection = false
    end

-- end the bigger while loop
    end
    if connection_check == true and cori_gen_start == true then
          cori_gen_start = false
          connection = false
          connection_check = false

          for i=1, mapmax_x do
           for j=1, mapmax_y do
            corrimap[i][j] = uncorrimap[i][j] -- bring over created corridor
            if corrimap[i][j] == 2 then
               corrimap[i][j] = 1
            end
           end
          end


          corri_end_loc_x[corri_j] = corri_current_x
          corri_end_loc_y[corri_j] = corri_current_y
          corri_end_direction[corri_j] = cori_end_dir_thing
          


   end -- ends last if staement

-- end the for loop
end


if corridor_level_generation_attempt < 1000 then
  corridor_generation_test_confirm = true
end

end -- corridor generation confirmed


mapcoordtest = "corri start "
maproomsizetest = "corri end "

    
-- 1 = up
-- 2 = down
-- 3 = left
-- 4 = right


for i=1, mapmax_x do
   for j=1, mapmax_y do
      map[i][j] = corrimap[i][j]
   end
end


for j = 1, corridor_number_spawn do
   mapcoordtest = mapcoordtest .. "(" ..  corri_start_loc_x[j] .. "," .. corri_start_loc_y[j] .. " " .. corri_start_direction[j] .. ")" .. " "
   maproomsizetest = maproomsizetest .. "(" ..  corri_end_loc_x[j] .. "," .. corri_end_loc_y[j] .. " " .. corri_end_direction[j] .. ")" .. " "
end


for corri_j = 1,corridor_number_spawn do
   corri_start_x = corri_start_loc_x[corri_j]
   corri_start_y = corri_start_loc_y[corri_j]
   corri_fin_x = corri_end_loc_x[corri_j]
   corri_fin_y = corri_end_loc_y[corri_j]



   if corri_start_direction[corri_j] == 1 then
-- kill the sides, this location is the door
    if map[corri_start_x - 1][corri_start_y] == 1 then
       map[corri_start_x - 1][corri_start_y] = 0
     end

     if map[corri_start_x + 1][corri_start_y] == 1 then
       map[corri_start_x + 1][corri_start_y] = 0
     end
   end

   if corri_end_direction[corri_j] == 1 then
-- kill the sides, this location is the door
     if map[corri_fin_x - 1][corri_fin_y] == 1 then
       map[corri_fin_x - 1][corri_fin_y] = 0
    end

    if map[corri_fin_x + 1][corri_fin_y] == 1 then
       map[corri_fin_x + 1][corri_fin_y] = 0
     end

   end

   if corri_start_direction[corri_j] == 2 then
-- kill the sides, this location is the door
     if map[corri_start_x - 1][corri_start_y] == 1 then
       map[corri_start_x - 1][corri_start_y] = 0
     end

     if map[corri_start_x + 1][corri_start_y] == 1 then
       map[corri_start_x + 1][corri_start_y] = 0
     end

   end


   if corri_end_direction[corri_j] == 2 then
     if map[corri_fin_x - 1][corri_fin_y] == 1 then
       map[corri_fin_x - 1][corri_fin_y] = 0
     end

     if map[corri_fin_x + 1][corri_fin_y] == 1 then
       map[corri_fin_x + 1][corri_fin_y] = 0
     end

   end


   if corri_start_direction[corri_j] == 3 then
     if map[corri_start_x][corri_start_y + 1] == 1 then
       map[corri_start_x][corri_start_y + 1] = 0
     end

     if map[corri_start_x][corri_start_y - 1] == 1 then
       map[corri_start_x][corri_start_y - 1] = 0
     end

   end

   if corri_end_direction[corri_j] == 3 then
    if map[corri_fin_x][corri_fin_y - 1] == 1 then
       map[corri_fin_x][corri_fin_y - 1] = 0
    end

    if map[corri_fin_x][corri_fin_y + 1] == 1 then
      map[corri_fin_x][corri_fin_y + 1] = 0     
    end

   end

   if corri_start_direction[corri_j] == 4 then
    if map[corri_start_x][corri_start_y + 1] == 1 then
       map[corri_start_x][corri_start_y + 1] = 0
     end

     if map[corri_start_x][corri_start_y - 1] == 1 then
       map[corri_start_x][corri_start_y - 1] = 0
     end

   end


   if corri_end_direction[corri_j] == 4 then
     if map[corri_fin_x][corri_fin_y - 1] == 1 then
       map[corri_fin_x][corri_fin_y - 1] = 0
     end

     if map[corri_fin_x][corri_fin_y + 1] == 1 then
       map[corri_fin_x][corri_fin_y + 1] = 0
     end

   end
end

-- bucket fill
-- here we need the start location
start_point_x = map_room_cord_x[1] + 1
start_point_y = map_room_cord_y[1] + 2

testjoinmap = map

for i=1, mapmax_x - 1 do
   for j=1, mapmax_y - 1 do
     if map[i][j] == 1 and map[i+1][j] == 0 and map[i][j+1] == 0 and map[i+1][j+1] == 1 then
         map[i][j] = 0
     end
     if map[i][j] == 0 and map[i+1][j] == 1 and map[i][j+1] == 1 and map[i+1][j+1] == 0 then
         map[i+1][j] = 0
     end
   end
end

testjoinmap = bucketfill(testjoinmap,start_point_x,start_point_y,1,9)
for i=1, mapmax_x do
   for j=1, mapmax_y do
      if testjoinmap[i][j] == 1 then
        buckettest = false
      end
   end
end

--- bucket fill end loop which starts 400 lines above
end

---- get around with a known bug... basically for some reason, the 9's are staying in the map
for i=1, mapmax_x do
   for j=1, mapmax_y do
     if map[i][j] == 9 then
         map[i][j] = 1
     end
   end
end

-- add some stuff to bottom right or bottom left corners




--- generate the final check map

for i=1, mapmax_x do
  for j=1, mapmax_y do
    finalcheckmap[i][j] = map[i][j]
   end
end


-- add the doors from the corridor start and end points

-- now to add walls
-- first do the outer edges

for j = 1, mapmax_y do  -- check the left edge
   if map[1][j] == 0 then
     if j > 1 then
       if map[1][j + 1] == 1 then -- check below
         map[1][j] = 2
       end

       if map[2][j + 1] == 1 then -- check bottom right
         map[1][j] = 2
       end
     end

     if j < mapmax_y then
       if map[2][j - 1] == 1 then -- check up
         map[1][j] = 2
       end

       if map[2][j - 1] == 1 then -- check top right
         map[1][j] = 2
       end
     end 

     if map[2][j] == 1 then -- check right
       map[1][j] = 2
     end
   end
end

for i = 1, mapmax_x do  -- check the bottom edge
   if map[i][mapmax_y] == 0 then
     if i > 1 then  -- check left
       if map[i - 1][mapmax_y - 1] == 1 then -- check top left
         map[i][mapmax_y] = 2
       end

       if map[i-1][mapmax_y] == 1 then  -- check left
         map[1][mapmax_y] = 2
       end
     end

     if i < mapmax_x then -- check right
       if map[i + 1][mapmax_y - 1] == 1 then -- check top right
         map[i][mapmax_y] = 2
       end

       if map[i+1][mapmax_y] == 1 then  -- check right
         map[1][mapmax_y] = 2
       end
     end 

     if map[i][mapmax_y - 1] == 1 then -- check above
       map[i][mapmax_y] = 2
     end
   end
end


for i = 1, (mapmax_x - hungerarea_x + 1) do  -- check the top edge
   if map[i][1] == 0 then
     if i > 1 then  -- check left
       if map[i - 1][2] == 1 then -- check bottom left
         map[i][1] = 2
       end

       if map[i-1][1] == 1 then  -- check left
         map[1][1] = 2
       end
     end

     if i < (mapmax_x - hungerarea_x + 1) then -- check right
       if map[i + 1][2] == 1 then -- check bottom right
         map[i][1] = 2
       end

       if map[i+1][1] == 1 then  -- check right
         map[1][1] = 2
       end
     end 

     if map[i][2] == 1 then -- check below
       map[i][1] = 2
     end
   end
end

for j = hungerarea_y + 1, mapmax_y do  -- check the right edge
   if map[mapmax_x][j] == 0 then
     if j > hungerarea_y + 1 then  -- check left
       if map[mapmax_x - 1][j - 1] == 1 then -- check top left
         map[mapmax_x][j] = 2
       end

       if map[mapmax_x][j - 1] == 1 then  -- check top
         map[mapmax_x][j] = 2
       end
     end

     if j < (mapmax_x - hungerarea_x + 1) then -- check bottom
       if map[mapmax_x - 1][j+1] == 1 then -- check bottom left
         map[mapmax_x][j] = 2
       end

       if map[mapmax_x][j+1] == 1 then  -- check bottom
         map[mapmax_x][j] = 2
       end
     end 

     if map[mapmax_x - 1][j] == 1 then -- check left
       map[mapmax_x][j] = 2
     end
   end
end

for i = 2, mapmax_x - 1 do
   for j = 2, mapmax_y - 1 do
     -- check in all directions
     if map[i][j] == 0 then
       -- check above.. and then in all directions anticlockwise
      if map[i][j-1] == 1 then
         map[i][j] = 2
      end

      if map[i+1][j-1] == 1 then
         map[i][j] = 2
      end

      if map[i+1][j] == 1 then
         map[i][j] = 2
      end

      if map[i+1][j+1] == 1 then
         map[i][j] = 2
      end

      if map[i][j+1] == 1 then
         map[i][j] = 2
      end

      if map[i-1][j+1] == 1 then
         map[i][j] = 2
      end

      if map[i-1][j] == 1 then
         map[i][j] = 2
      end

      if map[i-1][j-1] == 1 then
         map[i][j] = 2
      end
     end

   end
end

-- make corridors more... corridor like.

-- 1 = up
-- 2 = down
-- 3 = left
-- 4 = right


for corri_j = 1,corridor_number_spawn do
   corri_start_x = corri_start_loc_x[corri_j]
   corri_start_y = corri_start_loc_y[corri_j]
   corri_fin_x = corri_end_loc_x[corri_j]
   corri_fin_y = corri_end_loc_y[corri_j]



   if corri_start_direction[corri_j] == 1 then
   map[corri_start_x][corri_start_y] = 50
-- kill the sides, this location is the door
 --   if map[corri_start_x - 1][corri_start_y] == 1 then
 --      map[corri_start_x - 1][corri_start_y] = 2
 --    end

 --    if map[corri_start_x + 1][corri_start_y] == 1 then
 --      map[corri_start_x + 1][corri_start_y] = 2
 --    end
   end

   if corri_end_direction[corri_j] == 1 then
   map[corri_fin_x][corri_fin_y] = 50
-- kill the sides, this location is the door
--     if map[corri_fin_x - 1][corri_fin_y] == 1 then
--       map[corri_fin_x - 1][corri_fin_y] = 2
 --    end

 --    if map[corri_fin_x + 1][corri_fin_y] == 1 then
 --      map[corri_fin_x + 1][corri_fin_y] = 2
 --    end

   end

   if corri_start_direction[corri_j] == 2 then
   map[corri_start_x][corri_start_y] = 50
-- kill the sides, this location is the door
  --   if map[corri_start_x - 1][corri_start_y] == 1 then
  --     map[corri_start_x - 1][corri_start_y] = 2
  --   end

  --   if map[corri_start_x + 1][corri_start_y] == 1 then
  --     map[corri_start_x + 1][corri_start_y] = 2
  --   end

   end


   if corri_end_direction[corri_j] == 2 then
   map[corri_fin_x][corri_fin_y] = 50
 --    if map[corri_fin_x - 1][corri_fin_y] == 1 then
 --      map[corri_fin_x - 1][corri_fin_y] = 2
 --    end

 --    if map[corri_fin_x + 1][corri_fin_y] == 1 then
 --      map[corri_fin_x + 1][corri_fin_y] = 2
 --    end

   end


   if corri_start_direction[corri_j] == 3 then
   map[corri_start_x][corri_start_y] = 50
  --   if map[corri_start_x][corri_start_y + 1] == 1 then
  --     map[corri_start_x][corri_start_y + 1] = 2
  --   end

  --   if map[corri_start_x][corri_start_y - 1] == 1 then
   --    map[corri_start_x][corri_start_y - 1] = 2
   --  end

   end

   if corri_end_direction[corri_j] == 3 then
   map[corri_fin_x][corri_fin_y] = 50
--   if map[corri_fin_x][corri_fin_y - 1] == 1 then
--       map[corri_fin_x][corri_fin_y - 1] = 2
--   end

--   if map[corri_fin_x][corri_fin_y + 1] == 1 then
--      map[corri_fin_x][corri_fin_y + 1] = 2
--     end

   end

   if corri_start_direction[corri_j] == 4 then
   map[corri_start_x][corri_start_y] = 50
  --   if map[corri_start_x][corri_start_y + 1] == 1 then
  --     map[corri_start_x][corri_start_y + 1] = 2
 --    end

 --    if map[corri_start_x][corri_start_y - 1] == 1 then
  --     map[corri_start_x][corri_start_y - 1] = 2
   --  end

   end


   if corri_end_direction[corri_j] == 4 then
   map[corri_fin_x][corri_fin_y] = 50
--     if map[corri_fin_x][corri_fin_y - 1] == 1 then
--       map[corri_fin_x][corri_fin_y - 1] = 2
 --    end

 --    if map[corri_fin_x][corri_fin_y + 1] == 1 then
  --     map[corri_fin_x][corri_fin_y + 1] = 2
   --  end

   end
end





-- now to make the new room maps from the physically created stuff

for i = 1, mapmax_x do
  for j = 1, mapmax_y do
  roommap[i][j] = map[i][j]
  end
end



looping = true
doing = true
iter = 6 
while looping do
    for i=1,#roommap do
        for j=1,#roommap[i] do
            if roommap[i][j] == 1 and doing then
                roommap = bucketfill(roommap,i,j,1,iter)
                iter = iter + 1 
                doing = false
            else 
                if i == #roommap and j == #roommap[i] and doing then                    
                   looping = false
                end     
            end     
        end     
    end     
    doing = true
end

for i=1,#roommap do
    for j=1,#roommap do
        if roommap[i][j] == 2 then roommap[i][j] = 0 end
        if roommap[i][j] == 50 then roommap[i][j] = 99 end
    end
end


-------------------------------------------------------------
-- now lets spawn items into rooms etc.

-- player wont spawn in a bed location but will spawn in the dorm room
-- start location edited at the top with the first bucket fill.


-- bed
bed_x = map_room_cord_x[1]
bed_y = map_room_cord_y[1]
bed_size_x = map_room_size_x[1]
bed_size_y = map_room_size_x[1]

map[bed_x + 1][bed_y + 1] = 100
if bed_size_x > 4 and bed_size_y > 4 then
for i = bed_x + 1, (bed_x + bed_size_x - 2),2 do -- allow gaps around the side
--  for j = bed_y + 1, (bed_y + bed_size_y - 2),2 do
   if map[i][j] == 1 and map[i + 1][j] == 1 and map[i - 1][j] == 1 and map[i][j - 1] == 1 and  map[i][j + 1] == 1 and map[i - 1][j - 1] == 1 and map[i + 1][j + 1] == 1 and map[i - 1][j + 1] == 1 and map[i - 1][j + 1] == 1 then
    map[i][j] = 100
   end
--  end
end
end

------

-- helm generation

--Helm
-- helm consoles, 130 or 131, f
-- at least one helm main screen, 132, w
-- all doors must be secure doors, 60

helm_generation = false
helm_generation_spawn_attempt = 0 
while helm_generation == false and helm_generation_spawn_attempt <= 20 do
  helm_room_number = math.random(2,map_room_count)
  helm_generation_spawn_attempt = helm_generation_spawn_attempt + 1
 -- check to see if room is a decent distance from the start location
  
  
  x_cent_bed = (map_room_cord_x[1] + (map_room_cord_x[1] + map_room_size_x[1] - 1) / 2) 
  y_cent_bed = (map_room_cord_y[1] + (map_room_cord_y[1] + map_room_size_y[1] - 1) / 2) 
  x_cent_helm = (map_room_cord_x[helm_room_number] + (map_room_cord_x[helm_room_number] + map_room_size_x[helm_room_number] - 1) / 2) 
  y_cent_helm = (map_room_cord_y[helm_room_number] + (map_room_cord_y[helm_room_number] + map_room_size_y[helm_room_number] - 1) / 2) 


  if x_cent_helm <= x_cent_bed then
  x = x_cent_bed - x_cent_helm
  else
  x = x_cent_helm - x_cent_bed
  end
  if y_cent_helm <= y_cent_bed then
  y = y_cent_bed - y_cent_helm
  else
  y = y_cent_helm - y_cent_bed
  end
  rad = math.pow(x,2) + math.pow(y,2)
  rad = math.sqrt(rad)
  
  if rad >= check_rad_helm then
    helm_room_x = map_room_cord_x[helm_room_number]
    helm_room_y = map_room_cord_y[helm_room_number]
    helm_room_size_x = map_room_size_x[helm_room_number]
    helm_room_size_y = map_room_size_y[helm_room_number]
 --  check to see if we can spawn the main screen
    if helm_room_size_x > 4 and helm_room_size_y > 4 then
    for i = helm_room_x, helm_room_x + helm_room_size_x - 1 do
      if map[i][helm_room_y - 1] == 2 then
        helm_generation = true
      end
    end
    end
  end
end

-- helm selected
-- secure the doors around the room

if helm_generation_spawn_attempt <= 20 then
for i = helm_room_x - 1, helm_room_x + helm_room_size_x do -- allow gaps around the side
  for j = helm_room_y - 1, helm_room_y + helm_room_size_y do
     if map[i][j] == 50 then
       map[i][j] = 60 -- locks the doors
     end
  end
end

-- now spawn helm scenery

helm_console_spawn = math.random()
if helm_console_spawn >= 0.5 then
  map[helm_room_x  + 1][helm_room_y  + 1] = 130
 else
  map[helm_room_x  + 1][helm_room_y  + 1] = 131
end

if helm_room_size_x > 4 and helm_room_size_y > 4 then
for i = helm_room_x  + 1, (helm_room_x + helm_room_size_x - 2),2 do -- allow gaps around the side
  for j = helm_room_y  + 1, (helm_room_y + helm_room_size_y - 2),2 do
    helm_console_spawn = math.random()
    if helm_console_spawn >= 0.5 then
    if map[i][j] == 1 and map[i + 1][j] == 1 and map[i - 1][j] == 1 and map[i][j - 1] == 1 and  map[i][j + 1] == 1 and map[i - 1][j - 1] == 1 and map[i + 1][j + 1] == 1 and map[i - 1][j + 1] == 1 and map[i - 1][j + 1] == 1 then
      map[i][j] = 130
    end
    else
    if map[i][j] == 1 and map[i + 1][j] == 1 and map[i - 1][j] == 1 and map[i][j - 1] == 1 and  map[i][j + 1] == 1 and map[i - 1][j - 1] == 1 and map[i + 1][j + 1] == 1 and map[i - 1][j + 1] == 1 and map[i - 1][j + 1] == 1 then
      map[i][j] = 131
    end
    end
  end
end
end

-- finally spawn the main screen

main_screen_placement = false
main_screen_placement_counter = 0
while main_screen_placement == false and main_screen_placement_counter <= 10 do
  main_screen_placement_counter = main_screen_placement_counter + 1
  main_screen_turn_on = math.random(helm_room_x, helm_room_x + helm_room_size_x - 1)
    if map[main_screen_turn_on][helm_room_y - 1] == 2 then
    if helm_room_y > 1 then 
    if map[main_screen_turn_on][helm_room_y - 2] == 0 then
       main_screen_placement = true
       map[main_screen_turn_on][helm_room_y - 1] = 132
       for i = helm_room_x, helm_room_x + helm_room_size_x - 1 do 
         for j = helm_room_y, helm_room_y + helm_room_size_y - 1 do
           finalcheckmap[i][j] = 2
         end
       end 
    end
    else
       main_screen_placement = true
       map[main_screen_turn_on][helm_room_y - 1] = 132
    end
    end
end
end -- spawn the helm

------------------------

-- dining room ------

--Dining room
-- tables, 120, f
-- at least one table with an apple, 121, f
-- food dispenser, 122, w

-- find dining room (has to be able to place food dispenser)
dining_room_placed = false
apple_placed = false
dining_room_probability_spawn = math.random()
dining_room_number = 0
dining_room_placement_counter = 0
--print ("dining room ", dining_room_probability_spawn, dining_room_placement_counter)
if dining_room_probability_spawn <= 0.65 and dining_room_placement_counter <= 10 then
while dining_room_placed == false and dining_room_placement_counter <= 10 do
  dining_room_number = math.random(2,map_room_count)
  dining_room_placement_counter = dining_room_placement_counter + 1
--  print ("lololo food", dining_room_placement_counter, helm_room_number, dining_room_number)
  if dining_room_number ~= helm_room_number  then
    dining_room_x = map_room_cord_x[dining_room_number]
    dining_room_y = map_room_cord_y[dining_room_number]
    dining_room_size_x = map_room_size_x[dining_room_number]
    dining_room_size_y = map_room_size_y[dining_room_number] 
    for i = dining_room_x, (dining_room_x + dining_room_size_x - 1) do
--      print ("111")
      if map[i][dining_room_y - 1] == 2 then
--        print ("2222")
        if dining_room_y > 3 and dining_room_size_x > 3 and dining_room_size_y > 3 then
--          print ("3333")
          if map[i][dining_room_y - 2] == 0 then
--          print ("4444")
          dining_room_placed = true
          end
--        else
--          dining_room_placed = true
        end
      end
    end
  end
--  if dining_room_placement_counter > 10 then
--    dining_room_placed = true
--  end
end


-- place food dispenser
if dining_room_placement_counter <= 10 then
  food_dis_placed = false
end

while food_dis_placed == false and dining_room_placement_counter <= 10 do
  food_dis_loc = math.random(dining_room_x, dining_room_x + dining_room_size_x - 1)
  dining_room_placement_counter = dining_room_placement_counter + 1
--  print("is grub up?")
    if map[food_dis_loc][dining_room_y - 1] == 2 then
       food_dis_placed = true
       map[food_dis_loc][dining_room_y - 1] = 122
--       print("yes it is")
    end
end

if dining_room_placement_counter > 10 then
  food_dis_placed = false
end

-- put tables into the room
for i = dining_room_x + 1, (dining_room_x + dining_room_size_x - 3),2 do -- allow gaps around the side
  for j = dining_room_y + 1, (dining_room_y + dining_room_size_y - 3),2 do
   if map[i][j] == 1 then
    map[i][j] = 120
   end
  end
end

apple_placement_probability = 0.1
apple_placed = false

--print ("counter lol", dining_room_placement_counter)
--print (dining_room_x, dining_room_y, dining_room_size_x,dining_room_size_y)
while apple_placed == false and dining_room_placement_counter <= 10 and food_dis_placed == true do
  for i = dining_room_x + 1, (dining_room_x + dining_room_size_x - 3),2 do -- allow gaps around the side
--    print (i)
    for j = dining_room_y + 1, (dining_room_y + dining_room_size_y - 3),2 do
--      print (map[i][j])
      if map[i][j] == 120 then
         apple_placement_thingy = math.random()
--           print ("222")
         if apple_placement_thingy <= apple_placement_probability then
--             print ("333")
           map[i][j] = 121
           apple_placed = true
         end
      end
    end
  end
end
end


-------------
-- spawn the security unlock point (not in the helm and a certain radius from the helm and the dorm)
security_terminal_generation_attempt = 0
security_terminal_generation = false
while security_terminal_generation == false and security_terminal_generation_attempt <= 100 do
  security_terminal_generation_attempt = security_terminal_generation_attempt + 1
  x_cent_bed = (map_room_cord_x[1] + (map_room_cord_x[1] + map_room_size_x[1] - 1) / 2) 
  y_cent_bed = (map_room_cord_y[1] + (map_room_cord_y[1] + map_room_size_y[1] - 1) / 2) 
  x_cent_helm = (map_room_cord_x[helm_room_number] + (map_room_cord_x[helm_room_number] + map_room_size_x[helm_room_number] - 1) / 2) 
  y_cent_helm = (map_room_cord_y[helm_room_number] + (map_room_cord_y[helm_room_number] + map_room_size_y[helm_room_number] - 1) / 2)
  x_cent_random_point = math.random(1,mapmax_x)
  y_cent_random_point = math.random(1,mapmax_y)

  if map[x_cent_random_point][y_cent_random_point] == 2 and map[x_cent_random_point][y_cent_random_point + 1] == 1 and security_terminal_generation_attempt <= 100 then
-- check to see if point is a good distance from both the helm and the bedroom
      if x_cent_helm <= x_cent_random_point then
      x = x_cent_random_point - x_cent_helm
      else
      x = x_cent_helm - x_cent_random_point
      end
      if y_cent_helm <= y_cent_random_point then
      y = y_cent_random_point - y_cent_helm
      else
      y = y_cent_helm - y_cent_random_point
      end

      rad_helm = math.pow(x,2) + math.pow(y,2)
      rad_helm = math.sqrt(rad_helm)

      if rad_helm > rad_terminal_from_helm then

        if x_cent_bed <= x_cent_random_point then
        x = x_cent_random_point - x_cent_bed
        else
        x = x_cent_bed - x_cent_random_point
        end
        if y_cent_bed <= y_cent_random_point then
        y = y_cent_random_point- y_cent_bed
        else
        y = y_cent_bed - y_cent_random_point
        end


        rad_bed = math.pow(x,2) + math.pow(y,2)
        rad_bed = math.sqrt(rad_bed)

        if rad_bed > rad_terminal_from_bedroom then
          if y_cent_random_point > 2 then
           if map[x_cent_random_point][y_cent_random_point - 1] == 0 then
            security_terminal_generation = true
            map[x_cent_random_point][y_cent_random_point] = 102
            console_x = x_cent_random_point
            console_y = y_cent_random_point
           end
           else
            security_terminal_generation = true
            map[x_cent_random_point][y_cent_random_point] = 102
            console_x = x_cent_random_point
            console_y = y_cent_random_point
            finalcheckmap[x_cent_random_point][y_cent_random_point] = 1
          end
        end
      end
   end
end





--- now to spawn the inessentials

engine_room_spawn_prob = math.random()
engine_room_spawn_confirm = false
engine_room_spawn_attempt = 0
engine_room_number = 0

--print (engine_room_spawn_prob)
--print (security_terminal_generation)
if engine_room_spawn_prob < 0.4 and security_terminal_generation == true and engine_room_spawn_attempt <= 50 then -- spawn the engine room
--  print ("engineee")
  while engine_room_spawn_confirm == false and engine_room_spawn_attempt <= 50 do
  engine_room_number = math.random(2,4)
  engine_room_spawn_attempt = engine_room_spawn_attempt + 1
  if engine_room_number ~= helm_room_number and engine_room_number ~= dining_room_number and engine_room_spawn_attempt <= 50 then


      x_engine = map_room_cord_x[engine_room_number]
 
      y_engine = map_room_cord_y[engine_room_number]
      x_engine_size = map_room_size_x[engine_room_number]
      y_engine_size = map_room_size_y[engine_room_number]

      if x_engine_size > 5 then -- needs to be a big enough room
      if y_engine_size > 4 then -- needs to be a big enough room
      x_engine_loc = (x_engine + (x_engine + x_engine_size - 1) / 2) 
      y_engine_loc = (y_engine + (y_engine + y_engine_size - 1) / 2) 

      if x_cent_helm <= x_engine_loc then
      x = x_engine_loc - x_cent_helm
      else
      x = x_cent_helm - x_engine_loc
      end
      if y_cent_helm <= y_engine_loc then
      y = y_engine_loc - y_cent_helm
      else
      y = y_cent_helm - y_engine_loc
      end

      rad_helm = math.pow(x,2) + math.pow(y,2)
      rad_helm = math.sqrt(rad_helm)

      if rad_helm > rad_engine_from_helm then

        if x_cent_bed <= x_engine_loc then
        x = x_engine_loc - x_cent_bed
        else
        x = x_cent_bed - x_engine_loc
        end
        if y_cent_bed <= y_engine_loc then
        y = y_engine_loc - y_cent_bed
        else
        y = y_cent_bed - y_engine_loc
        end


        rad_bed = math.pow(x,2) + math.pow(y,2)
        rad_bed = math.sqrt(rad_bed)

        if rad_bed > rad_engine_from_bedroom then


           if console_x <= x_engine_loc then
           x = x_engine_loc - console_x
           else
           x = console_x - x_engine_loc
           end
           if console_y <= y_engine_loc then
           y = y_engine_loc - console_y
           else
           y = console_y - y_engine_loc
           end

           rad_console = math.pow(x,2) + math.pow(y,2)
           rad_console = math.sqrt(rad_console)
--           print ("weee")
            if rad_console > rad_engine_from_terminal then
              engine_room_spawn_confirm = true
              
            end
        end
     end


  end
--  print ("engine attempt", engine_room_spawn_attempt, engine_room_spawn_confirm)
  if engine_room_spawn_confirm == true and engine_room_spawn_attempt <= 50 then
      engine_room_spawn_confirm = true
      map[x_engine + 1][y_engine + 1] = 141
      map[x_engine + 2][y_engine + 1] = 142
      map[x_engine + 1][y_engine + 2] = 143
      map[x_engine + 2][y_engine + 2] = 144

      sphere_x = math.random((x_engine + 3),(x_engine + x_engine_size - 2))
      sphere_y = math.random((y_engine + 1),(y_engine + y_engine_size - 2))
      map[sphere_x][sphere_y] = 140
      engine_room_spawn_attempt = 0
--      print ("engine placed")
      for i = x_engine - 1, x_engine + x_engine_size do -- allow gaps around the side
       for j = y_engine - 1, y_engine + y_engine_size do
         if map[i][j] == 50 then
          map[i][j] = 60 -- locks the doors
         end
       end
      end

      for i = x_engine, x_engine + x_engine_size - 1 do 
       for j = y_engine, y_engine + y_engine_size - 1 do
         finalcheckmap[i][j] = 2
       end
      end 

         
  end
  end
  end
  engine_room_spawn_attempt = engine_room_spawn_attempt + 1
--  if engine_room_spawn_attempt > 10 and engine_room_spawn_confirm == false then  -- get out clause
--    engine_room_spawn_confirm = true
--  end
  end -- ends the while loop
end


air_purification_room_spawn_prob = math.random()
air_purification_room_spawn = false
air_purification_spawn_attempt = 0
air_purification_number = 0


if air_purification_room_spawn_prob <= 0.85 then
while air_purification_room_spawn == false and air_purification_spawn_attempt <= 20 do

  air_purification_number = math.random(2,map_room_count)
  air_purification_spawn_attempt = air_purification_spawn_attempt + 1
  if air_purification_number ~= helm_room_number and air_purification_number ~= engine_room_number and air_purification_number ~= dining_room_number then
    air_purification_room_x = map_room_cord_x[air_purification_number]
    air_purification_room_y = map_room_cord_y[air_purification_number]
    air_purification_room_size_x = map_room_size_x[air_purification_number]
    air_purification_room_size_y = map_room_size_y[air_purification_number]
    air_purification_spawn_attempt = air_purification_spawn_attempt + 1
    for i = air_purification_room_x, (air_purification_room_x + air_purification_room_size_x - 1) do
      if map[i][air_purification_room_y - 1] == 2 then
        if air_purification_room_y > 3 then
         if map[i][air_purification_room_y - 2] == 0 then
          air_purification_spawn = true
          air_purification_room_spawn = true
          air_purification_spawn_attempt = 0
         end
        else
          air_purification_spawn = true
          air_purification_room_spawn = true
          air_purification_spawn_attempt = 0
        end
       end
     end
    if air_purification_spawn_attempt > 20 then
      air_purification_spawn = false
      air_purification_room_spawn = true
      air_purification_number = 0
    end
  end
end
air_purification_placed = false
if air_purification_spawn == true and air_purification_spawn_attempt <= 20 then
while air_purification_placed == false and air_purification_spawn_attempt <= 20 do
  air_purification_spawn_attempt = air_purification_spawn_attempt + 1
  air_purification_wall_loc = math.random(air_purification_room_x, air_purification_room_x + air_purification_room_size_x - 1)
  if map[air_purification_wall_loc][air_purification_room_y - 1] == 2 then
    if air_purification_room_y > 1 then
     if map[air_purification_wall_loc][air_purification_room_y - 2] == 0 then
       map[air_purification_wall_loc][air_purification_room_y - 1] = 160
       air_purification_placed = true
       air_purification_spawn_attempt = 0
     end
    else
       map[air_purification_wall_loc][air_purification_room_y - 1] = 160
       air_purification_placed = true
       air_purification_spawn_attempt = 0
    end
  end
end
air_floor_loc_x = math.random(air_purification_room_x + 1, air_purification_room_x + air_purification_room_size_x - 2)
air_floor_loc_y = math.random(air_purification_room_y + 1, air_purification_room_y + air_purification_room_size_y - 2)
map[air_floor_loc_x][air_floor_loc_y] = 161

empty_first_can_attempt = 0

if air_purification_placed == true then
if air_purification_room_size_x > 5 then
if air_purification_room_size_y > 5 then
  spawn_first_empty_prob = 0.7
  spawn_second_empty = 0.7
  spawn_first_empty = math.random()
  spawn_second_empty_prob = math.random()
  if spawn_first_empty < spawn_first_empty_prob then
     first_empty_spawn_confirm = false
     while first_empty_spawn_confirm == false do
      empty_first_can_attempt = empty_first_can_attempt + 1
      empty_first_can_loc_x = math.random(air_purification_room_x + 1, air_purification_room_x + air_purification_room_size_x - 2)
      empty_first_can_loc_y = math.random(air_purification_room_y + 1, air_purification_room_y + air_purification_room_size_y - 2)
      if map[empty_first_can_loc_x][empty_first_can_loc_y - 1] == 1 and map[empty_first_can_loc_x+1][empty_first_can_loc_y - 1] == 1 and map[empty_first_can_loc_x+1][empty_first_can_loc_y] == 1 and map[empty_first_can_loc_x+1][empty_first_can_loc_y+1] == 1 and map[empty_first_can_loc_x][empty_first_can_loc_y+1] == 1 and map[empty_first_can_loc_x-1][empty_first_can_loc_y+1] == 1 and map[empty_first_can_loc_x-1][empty_first_can_loc_y] == 1 and map[empty_first_can_loc_x-1][empty_first_can_loc_y-1] == 1 and empty_first_can_attempt < 7 then -- full circle
      map[empty_first_can_loc_x][empty_first_can_loc_y] = 162
      first_empty_spawn_confirm = true
      end
      if empty_first_can_attempt <= 7 then
        first_empty_spawn_confirm = true
      end

     end
      empty_second_can_attempt = 0
      if spawn_second_empty < spawn_second_empty_prob then
       second_can_spawn_confirm = false
       while second_can_spawn_confirm == false and empty_second_can_attempt <=20 do
        empty_second_can_attempt = 0
        empty_second_can_attempt = empty_second_can_attempt + 1
        empty_second_can_loc_x = math.random(air_purification_room_x + 1, air_purification_room_x + air_purification_room_size_x - 2)
        empty_second_can_loc_y = math.random(air_purification_room_y + 1, air_purification_room_y + air_purification_room_size_y - 2)
        if map[empty_second_can_loc_x][empty_second_can_loc_y - 1] == 1 and map[empty_second_can_loc_x+1][empty_second_can_loc_y - 1] == 1 and map[empty_second_can_loc_x+1][empty_second_can_loc_y] == 1 and map[empty_second_can_loc_x+1][empty_second_can_loc_y+1] == 1 and map[empty_second_can_loc_x][empty_second_can_loc_y+1] == 1 and map[empty_second_can_loc_x-1][empty_second_can_loc_y+1] == 1 and map[empty_second_can_loc_x-1][empty_second_can_loc_y] == 1 and map[empty_second_can_loc_x-1][empty_second_can_loc_y-1] == 1 and empty_second_can_attempt < 7 then -- full circle
        map[empty_second_can_loc_x][empty_second_can_loc_y] = 162
          second_can_spawn_confirm = true      
        end
--        if empty_second_can_attempt <=20 then
--         second_can_spawn_confirm = true
--        end
       end          
      end
   end
end
end
end

end -- first if about spawning
end -- second


---- final check to see if the lock is accessable


---- final checks 

-- air purifier spawn final check
--print ("final", dining_room_probability_spawn, apple_placed, air_purification_room_spawn_prob, air_purification_placed, security_terminal_generation)

if security_terminal_generation == true then
finalcheckmap[console_x][console_y] = 1
buckettestfinal = true
finalcheckmap = bucketfill(finalcheckmap,start_point_x,start_point_y,1,7)
 for i=1, mapmax_x do
   for j=1, mapmax_y do
      if finalcheckmap[i][j] == 1 then
        buckettestfinal = false
      end
   end
 end
end


--print ("final", main_screen_placement, security_terminal_generation, "engine", engine_room_spawn_confirm, "apple", apple_placed, buckettestfinal)

if buckettestfinal == true then
  if security_terminal_generation_attempt <= 100 and security_terminal_generation == true and helm_generation_spawn_attempt <= 20 and main_screen_placement_counter <= 10 and main_screen_placement == true and  air_purification_room_spawn_prob <= 0.85 and air_purification_placed == true and dining_room_probability_spawn > 0.45 and apple_placed == false then
    game_playable = true
  end

-- dining room spawn final check
  if security_terminal_generation_attempt <= 100 and security_terminal_generation == true and helm_generation_spawn_attempt <= 20 and main_screen_placement_counter <= 10 and main_screen_placement == true and dining_room_probability_spawn <= 0.45 and apple_placed == true and air_purification_room_spawn_prob > 0.85 and air_purification_placed == false then
    game_playable = true
  end

-- dining room and air purifier

  if security_terminal_generation_attempt <= 100 and security_terminal_generation == true and helm_generation_spawn_attempt <= 20 and main_screen_placement_counter <= 10 and main_screen_placement == true and air_purification_room_spawn_prob <= 0.85 and air_purification_placed == true and dining_room_probability_spawn <= 0.45 and apple_placed == true then
    game_playable = true
  end

-- neither

  if security_terminal_generation_attempt <= 100 and security_terminal_generation == true and helm_generation_spawn_attempt <= 20 and main_screen_placement_counter <= 10 and dining_room_probability_spawn > 0.45 and air_purification_room_spawn_prob > 0.85 and air_purification_placed == false and apple_placed == false and main_screen_placement == true then
    game_playable = true
  end
end


end  -- ends the 1000 long while loop

--------------------------------

-- help written in blood

blood_spawn_prob = 0.09
for i = 1, mapmax_x do
  for j = 1, mapmax_y do 
   if map[i][j] == 2 then
     if map[i][j - 1] == 0 and map[i][j + 1] == 1 then
       blood_random_gen = math.random()
       if blood_random_gen <= blood_spawn_prob then
         map[i][j] = 150
       end
     end
   end
  end
end

-- energy

energy_spawn_prob = 0.09
for i = 1, mapmax_x do
  for j = 1, mapmax_y do 
   if map[i][j] == 2 then
     if map[i][j - 1] == 0 and map[i][j + 1] == 1 then
       energy_spawn_gen = math.random()
       if energy_spawn_gen <= energy_spawn_prob then
         map[i][j] = 103
       end
     end
   end
  end
end

energy_empty_spawn_prob = 0.10
for i = 1, mapmax_x do
  for j = 1, mapmax_y do 
   if map[i][j] == 2 then
     if map[i][j - 1] == 0 and map[i][j + 1] == 1 then
       energy_empty_spawn_gen = math.random()
       if energy_empty_spawn_gen <= energy_empty_spawn_prob then
         map[i][j] = 101
       end
     end
   end
  end
end

door_to_space_spawn_prob = 0.04
for i = 2, mapmax_x - 1 do
  for j = 2, mapmax_y - 1 do 
     if map[i][j] == 2 then
       if map[i][j - 1] == 0 and map[i][j + 1] == 1 and  map[i - 1][j] ==2 and map[i + 1][j] == 2 then
        door_to_space_spawn_gen = math.random()
        if door_to_space_spawn_gen < door_to_space_spawn_prob then
          map[i][j] = 50
        end
       end
       if map[i][j + 1] == 0 and map[i][j - 1] == 1 and map[i - 1][j] ==2 and map[i + 1][j] == 2 then
        door_to_space_spawn_gen = math.random()
        if door_to_space_spawn_gen < door_to_space_spawn_prob then
          map[i][j] = 50
        end
       end
       if map[i + 1][j] == 0 and map[i - 1][j] == 1 and map[i][j - 1] == 2 and map[i][j + 1] == 2 then
        door_to_space_spawn_gen = math.random()
        if door_to_space_spawn_gen < door_to_space_spawn_prob then
          map[i][j] = 50
        end
       end
       if map[i - 1][j] == 0 and map[i + 1][j] == 1 and map[i][j - 1] == 2 and map[i][j + 1] == 2 then
        door_to_space_spawn_gen = math.random()
        if door_to_space_spawn_gen < door_to_space_spawn_prob then
          map[i][j] = 50
        end
       end
     end
  end
end

------------

--mapcoordtest = "map coords "
--maproomsizetest = "map sizes "
--for j = 1, map_room_count do
--   mapcoordtest = mapcoordtest .. "(" ..  map_room_cord_x[j] .. "," .. map_room_cord_y[j] .. ")" .. " "
--   maproomsizetest = maproomsizetest .. "(" ..  map_room_size_x[j] .. "," .. map_room_size_y[j] .. ")" .. " " 
--end


--arrayteststring = ""
--for j = 1, mapmax_y do
--  for i = 1, mapmax_x do
--      arrayteststring = arrayteststring .. map[i][j] .. " "
--  end
--  print (arrayteststring)
--  arrayteststring = ""
--end

--finalcheckmap[start_point_x][start_point_y] = 9

--print (" ")
--arrayteststring2 = ""
--for j = 1, mapmax_y do
--  for i = 1, mapmax_x do
--      arrayteststring2 = arrayteststring2 .. finalcheckmap[i][j] .. " "
--  end
--  print (arrayteststring2)
--  arrayteststring2 = ""
--end

return map,roommap,start_point_x,start_point_y end
