
random_messages.options = {}
			
	-- True / False : Should messages be displayed on chat
random_messages.options.display_chat_messages	= false
			
	-- True / False : Should signs with messages be placed around the world
random_messages.options.place_messages_signs	= true

random_messages.options.use_signs_abm	= true


		
	--Time between two subsequent messages.
	-- 0 to use default (120)
random_messages.options.messages_interval = 300
			
	-- Default messages file name
random_messages.options.default_messages_file_name = "messages"
			
	-- Signs optiosn
random_messages.options.signs = {
			
		-- Table conatining a list of node on wich the signs appears
		node_under_list	= {
				'default:stone',
				'default:mossycobble',

				'default:desert_stone',
				'default:sandstone',
				'default:dirt_with_grass',
				'default:dirt_with_grass_footsteps',
				'default:dirt_with_dry_grass',
				'default:dirt_with_snow',

				'default:sand',
				'default:desert_sand',
				'default:silver_sand',

				'default:gravel',
				'default:clay',
				'default:ice',
				},

		-- height limits for signs to be places 
		h_min = -200,
		h_max = 200,

		-- When a portion of map is generated, how many chances is there that signs will be placed in it
		-- Number will be use a fracion of 1 ( 1/number ) OR a number beween 0 and 1
		-- e.g : 10 will be used as 1/10 -- so its the same as writting 0.1
		-- and it means 10% chances that signs will be placed in a a new chunk 
		chance_of_signs_in_chunk = 1, 		-- 100%

		-- If there is signs it this portions of map, how many will there be ?
		-- Increase this value will to see more signs in the world
		signs_per_chunk= 1,

		-- True / False : Should signs with messages randomly appear in already generated area
		use_signs_abm = true,
		
		-- Abm settings
		signs_abm_interval	 = 3600, 	-- Run every 3600 seconds
		signs_abm_chance	 = 800, 	-- Select every 1 in 800 nodes
		
		-- Limit number of signs in area	
		signs_number_limit   = 1,	-- if there is already 1 signs		
		signs_limit_radius	 = 25,	-- in a 25 nodes radius
									-- then new sign will not be placed
	}
	
