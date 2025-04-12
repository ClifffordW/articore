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
function Articore.AddCharacter(
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
	AddPrefab(character)
	if addprefabs then
		AddPrefab(character .. "_none")
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
function Articore.CharacterAbility(character, first, second, third)
	STRINGS.CHARACTER_DESCRIPTIONS[character] = "*" .. first .. "\n*" .. second .. "\n*" .. third
end



--- @param character (string) Character name
--- @param text (string) About me text
function Articore.AddAboutMe(character, text)
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
function Articore.AddCharacterSkin(character, skin, name, description, quote, modded, dynamicskin, addprefabs)
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

--- Defines a new skin mode for a character
--- @param name (string) Character name
--- @param mode1 (string) Skin mode identifier
--- @param hasclothing (boolean) Does this skin mode support clothing?
function Articore.AddSkinMode(name, mode1, hasclothing)
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
function Articore.AddAnim(anim, subfolder)
	Assets = Assets or {}
	local path = subfolder and ("anim/" .. subfolder .. "/") or "anim/"
	table.insert(Assets, Asset("ANIM", path .. anim .. ".zip"))
	print("Imported animation: " .. path .. anim .. ".zip")
end

--- Adds a sound asset with subfolder support
--- @param sound (string) Name of the sound file (without extension)
--- @param soundpkg (string|nil) Sound package name (optional, defaults to sound name)
--- @param subfolder (string|nil) Subfolder path (optional)
function Articore.AddSound(sound, soundpkg, subfolder)
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
function Articore.AddDynamic(anim, dynamic, subfolder)
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
function Articore.AddTex(tex, atlas, inv, subfolder)
	Assets = Assets or {}
	atlas = atlas or tex
	local basePath = inv and "images/inventoryimages/" or "images/"
	local path = subfolder and (basePath .. subfolder .. "/") or basePath

	table.insert(Assets, Asset("PKGREF", path .. tex .. ".tex"))
	table.insert(Assets, Asset("DYNAMIC_ATLAS", path .. atlas .. ".xml"))
	print("Imported texture: " .. path .. tex .. ".tex and " .. atlas .. ".xml")
end

-- ########## WORLD ENTITIES ##########
--- Adds a prefab asset
--- @param name (string) Name of the prefab to add
function Articore.AddPrefab(name)
	PrefabFiles = PrefabFiles or {}
	table.insert(PrefabFiles, name)
end

--- Registers an upgrade type for a material
--- @param upgrade (string) Name of the upgrade type
--- @param material (string) Associated material prefab
function Articore.AddUpgradeType(upgrade, material)
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
function Articore.AddRepairType(repair, material)
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


function Articore.HideMenuPanel()
	
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
