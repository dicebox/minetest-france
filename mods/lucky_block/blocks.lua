
-- Default tree schematics
local dpath = minetest.get_modpath("default") .. "/schematics/"

lucky_block:add_schematics({
	{"appletree", dpath .. "apple_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"jungletree", dpath .. "jungle_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"defpinetree", dpath .. "pine_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"acaciatree", dpath .. "acacia_tree_from_sapling.mts", {x = 4, y = 1, z = 4}},
	{"aspentree", dpath .. "aspen_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
})

-- Default blocks
lucky_block:add_blocks({
	{"sch", "watertrap", 1, true},
	{"tel"},
	{"dro", {"wool:"}, 10, true},
	{"dro", {"default:apple"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"default:snow"}, 10},
	{"nod", "default:chest", 0, {
		{name = "bucket:bucket_water", max = 1},
		{name = "default:wood", max = 3},
		{name = "default:pick_diamond", max = 1},
		{name = "default:coal_lump", max = 3}}},
	{"sch", "sandtrap", 1, true},
	{"nod", "flowers:rose", 0},
	{"sch", "defpinetree", 0, false},
	{"sch", "lavatrap", 1, true},
	{"dro", {"default:mese_crystal_fragment", "default:mese_crystal"}, 10},
	{"exp"},
	{"nod", "default:diamondblock", 0},
	{"nod", "default:steelblock", 0},
	{"nod", "default:dirt", 0},
	{"dro", {"dye:"}, 10, true},
	{"dro", {"default:sword_steel"}, 1},
	{"sch", "jungletree", 0, false},
	{"dro", {"default:pick_steel"}, 1},
	{"dro", {"default:shovel_steel"}, 1},
	{"dro", {"default:coal_lump"}, 3},
	{"sch", "acaciatree", 0, false},
	{"dro", {"default:axe_steel"}, 1},
	{"dro", {"default:sword_bronze"}, 1},
	{"exp"},
	{"sch", "platform", 1, true},
	{"nod", "default:wood", 0},
	{"dro", {"default:pick_bronze"}, 1},
	{"sch", "aspentree", 0, false},
	{"dro", {"default:shovel_bronze"}, 1},
	{"nod", "default:gravel", 0},
	{"dro", {"default:axe_bronze"}, 1},
})

-- Farming mod (default)
if minetest.get_modpath("farming") then
	lucky_block:add_blocks({
		{"dro", {"farming:bread"}, 5},
		{"sch", "instafarm", 0, true},
		{"nod", "default:water_source", 1},
	})

end -- END farming mod

-- Home Decor mod
if minetest.get_modpath("homedecor") then
	lucky_block:add_blocks({
		{"nod", "homedecor:toilet", 0},
		{"nod", "homedecor:table", 0},
		{"nod", "homedecor:chair", 0},
		{"nod", "homedecor:table_lamp_off", 0},
	})
end

-- Boats mod
if minetest.get_modpath("boats") then
	lucky_block:add_blocks({
		{"dro", {"boats:boat"}, 1},
	})
end

-- Carts mod
if minetest.get_modpath("carts")
or minetest.get_modpath("boost_cart") then
	lucky_block:add_blocks({
		{"dro", {"boats:boat"}, 1},
		{"dro", {"default:rail"}, 10},
		{"dro", {"carts:powerrail"}, 5},
	})
end

-- 3D Armor mod
if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:boots_wood", "3d_armor:leggings_wood", "3d_armor:chestplate_wood", "3d_armor:helmet_wood"}, 1},
	{"dro", {"3d_armor:boots_steel", "3d_armor:leggings_steel", "3d_armor:chestplate_steel", "3d_armor:helmet_steel"}, 1},
	{"dro", {"3d_armor:boots_gold", "3d_armor:leggings_gold", "3d_armor:chestplate_gold", "3d_armor:helmet_gold"}, 1},
	{"dro", {"3d_armor:boots_cactus", "3d_armor:leggings_cactus", "3d_armor:chestplate_cactus", "3d_armor:helmet_cactus"}, 1},
	{"dro", {"3d_armor:boots_bronze", "3d_armor:leggings_bronze", "3d_armor:chestplate_bronze", "3d_armor:helmet_bronze"}, 1},
	{"lig"},
})
end

