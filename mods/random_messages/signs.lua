local modname = minetest.get_current_modname()

local S = random_messages.intllib

	
-- Height limits to place the signs
local h_min = random_messages.options.signs.h_min or -200
local h_max = random_messages.options.signs.h_max or 200
local signs_per_chunk = random_messages.options.signs.signs_per_chunk or 1

-- Build nodes list  
local node_under_int	= random_messages.options.signs.node_under_list
local node_under_bool	= nil
if node_under_int and #node_under_int > 0 then
	node_under_bool = {}
	for _,name in ipairs(node_under_int) do node_under_bool[name] = true end
end

-- Register yard sign node if no yard sign
if minetest.get_modpath("default") 
 and minetest.get_modpath("signs_lib") == nil
 and minetest.get_modpath("signs") == nil 	
 then
	local defsign = minetest.registered_nodes["default:sign_wall_wood"]
	local y_on_construct, y_on_receive_fields, y_sounds, y_groups
	if defsign then	
		y_on_construct = defsign.on_construct
		y_on_receive_fields = defsign.on_receive_fields
		y_sound = defsign.sound
		y_groups = defsign.groups
	end	
	
	-- New Yard Sign
	minetest.register_node(modname..":sign_yard", {
		description = S("Yard Sign"),
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
					{-0.4375, -0.25, -0.0625, 0.4375, 0.375, 0},
					{-0.0625, -0.5, -0.0625, 0.0625, -0.1875, 0},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.4375, -0.5, -0.0625, 0.4375, 0.375, 0}
		},
		tiles = {"rm_signs_top.png", "rm_signs_bottom.png", "rm_signs_side.png", "rm_signs_side.png", "rm_signs_back.png", "rm_signs_front.png"},
		inventory_image = "rm_signs_front.png",
		wield_image = "rm_signs_front.png",
		groups = y_groups or {choppy = 2, attached_node = 1, flammable = 2, oddly_breakable_by_hand = 3},
		sound = y_sound,
		on_construct = y_on_construct,
		on_receive_fields = y_on_receive_fields,
	})
	
	-- Recipe
	minetest.register_craft({
		output = modname..':sign_yard',
		recipe = {
			{'default:sign_wall_wood'},
			{'group:stick'},
		}
	})
	
	minetest.register_alias(":signs:sign_yard", modname..':sign_yard')
end


