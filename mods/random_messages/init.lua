--[[
RandomMessages mod by arsdragonfly.
arsdragonfly@gmail.com
6/19/2013
xisd : 14/01/2017
--]]

local modname = minetest.get_current_modname()

-- Intllib.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

math.randomseed(os.time())

random_messages = {}
random_messages.intllib = S		-- Intllib
random_messages.options = {} 	-- Options defined in config.lua stored in this table
random_messages.messages = {} 	-- This table contains all messages.

-- Read config file
dofile(minetest.get_modpath(modname).."/config.lua")

--Time between two subsequent messages.
-- 0 to use default (120)
local MESSAGE_INTERVAL = random_messages.options.messages_interval
-- Added default messages file
local default_messages_file_name = random_messages.options.default_messages_file_name or "messages"
local display_chat_messages	= random_messages.options.display_chat_messages
local place_messages_signs	= random_messages.options.place_messages_signs

-- Define langage (code from intllib mod)
local LANG = minetest.setting_get("language")
if not (LANG and (LANG ~= "")) then LANG = os.getenv("LANG") end
if not (LANG and (LANG ~= "")) then LANG = "en" end
LANG = LANG:sub(1, 2)

function table.count( t )
	local i = 0
	for k in pairs( t ) do i = i + 1 end
	return i
end

function table.random( t )
	local rk = math.random( 1, table.count( t ) )
	local i = 1
	for k, v in pairs( t ) do
		if ( i == rk ) then return v, k end
		i = i + 1
	end
end

function random_messages.initialize() --Set the interval in minetest.conf.
	minetest.setting_set("random_messages_interval",120)
	minetest.setting_save();
	return 120
end

function random_messages.set_interval() --Read the interval from minetest.conf(set it if it doesn'st exist)
	MESSAGE_INTERVAL = tonumber(minetest.setting_get("random_messages_interval")) or random_messages.initialize()
end

function random_messages.check_params(name,func,params)
	local stat,msg = func(params)
	if not stat then
		minetest.chat_send_player(name,msg)
		return false
	end
	return true
end

function random_messages.read_messages()
	local line_number = 1
	-- Defizne input 
	local input = io.open(minetest.get_worldpath()..'/'..modname,"r")
	-- no input file found (in the world folder)
	if not input then
		-- look a localized default file in (in the mod folder)
		local default_input = io.open(minetest.get_modpath(modname)..'/'..default_messages_file_name..'.'..LANG..'.txt',"r")
		local output = io.open(minetest.get_worldpath()..'/'..modname,"w")
		if not default_input then
			-- localised file not found, look for a generic default file (in the mod folder)
			default_input = io.open(minetest.get_modpath(modname)..'/'..default_messages_file_name..'.txt',"r")
		end
		if not default_input then
			-- Now we're out of options, blame the admin
			output:write("Blame the server admin! He/She has probably not edited the random messages yet.\n")
			output:write("Tell your dumb admin that this line is in (worldpath)/random_messages \n")
		else
			-- or write default_input content in worldpath message file
			local content = default_input:read("*all")
			output:write(content)
		end
		io.close(output)
		if default_input then io.close(default_input) end
		input = io.open(minetest.get_worldpath()..'/'..modname,"r")
	end
	-- we should have input by now, so lets read it
	for line in input:lines() do
		random_messages.messages[line_number] = line
		line_number = line_number + 1
	end
	-- close it
	io.close(input)
end

function random_messages.display_message(message_number)
	local msg = random_messages.messages[message_number] or message_number
	if msg then
		minetest.chat_send_all(msg)
	end
end

function random_messages.show_message()
	random_messages.display_message(table.random(random_messages.messages))
end

function random_messages.list_messages()
	local str = ""
	for k,v in pairs(random_messages.messages) do
		str = str .. k .. " | " .. v .. "\n"
	end
	return str
end

function random_messages.remove_message(k)
	table.remove(random_messages.messages,k)
	random_messages.save_messages()
end

function random_messages.add_message(t)
	table.insert(random_messages.messages,table.concat(t," ",2))
	random_messages.save_messages()
end

function random_messages.save_messages()
		local output = io.open(minetest.get_worldpath()..'/'..modname,"w")
		for k,v in pairs(random_messages.messages) do
			output:write(v .. "\n")
		end
		io.close(output)
end

--When server starts:
random_messages.set_interval()
random_messages.read_messages()

if display_chat_messages then
	local TIMER = 0
	minetest.register_globalstep(function(dtime)
		TIMER = TIMER + dtime;
		if TIMER > MESSAGE_INTERVAL then
			random_messages.show_message()
			TIMER = 0
		end
	end)
end

-- Register chat commands
dofile(minetest.get_modpath(modname).."/chat_commands.lua")

-- Place signs in the world with random messages on it
if place_messages_signs then
	dofile(minetest.get_modpath(modname).."/signs.lua")
end