-- 3D Armor's Shields mod
if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_wood"}, 1},
	{"dro", {"shields:shield_steel"}, 1},
	{"dro", {"shields:shield_gold"}, 1},
	{"dro", {"shields:shield_cactus"}, 1},
	{"dro", {"shields:shield_bronze"}, 1},
	{"exp"},
})
end

-- Fire mod
if minetest.get_modpath("fire") then
lucky_block:add_blocks({
	{"dro", {"fire:flint_and_steel"}, 1},
	{"nod", "fire:basic_flame", 1},
	{"nod", "fire:permanent_flame", 1},
})
end

-- TNT mod
if minetest.get_modpath("tnt") then
local p = "tnt:tnt_burning"
lucky_block:add_blocks({
	{"dro", {"tnt:gunpowder"}, 5, true},
	{"fal", {p, p, p, p, p}, 1, true, 4},
})
end

-- More Ore's mod
if minetest.get_modpath("moreores") then
lucky_block:add_blocks({
	{"nod", "moreores:tin_block", 0},
	{"nod", "moreores:silver_block", 0},
	{"fal", {"default:sand", "default:sand", "default:sand", "default:sand", "default:sand", "default:sand", "moreores:mithril_block"}, 0},
	{"dro", {"moreores:pick_silver"}, 1},
	{"dro", {"moreores:pick_mithril"}, 1},
	{"tro", "moreores:silver_block"},
	{"dro", {"moreores:shovel_silver"}, 1},
	{"dro", {"moreores:shovel_mithril"}, 1},
	{"dro", {"moreores:axe_silver"}, 1},
	{"dro", {"moreores:axe_mithril"}, 1},
	{"tro", "moreores:mithril_block"},
	{"dro", {"moreores:hoe_silver"}, 1},
	{"dro", {"moreores:hoe_mithril"}, 1},
	{"lig"},
})

if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:helmet_mithril"}, 1},
	{"dro", {"3d_armor:chestplate_mithril"}, 1},
	{"dro", {"3d_armor:leggings_mithril"}, 1},
	{"dro", {"3d_armor:boots_mithril"}, 1},
})
end

if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_mithril"}, 1},
})
end

end

-- Bows mod
if minetest.get_modpath("bows") then
lucky_block:add_blocks({
	{"dro", {"bows:bow_wood"}, 1},
	{"dro", {"bows:bow_steel"}, 1},
	{"dro", {"bows:bow_bronze"}, 1},
	{"dro", {"bows:arrow"}, 5},
	{"dro", {"bows:arrow_steel"}, 5},
	{"dro", {"bows:arrow_mese"}, 5},
	{"dro", {"bows:arrow_diamond"}, 5},
})
end

-- Xanadu Server specific
if minetest.get_modpath("xanadu") then
lucky_block:add_blocks({
	{"dro", {"xanadu:cupcake"}, 8},
	{"spw", "mobs:creeper", 1, nil, nil, 5, "Mr. Boombastic"},
	{"nod", "default:chest", 0, {
		{name = "xanadu:axe_super", max = 1},
		{name = "xanadu:pizza", max = 2}}},
	{"dro", {"paintings:"}, 10, true},
	{"spw", "mobs:greensmall", 4},
	{"lig"},
	{"dro", {"carpet:"}, 10, true},
	{"dro", {"xanadu:bone"}, 2},
	{"spw", "mobs:bat", 3},
	{"dro", {"xanadu:cupcake_chocolate"}, 8},
	{"dro", {"xanadu:bacon"}, 8},
	{"dro", {"3d_armor:boots_bunny"}, 1},
	{"dro", {"carpet:wallpaper_"}, 10, true},
	{"nod", "default:chest", 0, {
		{name = "mobs:mese_monster_wing", max = 1}}},
	{"exp"},
	{"dro", {"more_chests:giftbox_red", "more_chests:giftbox_green"}, 1},
	{"dro", {"xanadu:taco"}, 2},
	{"dro", {"xanadu:gingerbread_man"}, 2},
	{"spw", "mobs:evil_bonny", 1},
})
end
