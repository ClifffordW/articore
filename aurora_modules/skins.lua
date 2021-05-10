function AddItemSkin(prefab, name, description, rarity, collection)
	local _G = GLOBAL
	local PREFAB_SKINS = _G.PREFAB_SKINS
	local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
	local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

	STRINGS.SKIN_NAMES[prefab] = name
	STRINGS.SKIN_DESCRIPTIONS[prefab] = description

	STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(collection)] = collection.." Collection"
	STRINGS.UI.RARITY[rarity] = rarity

	if not PREFAB_SKINS[prefab] then
	    PREFAB_SKINS[prefab] = {}
	    SKIN_AFFINITY_INFO[prefab] = {}
  	end



  	table.insert(PREFAB_SKINS[prefab], charname)
  	table.insert(SKIN_AFFINITY_INFO[prefab], charname)
end