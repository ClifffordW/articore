
--Working
function AddCharacter(character, name, gender, title, quote, map, speech, addprefabs)
  if addprefabs then
    AddPrefab(character)



    AddPrefab(character.."_none")
  end

  charname = character.."_none"


  local gender = string.upper(gender)




  STRINGS.CHARACTER_NAMES[character] = name
  STRINGS.CHARACTER_TITLES[character] = title
  STRINGS.CHARACTER_QUOTES[character] = "\""..quote.."\""
  
  --STRINGS.CHARACTER_ABOUTME[prefab] = about

  --STRINGS.SKIN_DESCRIPTIONS[charname] = description
 
  STRINGS.SKIN_NAMES[charname] = name


  AddMinimapAtlas("images/map_icons/"..character..".xml")

  local prefab_speech = string.upper(character)

  STRINGS.CHARACTERS[prefab_speech] = require("speech_"..speech)


  AddModCharacter(character, gender)



end


function AddAboutMe(character, text)
  STRINGS.CHARACTER_ABOUTME[character] = text
end





function AddCharacterSkin(character, skin, name, description, test, none_skin)
  local _G = GLOBAL
  local PREFAB_SKINS = _G.PREFAB_SKINS
  local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
  local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

  


  local charname = character.."_"..skin
  AddPrefab(charname)
 

  STRINGS.SKIN_NAMES[charname] = name
  STRINGS.SKIN_DESCRIPTIONS[charname] = description
  
  if not none_skin then
    AddDynamic(charname)
  end

  if not PREFAB_SKINS[character] then
    PREFAB_SKINS[character] = {}
    SKIN_AFFINITY_INFO[character] = {}
  end


  if test then 
    AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
      self.inst:DoTaskInTime(FRAMES, function()

        local online = TheNet:IsOnlineMode() and not TheFrontEnd:GetIsOfflineMode()


        local ThankYouPopup = require "screens/thankyoupopup"
        local SkinGifts = require("skin_gifts")
        
        if online then

            TheFrontEnd:PushScreen(ThankYouPopup({{ item = string.lower(charname), item_id = 0, gifttype = SkinGifts.types[charname] or "DEFAULT" }}))
        end
      end)
    end)



    prefab = "wilson" 
  end
  table.insert(PREFAB_SKINS[character], charname)
  table.insert(SKIN_AFFINITY_INFO[character], charname)


end


function AddSkinCollection(character, name)
  STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(character)] = name  
end



--Working
function CharacterAbillity(character, first, second, third)
  STRINGS.CHARACTER_DESCRIPTIONS[character] = "*"..first.."\n*"..second.."\n*"..third

end






function NewStats(character, health, hunger, sanity)
  
  
  TUNING[string.upper(character).."_HEALTH"] = health
  TUNING[string.upper(character).."_HUNGER"] = hunger
  TUNING[string.upper(character).."_SANITY"] = sanity

end



function AddItem(character, item, number)
	prefab = string.upper(character)
	if number == nil then 
		number = 1
	end


	TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] = TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] or {} 



	for i=1,number do table.insert(TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character], item) end

end