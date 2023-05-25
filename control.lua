
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
		{"iron-plate",400},
		{"copper-plate",400},
		{"steel-plate",400},
		{"stone",400},
		{"wood",400},
		-- belts
		-- pipes
		-- other logistic
		{"construction-robot", 50},
		{"charged-antimatter-fuel-cell",2},
		-- buildings
		-- electricity
		-- equipment
		{"kr-superior-exoskeleton-equipment",12},
		{"personal-roboport-mk2-equipment",2},
		{"antimatter-reactor-equipment",2},
		{"belt-immunity-equipment",1},
		{"imersite-night-vision-equipment",1},
		{"big-battery-mk3-equipment",1},
		{"battery-mk3-equipment",1},
	}
	for _, v in pairs(items) do
		player.insert{name = v[1], count = v[2]}
	end

	local armorInventory = player.get_inventory(defines.inventory.character_armor)
	armorInventory.insert("power-armor")
	local armorGrid = armorInventory.find_item_stack("power-armor").grid

	local equipment = {
		-- equipment
		"power-armor-mk4",
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
