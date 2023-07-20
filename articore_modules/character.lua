
 --Adds Character with Name, gender, title, quote, map icon, speech file, survivability (slim, grim) and should it add _none prefab
function AddCharacter(character, name, gender, title, quote, skindesc, map, speech, survivability, addprefabs)
 
  AddPrefab(character)
  if addprefabs then




    AddPrefab(character.."_none")
  end

  charname = character.."_none"


  local gender = string.upper(gender)




  STRINGS.CHARACTER_NAMES[character] = name
  STRINGS.CHARACTER_TITLES[character] = title
  STRINGS.CHARACTER_QUOTES[character] = "\""..quote.."\""
  STRINGS.SKIN_DESCRIPTIONS[charname] = skindesc
  
  
  --STRINGS.CHARACTER_ABOUTME[prefab] = about

  --STRINGS.SKIN_DESCRIPTIONS[charname] = description
 
  
  STRINGS.SKIN_NAMES[charname] = name


  AddMinimapAtlas("images/map_icons/"..character..".xml")

  local prefab_speech = string.upper(character)

  STRINGS.NAMES[prefab_speech] = name
  STRINGS.CHARACTERS[prefab_speech] = require("speech_"..speech)
  STRINGS.CHARACTER_SURVIVABILITY[character] = survivability

  local skin_modes = {
      { 
          type = "ghost_skin",
          anim_bank = "ghost",
          idle_anim = "idle", 
          scale = 0.75, 
          offset = { 0, -25 } 
      },
  }


  AddModCharacter(character, gender, skin_modes)



end

--Adds info about the character
function AddAboutMe(character, text)
  STRINGS.CHARACTER_ABOUTME[character] = text
end




--Adds skin for character. Name, description, quote, is the character modded ?, is dynamic asset used?, add prefab if modded skin not used
function AddCharacterSkin(character, skin, name, description, quote, modded, dynamicskin, addprefabs)
  local _G = GLOBAL
  local PREFAB_SKINS = _G.PREFAB_SKINS
  local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
  local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

  


  local charname = modded and skin or character.."_"..skin
 
  if addprefabs then

    AddPrefab(charname)
  end
   
 

  STRINGS.SKIN_NAMES[charname] = name
  STRINGS.SKIN_DESCRIPTIONS[charname] = description
  STRINGS.SKIN_QUOTES[charname] = "\""..quote.."\""
  
  if  dynamicskin then
    AddDynamic(charname)
  else
    AddAnim(charname)
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

            TheFrontEnd:PushScreen(ThankYouPopup({{ item = charname, item_id = 0, gifttype = SkinGifts.types[charname] or "DEFAULT" }}))
        end
      end)
    end)



    prefab = "wilson" 
  end
  table.insert(PREFAB_SKINS[character], charname)
  if not SKIN_AFFINITY_INFO == nil then
    table.insert(SKIN_AFFINITY_INFO[character], charname)
  end

end

--Adds skinmode to character (name, skinmode, hasclothing true or false)
function AddSkinMode(name, mode1, hasclothing)


  if not mode1 then return end

  local skin_mode = { type = mode1, play_emotes = true }




  
  


  table.insert(GLOBAL.MODCHARACTERMODES[name], 1, skin_mode)
  if hasclothing then
    table.insert(GLOBAL.SKIN_TYPES_THAT_RECEIVE_CLOTHING, mode1)
  end
end



function AddSkinCollection(character, name)
  STRINGS.SKIN_TAG_CATEGORIES.COLLECTION[string.upper(character)] = name  
end



--Adds abillity for character name 3
function CharacterAbillity(character, first, second, third)
  STRINGS.CHARACTER_DESCRIPTIONS[character] = "*"..first.."\n*"..second.."\n*"..third

end





--Add Stats for character
function NewStats(character, health, hunger, sanity)
  
  
  TUNING[string.upper(character).."_HEALTH"] = health
  TUNING[string.upper(character).."_HUNGER"] = hunger
  TUNING[string.upper(character).."_SANITY"] = sanity

end


--Adds inventory item for character
function AddItem(character, item, number)
	prefab = string.upper(character)
	if number == nil then 
		number = 1
	end


	TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] = TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] or {} 



	for i=1,number do table.insert(TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character], item) end

end



function AddLobbyTheme(charsel)

  AddClassPostConstruct("screens/redux/lobbyscreen", function(self)
    if not charsel then return end

    local root
    local old_character
    local old_OnUpdate = self.OnUpdate
    self.OnUpdate = function(self, ...)
      old_OnUpdate(self, ...)
      root = self.panel and self.panel.character_scroll_list
      if root then -- Some error checks
        local character = root:GetCharacter()
        if character and old_character ~= character and character == charsel   then -- To prevent it from repeatively running the code too many times
            print(character.." CHARACTER")
           
                TheFrontEnd:GetSound():PlaySound(charsel.."/characters/"..charsel.."/"..charsel.."_mu", "characterselect")
        


            

        else
            if  TheFrontEnd:GetSound():PlayingSound("characterselect") then
                TheFrontEnd:GetSound():KillSound("characterselect")
            end
        end
      end
      end

      self.old_stopmusic = self.StopLobbyMusic
      self.StopLobbyMusic = function (self, ...)
        self.old_stopmusic(self, ...)
        TheFrontEnd:GetSound():KillSound("characterselect")
        
      end


  end)


end