local Articore = {}

-- ########## CHARACTER MANAGEMENT ##########
--- Adds a character with attributes and prefab options
--- @param character (string) Character's prefab name
--- @param name (string) Display name of the character
--- @param gender (string) Gender of the character
--- @param title (string) Title displayed in selection screen
--- @param quote (string) Character's unique quote
--- @param skindesc (string) Description of the default skin
--- @param map (string) Map icon identifier
--- @param speech (string) Speech file prefix
--- @param survivability (string) Slim or grim survivability rating
--- @param addprefabs (boolean) Whether to add a "_none" prefab
--- @param hasvoidclothface (boolean) Whether to add voidcloth face animation
function Articore:AddCharacter(
	character,
	name,
	gender,
	title,
	quote,
	skindesc,
	map,
	speech,
	survivability,
	addprefabs,
	hasvoidclothface
)
	Articore:AddPrefab(character)
	if addprefabs then
		Articore:AddPrefab(character .. "_none")
	end

	if hasvoidclothface and Assets then
		table.insert(Assets, Asset("ANIM", "anim/" .. character .. "_voidclothhat.zip"))
	end

	STRINGS.CHARACTER_NAMES[character] = name
	STRINGS.CHARACTER_TITLES[character] = title
	STRINGS.CHARACTER_QUOTES[character] = '"' .. quote .. '"'
	STRINGS.SKIN_DESCRIPTIONS[character .. "_none"] = skindesc
	STRINGS.SKIN_NAMES[character .. "_none"] = name
	STRINGS.CHARACTER_SURVIVABILITY[character] = survivability

	AddMinimapAtlas("images/map_icons/" .. character .. ".xml")
	STRINGS.NAMES[string.upper(character)] = name
	STRINGS.CHARACTERS[string.upper(character)] = require("speech_" .. speech)

	local skin_modes =
	{ { type = "ghost_skin", anim_bank = "ghost", idle_anim = "idle", scale = 0.75, offset = { 0, -25 } } }
	AddModCharacter(character, gender, skin_modes)
end

-- ########## CHARACTER MANAGEMENT ##########
--- Adds abilities to a character's description
--- @param character (string) Character name
--- @param first (string) First ability description
--- @param second (string) Second ability description
--- @param third (string) Third ability description
function Articore:CharacterAbility(character, first, second, third)
    local lines = {}
    
    if first and first ~= "" then
        table.insert(lines, "*" .. first)
    end
    
    if second and second ~= "" then
        table.insert(lines, "*" .. second)
    end
    
    if third and third ~= "" then
        table.insert(lines, "*" .. third)
    end
    
    STRINGS.CHARACTER_DESCRIPTIONS[character] = table.concat(lines, "\n")
end

--- @param character (string) Character name
--- @param text (string) About me text
function Articore:AddAboutMe(character, text)
	STRINGS.CHARACTER_ABOUTME[character] = text
end

--- Adds a custom character skin
--- @param character (string) Base character prefab
--- @param skin (string) Skin identifier
--- @param name (string) Skin name
--- @param description (string) Skin description
--- @param quote (string) Skin quote
--- @param modded (boolean) Is this a custom modded skin?
--- @param dynamicskin (boolean) Should dynamic animations be used?
--- @param addprefabs (boolean) Should prefab be added?
function Articore:AddCharacterSkin(character, skin, name, description, quote, modded, dynamicskin, addprefabs)
	local charname = modded and skin or character .. "_" .. skin
	if addprefabs then
		AddPrefab(charname)
	end

	STRINGS.SKIN_NAMES[charname] = name
	STRINGS.SKIN_DESCRIPTIONS[charname] = description
	STRINGS.SKIN_QUOTES[charname] = '"' .. quote .. '"'

	if dynamicskin then
		Articore.AddDynamic(charname)
	else
		Articore.AddAnim(charname)
	end

	local PREFAB_SKINS = GLOBAL.PREFAB_SKINS
	local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

	PREFAB_SKINS[character] = PREFAB_SKINS[character] or {}
	SKIN_AFFINITY_INFO[character] = SKIN_AFFINITY_INFO[character] or {}

	table.insert(PREFAB_SKINS[character], charname)
	table.insert(SKIN_AFFINITY_INFO[character], charname)
end

