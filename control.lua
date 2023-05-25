
function initPlayer(player)
	if player.character == nil then return end
	if global == nil then
		global = {}
	end
	if global.donePlayers == nil then
		global.donePlayers = {}
	end
	if global.donePlayers[player] ~= nil then return end
	global.donePlayers[player] = true

	player.get_inventory(defines.inventory.character_main).clear()
	player.get_inventory(defines.inventory.character_armor).clear()
	player.get_inventory(defines.inventory.character_guns).clear()
	player.get_inventory(defines.inventory.character_ammo).clear()

	local items = {
		-- resources
		{"coal", 150},
		{"iron-plate", 500},
		{"copper-plate", 300},
		{"iron-gear-wheel", 100},
		{"electronic-circuit", 100},
		-- belts
		{"fast-transport-belt", 2000},
		{"fast-underground-belt", 200},
		{"fast-splitter", 50},
		-- pipes
		{"pipe-to-ground", 50},
		{"pipe", 50},
		-- other logistic
		{"fast-inserter", 500},
		{"steel-chest", 50},
		{"construction-robot", 10},
		-- buildings
		{"steel-furnace", 50},
		{"assembling-machine-2", 100},
		{"electric-mining-drill", 50},
		-- electricity
		{"medium-electric-pole", 200},
		{"big-electric-pole", 50},
		{"boiler", 10},
		{"steam-engine", 20},
		{"offshore-pump", 5},
	}
	for _, v in pairs(items) do
		player.insert{name = v[1], count = v[2]}
	end

	local armorInventory = player.get_inventory(defines.inventory.character_armor)
	armorInventory.insert("power-armor")
	local armorGrid = armorInventory.find_item_stack("power-armor").grid

	local equipment = {
		"fusion-reactor-equipment",
		"exoskeleton-equipment",
		"personal-roboport-equipment",
	}
	for _, v in pairs(equipment) do
		armorGrid.put{name = v}
	end

	player.get_inventory(defines.inventory.character_guns).insert{name = "submachine-gun", count = 1}
	player.get_inventory(defines.inventory.character_ammo).insert{name = "piercing-rounds-magazine", count = 50}
end

function onPlayerJoined(event)
	local player = game.players[event.player_index]
	initPlayer(player)
end

script.on_event({defines.events.on_player_joined_game, defines.events.on_player_created}, onPlayerJoined)

function onModInit()
	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_disable_crashsite", true)
		remote.call("freeplay", "set_skip_intro", true)
	end
end

script.on_init(onModInit)