function place_sign(pos)
	-- Define message to display
	local message_number = table.random(random_messages.messages)
	local msg = random_messages.messages[message_number] or message_number
	if not msg then return end
			
	-- Define the rest of the sign
	local sign = {}
	-- -- Name
	if minetest.registered_nodes["signs:sign_yard"] then
		sign.name = "signs:sign_yard"		
	else sign.name = modname..":sign_yard"	
	end
	-- -- Facedir
	-- find possible faces
	local xp, xm, zp, zm
	xp = minetest.get_node({x=pos.x+1,y=pos.y, z=pos.z})
	xm = minetest.get_node({x=pos.x-1,y=pos.y, z=pos.z})
	zp = minetest.get_node({x=pos.x,y=pos.y, z=pos.z+1})
	zm = minetest.get_node({x=pos.x,y=pos.y, z=pos.z-1})

	local facedirs = {}
	if(xp.name=="air" or xp.name=="default:water_source") then
		table.insert(facedirs, minetest.dir_to_facedir({x=-1,y=0,z=0}))
	end
	if(xm.name=="air" or xm.name=="default:water_source") then
		table.insert(facedirs, minetest.dir_to_facedir({x=1,y=0,z=0}))
	end
	if(zp.name=="air" or zp.name=="default:water_source") then
		table.insert(facedirs, minetest.dir_to_facedir({x=0,y=0,z=-1}))
	end
	if(zm.name=="air" or zm.name=="default:water_source") then
		table.insert(facedirs, minetest.dir_to_facedir({x=0,y=0,z=1}))
	end
						
	-- choose a random face (if possible)
	if(#facedirs == 0) then
		minetest.set_node({x=pos.x,y=pos.y, z=pos.z+1},{name='air'})
		sign.param2 = minetest.dir_to_facedir({x=0,y=0,z=1})
	else
		sign.param2 = facedirs[math.floor(math.random(#facedirs))]
	end
								
	-- Lastly: place the sign
	minetest.set_node(pos,sign)
	local meta = minetest.get_meta(pos)
	meta:set_string("text",msg)
	meta:set_string("infotext",msg) 

end 


--
-- Place signs when generating the area
--
minetest.register_on_generated(function(minp, maxp, seed)
		
	-- How many chances signs haves to appear in this chunk
	local chances = random_messages.options.signs.chance_of_signs_in_chunk
	-- Ensure chances is a number 
	if type(chances) ~= "number" then chances = 1
	-- If number is higher than one, it is a fraction of 1
	elseif chances > 1 then	chances = 1/chances end
	-- Convert to a percentage
	local cpc = math.floor(chances * 100)
	-- Pick a random number between 1 and 100
	-- Return if number picked is higher than chance percent
	if ( math.random(0,100) > cpc ) then return end
			

	-- Most of the following code was adapted from tsm_chests_exemple 
		
	-- Get the water level and convert it to a number
	local water_level = minetest.setting_get("water_level")
	if water_level == nil or type(water_level) ~= "number" then
		water_level = 1
	else
		water_level = tonumber(water_level)
	end

	-- signs minimum and maximum spawn height
	local height_min = water_level + h_min 
	local height_max = water_level + h_max

	if(maxp.y < height_min or minp.y > height_max) then
		return
	end	
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	for i=1, signs_per_chunk do
		local pos = {x=math.random(minp.x,maxp.x),z=math.random(minp.z,maxp.z), y=minp.y}

		 -- Find ground level (look for air or liquid above something else)
		local ground = nil
		local top = y_max	
		local top_node = minetest.get_node({x=pos.x,y=y_max,z=pos.z})
		if top_node.name ~= "air" and minetest.get_node_group(top_node.name, "liquid") < 1 then
			for y=y_max,y_min,-1 do
				local p = {x=pos.x,y=y,z=pos.z}
				if minetest.get_node(p).name == "air" or minetest.get_node_group(minetest.get_node(p).name, "liquid") > 0 then
					top = y
					break
				end
			end
		end
		for y=top,y_min,-1 do
			local p = {x=pos.x,y=y,z=pos.z}
			if minetest.get_node(p).name ~= "air" and minetest.get_node_group(top_node.name, "liquid") < 1 then
				ground = y
				break
			end
		end
		
		if(ground~=nil) then
			local sign_pos = {x=pos.x,y=ground+1, z=pos.z}
			local nn = minetest.get_node(sign_pos).name	-- sign node name (before it becomes a sign)

			-- Return if node isn't air
			 if nn ~= "air" then return end
		
			-- Get node under
			local under = minetest.get_node({x=pos.x, y=ground, z=pos.z}).name
			local under_def = minetest.registered_nodes[under] 
			
			-- Replace plants and other buildable to nodes instead of placing on it
			if under_def and under_def.buildable_to then
				ground = ground - 1
				sign_pos = {x=pos.x,y=ground+1, z=pos.z}
				nn = minetest.get_node(sign_pos).name
				under = minetest.get_node({x=pos.x, y=ground, z=pos.z}).name
			end
			
			-- Return if building on something else that nodes listed if config list
			if node_under_bool then -- if array is not declared continue without testing
				if not node_under_bool[under] then return end		
			end
			-- Return if building in water
			if minetest.get_node_group(nn, "liquid") > 1 then return end
		
			-- Place the sign 
			place_sign(sign_pos)
			
		end	
	end		
end)


--
-- Place signs in already generated areas
--
if random_messages.options.signs.use_signs_abm then
	minetest.register_abm({
		nodenames = node_under_int,
		interval = random_messages.options.signs.signs_abm_interval or 1200,
		chance = random_messages.options.signs.signs_abm_chance or 150,
		action = function(pos)
			-- Sign pos
			pos.y=pos.y+1
			-- Place only in surface
			if minetest.get_node(pos).name == 'air' then
				-- Get sign name
				local sign_name
				if minetest.registered_nodes["signs:sign_yard"] then
					sign_name = "signs:sign_yard"		
				else sign_name = modname..":sign_yard"	
				end
				-- Get signs number limit 
				local limit = random_messages.options.signs.signs_number_limit or 1
				local r = random_messages.options.signs.signs_limit_radius or 25
				local minp = {x=pos.x-r,y=pos.y-r, z=pos.z-r}
				local maxp = {x=pos.x+r,y=pos.y+r, z=pos.z+r}
				local signs_around = minetest.find_nodes_in_area(minp,maxp,sign_name)
				if signs_around and #signs_around < limit then 
					place_sign(pos)
				end
			end
		end,
	})
end

