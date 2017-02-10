
-- unlit torch
minetest.register_node("real_torch:torch", {

	description = "Unlit Torch",
	drawtype = "torchlike",
	tiles = {
		{name = "real_torch_on_floor.png"},
		{name = "real_torch_ceiling.png"},
		{name = "real_torch_wall.png"},
	},
	inventory_image = "real_torch_on_floor.png",
	wield_image = "real_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5 - 0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5 + 0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5 + 0.3, 0.3, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, attached_node = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})


-- override default torches to burn out after 8-10 minutes
minetest.override_item("default:torch", {

	on_timer = function(pos, elapsed)
		local p2 = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "real_torch:torch", param2 = p2})
	end,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(480, 600))
	end,
})