--- Adds an item to the scrapbook system.
--- @param prefab (string) The unique name of the item prefab.
--- @param category (string) The general category of the item (e.g., creature, item, food, giant, thing, POI).
--- @param subcat (string|nil) A subcategory for further classification. Can be `nil`.
--- @param description (string|nil) The text description displayed in the scrapbook. Defaults to "PLACEHOLDER".
--- @param is_burnable (number|nil) Defines if the item is burnable. Will be treated as a fuel source if provided.
--- @param bank (string) The animation bank used for the item.
--- @param build (string) The sprite sheet build used for the item.
--- @param atlas (string) The image atlas associated with the item.
function Articore:AddScrapbookItem(prefab, category, subcat, description, is_burnable, bank, build, anim, atlas)

	local function TableFind(tbl, search_string)
		for key, value in pairs(tbl) do
			if type(value) == "string" and string.find(value, search_string, 1, true) then
				return key, value -- Return the key and the matching value
			end
		end
		return nil -- Return nil if not found
	end
	
    -- Check if the prefab file exists
    if  PrefabFiles and not TableFind(PrefabFiles, prefab) then 
        print("MISSING PREFAB FILE: " .. tostring(prefab))
        return 
    end

    local categories = {
        creature = true,
        item = true,
        food = true,
        giant = true,
        thing = true,
        POI = true,
    }

    category = categories[category] and category or "thing"
    subcat = (subcat ~= nil and subcat ~= "") and subcat or nil

    local scrapbook_prefabs = require("scrapbook_prefabs")
    local scrapbookdata = require("screens/redux/scrapbookdata")

    STRINGS.SCRAPBOOK.SPECIALINFO[string.upper(prefab)] = description or "PLACEHOLDER"
    local scrapbookitems = {
        [prefab] = {
            subcat = subcat,
            fueltype = is_burnable and "BURNABLE" or nil,
            fuelvalue = is_burnable or nil,
            burnable = is_burnable and true or false,
            build = build,
            bank = bank,
            anim = anim or "idle",
            specialinfo = string.upper(prefab),
            deps = {},
        },
    }

	for k, v in pairs(scrapbookitems) do
		if v.subcat and STRINGS.SCRAPBOOK.SUBCATS[string.upper(v.subcat)] == nil then
		  STRINGS.SCRAPBOOK.SUBCATS[string.upper(v.subcat)] = v.subcat -- TEMP fix of missing subcat until end of the beta lmao
		end
		v.name = v.name or k
		v.prefab = k
		v.tex = v.tex or k..".tex"
		v.type = v.type or "item"
		v.deps = v.deps or {}
		v.notes = v.notes or {}
		
		scrapbook_prefabs[k] = true
		scrapbookdata[k] = v
		
	end
end



--- @param music (string) song path
--- @param prefab (string) character prefab name
function Articore:AddCharLobbyMusic(music, prefab, hasreverb)
	AddClassPostConstruct("screens/redux/lobbyscreen", function(self, ...)
		TheFrontEnd = GLOBAL.TheFrontEnd
		if not TheFrontEnd then return end
		if not music then return end

		local root
		local old_character
		local screen
		local old_OnUpdate = self.OnUpdate
		self.OnUpdate = function(self, ...)
			old_OnUpdate(self, ...)
			root = self.panel and self.panel.character_scroll_list
			if root then
				screen = TheFrontEnd:GetActiveScreen()                                                    -- Some error checks
				local character = root:GetCharacter()
				if character and old_character ~= character and character == prefab then -- To prevent it from repeatively running the code too many times
					if not TheFrontEnd:GetSound():PlayingSound("characterselect") then
						TheFrontEnd:GetSound():PlaySound(music, "characterselect")
					end
					TheFrontEnd:GetSound():SetVolume("characterselect", 1)
					if hasreverb then
						

					end
				else
					if TheFrontEnd:GetSound():PlayingSound("characterselect") then
						TheFrontEnd:GetSound():SetVolume("characterselect", 0)
					end
				end
			end
			if TheFrontEnd:GetSound():PlayingSound("characterselect") and self.current_panel_index and self.current_panel_index == 2 then
				TheFrontEnd:GetSound():SetParameter("characterselect", "reverb", 0.19)
			else
				TheFrontEnd:GetSound():SetParameter("characterselect", "reverb", 0.09)
			end
		end

		self.old_stopmusic = self.StopLobbyMusic
		self.StopLobbyMusic = function(self, ...)
			self.old_stopmusic(self, ...)
			TheFrontEnd:GetSound():KillSound("characterselect")
		end
	end)
end

