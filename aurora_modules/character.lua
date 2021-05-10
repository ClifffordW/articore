
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

function AddCharacterSkin(prefab, skin, name, description, test, none_skin)
  local _G = GLOBAL
  local PREFAB_SKINS = _G.PREFAB_SKINS
  local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
  local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

  


  local charname = prefab.."_"..skin
  AddPrefab(charname)
 

  STRINGS.SKIN_NAMES[charname] = name
  STRINGS.SKIN_DESCRIPTIONS[charname] = description
  
  if not none_skin then
    AddDynamic(charname)
  end

  if not PREFAB_SKINS[prefab] then
    PREFAB_SKINS[prefab] = {}
    SKIN_AFFINITY_INFO[prefab] = {}
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
  table.insert(PREFAB_SKINS[prefab], charname)
  table.insert(SKIN_AFFINITY_INFO[prefab], charname)


end


function AddSkinCollection(prefab, name)
  STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(prefab)] = name  
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