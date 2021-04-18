function AddItemSkin(prefab, name, description, rarity, collection)


	STRINGS.SKIN_NAMES[prefab] = name
	STRINGS.SKIN_DESCRIPTIONS[prefab] = description

	STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(collection)] = collection.." Collection"
	STRINGS.UI.RARITY[rarity] = rarity

end