--- Defines a new skin mode for a character
--- @param name (string) Character name
--- @param mode1 (string) Skin mode identifier
--- @param hasclothing (boolean) Does this skin mode support clothing?
function Articore:AddSkinMode(name, mode1, hasclothing)
	if not mode1 then
		return
	end

	local skin_mode = { type = mode1, play_emotes = true }
	table.insert(GLOBAL.MODCHARACTERMODES[name], 1, skin_mode)

	if hasclothing then
		table.insert(GLOBAL.SKIN_TYPES_THAT_RECEIVE_CLOTHING, mode1)
	end
end

-- ########## ASSET MANAGEMENT ##########
--- Adds an animation asset with subfolder support
--- @param anim (string) Name of the animation asset (without extension)
--- @param subfolder (string|nil) Subfolder path (optional)
function Articore:AddAnim(anim, subfolder)
	Assets = Assets or {}
	local path = subfolder and ("anim/" .. subfolder .. "/") or "anim/"
	table.insert(Assets, Asset("ANIM", path .. anim .. ".zip"))
	print("Imported animation: " .. path .. anim .. ".zip")
end

--- Adds a sound asset with subfolder support
--- @param sound (string) Name of the sound file .fsb (without extension)
--- @param soundpkg (string|nil) Sound package name .fev (optional, defaults to sound name)
--- @param subfolder (string|nil) Subfolder path (optional)
function Articore:AddSound(sound, soundpkg, subfolder)
	Assets = Assets or {}
	local path = subfolder and ("sound/" .. subfolder .. "/") or "sound/"
	soundpkg = soundpkg or sound

	table.insert(Assets, Asset("SOUND", path .. sound .. ".fsb"))
	table.insert(Assets, Asset("SOUNDPACKAGE", path .. soundpkg .. ".fev"))
	print("Imported sound: " .. path .. sound .. ".fsb and " .. soundpkg .. ".fev")
end

--- Adds a dynamic animation asset with subfolder support
--- @param anim (string) Name of the dynamic animation asset
--- @param dynamic (string|nil) Dynamic asset name (optional)
--- @param subfolder (string|nil) Subfolder path (optional)
function Articore:AddDynamic(anim, dynamic, subfolder)
	Assets = Assets or {}
	local path = subfolder and ("anim/dynamic/" .. subfolder .. "/") or "anim/dynamic/"
	dynamic = dynamic or anim
	table.insert(Assets, Asset("DYNAMIC_ANIM", path .. anim .. ".zip"))
	table.insert(Assets, Asset("PKGREF", path .. dynamic .. ".dyn"))
	print("Imported dynamic animation: " .. path .. anim .. ".zip and " .. dynamic .. ".dyn")
end

--- Adds a texture asset with subfolder support
--- @param tex (string) Name of the texture asset (without extension)
--- @param atlas (string|nil) Associated atlas name
--- @param inv (boolean) Whether the asset is an inventory item
--- @param subfolder (string|nil) Subfolder path (optional)
function Articore:AddTex(tex, atlas, inv, subfolder)
	Assets = Assets or {}
	atlas = atlas or tex
	local basePath = inv and "images/inventoryimages/" or "images/"
	local path = subfolder and (basePath .. subfolder .. "/") or basePath

	table.insert(Assets, Asset("PKGREF", path .. tex .. ".tex"))
	table.insert(Assets, Asset("DYNAMIC_ATLAS", path .. atlas .. ".xml"))
	print("Imported texture: " .. path .. tex .. ".tex and " .. atlas .. ".xml")
end

--- @param widget (string) Name of the UIAnim widget
--- @param charvoice (string) Character name for voice
function Articore:UIAnim_Talk(widget, charvoice)
	if not widget.GetAnimState then
		return
	end

	local voice_overrides = {
		wathgrithr = "dontstarve_DLC001",
		webber = "dontstarve_DLC001",
		wanda = "wanda2",
		wonkey = "monkeyisland",
		waxwell = "dontstarve/characters/maxwell",
	}

	local tech_voice_base = voice_overrides[charvoice] or "dontstarve"
	local tech_voice = tech_voice_base
		.. "/characters/"
		.. (charvoice == "waxwell" and "maxwell" or charvoice)
		.. "/talk_LP"

	widget:GetAnimState():PlayAnimation("dial_loop", true)

	local random_duration = math.random(2, 5)

	widget.inst:DoTaskInTime(random_duration, function()
		widget:GetAnimState():PlayAnimation("idle_loop", true)
	end)
