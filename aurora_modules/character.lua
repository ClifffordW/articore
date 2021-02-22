
--Working
function AddCharacter(prefab, name, gender, title,quote, map, speech)
  AddPrefab(prefab)



  AddPrefab(prefab.."_none")

  charname = prefab.."_none"


  local gender = string.upper(gender)




  STRINGS.CHARACTER_NAMES[prefab] = name
  STRINGS.CHARACTER_TITLES[prefab] = title
  STRINGS.CHARACTER_QUOTES[prefab] = "\""..quote.."\""
  
  --STRINGS.CHARACTER_ABOUTME[prefab] = about

  --STRINGS.SKIN_DESCRIPTIONS[charname] = description
 
  STRINGS.SKIN_NAMES[charname] = name


  AddMinimapAtlas("images/map_icons/"..prefab..".xml")

  local prefab_speech = string.upper(prefab)

  STRINGS.CHARACTERS[prefab_speech] = require("speech_"..speech)


  AddModCharacter(prefab, gender)



end

function AddCharacterSkin(prefab, skin, name, description)

  AddPrefab(skin)
  

  charname = prefab.."_"..skin


  STRINGS.SKIN_NAMES[charname] = name
  STRINGS.SKIN_DESCRIPTIONS[charname] = description
  


end



--Working
function CharacterAbillity(prefab, first, second, third)
  STRINGS.CHARACTER_DESCRIPTIONS[prefab] = "*"..first.."\n*"..second.."\n*"..third

end






function NewStats(prefab, health, hunger, sanity)
  
  
  TUNING[string.upper(prefab).."_HEALTH"] = health
  TUNING[string.upper(prefab).."_HUNGER"] = hunger
  TUNING[string.upper(prefab).."_SANITY"] = sanity

end



function AddItem(prefab, item, number)
	prefab = string.upper(prefab)
	if number == nil then 
		number = 1
	end


	TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[prefab] = TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[prefab] or {} 



	for i=1,number do table.insert(TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[prefab], item) end

end