end

--- @param input (string) variable to check current animation of.
function Articore:GetCurrentAnimation(input)
	if IsConsole() then
		print("This does not work on consoles!")
		return
	end

	local inst = ConsoleWorldEntityUnderMouse() or ThePlayer
	input = input or inst or nil

	if input == nil then
		return
	end

	return string.match(input.entity:GetDebugString(), "anim: ([^ ]+) ")
end

--- @param prefab (string) Prefab to add custom scorebadge to on scoreboard
--- @param state1 (string) State 1 skinmode
--- @param state2 (string) State 2 skinmode
--- @param state3 (string) State 3 skinmode
function Articore:AddScorebBadge(prefab, state1, state2, state3)
	local oldbadge = GLOBAL.GetPlayerBadgeData

	local function GetPlayerBadgeData(character, ghost, state_1, state_2, state_3)
		if character == prefab then
			if ghost then
				return "ghost", "idle", "ghost_skin", 0.15, -55
			else
				if state_1 then
					return "wilson", "idle_loop_ui", state1, 0.23, -50
				elseif state_2 then
					return "wilson", "idle_loop_ui", state2, 0.23, -50
				elseif state_3 then
					return "wilson", "idle_loop_ui", state3, 0.23, -50
				else
					return "wilson", "idle_loop_ui", "normal_skin", 0.23, -50
				end
			end
			-- Execute the old GetPlayerBadgeData function for other characters
		end
		return oldbadge(character, ghost, state_1, state_2, state_3)
	end

	-- Replace the existing GetPlayerBadgeData function
	_G.GetPlayerBadgeData = GetPlayerBadgeData
end

-- ########## WORLD ENTITIES ##########
--- Adds a prefab asset
--- @param prefab (string) Name of the prefab to add
--- @param name (name) Name for the prefab
--- @param craftstring (string) string used in crafting menu
function Articore:AddPrefab(prefab, name, craftstring)
	PrefabFiles = PrefabFiles or {}
	table.insert(PrefabFiles, prefab)

	STRINGS.NAMES[string.upper(prefab)] = name or "Thingamabob"
	STRINGS.RECIPE_DESC[string.upper(prefab)] = craftstring or "Thingamabob"
end

--- Registers an upgrade type for a material
--- @param upgrade (string) Name of the upgrade type
--- @param material (string) Associated material prefab
function Articore:AddUpgradeType(upgrade, material)
	if not upgrade or not material then
		print("[ERROR] AddUpgradeType: Missing upgrade or material!")
		return
	end

	upgrade = string.upper(upgrade)
	UPGRADETYPES[upgrade] = material

	AddPrefabPostInit(material, function(inst)
		if inst and inst.AddComponent then
			inst:AddComponent("upgrader")
			inst.components.upgrader.upgradetype = UPGRADETYPES[upgrade]
		end
	end)

	AddPlayerPostInit(function(player)
		if player and player.AddTag then
			player:AddTag(material .. "_upgradeuser")
		end
	end)
end

--- Registers a repair type for a material
--- @param repair (string) Name of the repair type
--- @param material (string) Associated material prefab
function Articore:AddRepairType(repair, material)
	if not repair or not material then
		print("[ERROR] AddRepairType: Missing repair or material!")
		return
	end

	repair = string.upper(repair)
	GLOBAL.MATERIALS[repair] = material

	AddPrefabPostInit(material, function(inst)
		if inst and inst.AddComponent then
			inst:AddComponent("repairer")
			inst.components.repairer.repairmaterial = GLOBAL.MATERIALS[repair]
		end
	end)
end

--- @param r (integer) Red
--- @param g (integer) Green
--- @param b (integer) Blue
--- @param a (integer) Alpha
function Articore:RGBA(r, g, b, a)
	return { r / 255, g / 255, b / 255, a }
end

function Articore:HideMenuPanel()
	AddClassPostConstruct("widgets/redux/mainmenu_motdpanel", function(self)
		if self.config.bg then
			self.config.bg:Hide()
		end

		self.old = self.OnImagesLoaded
		self.OnImagesLoaded = function(self)
			self.old(self)

			if self.config.bg then
				self.config.bg:Hide()
			end
		end
	end)

	AddClassPostConstruct(redux .. "multiplayermainscreen", function(self)
		self.banner_root:Hide()
	end)
end


-- ########## EXPORT ARTICORE ##########
GLOBAL.Articore = Articore

return Articore
