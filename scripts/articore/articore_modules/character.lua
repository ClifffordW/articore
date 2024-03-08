--Adds Character with Name, gender, title, quote, map icon, speech file, survivability (slim, grim) and should it add _none prefab
function AddCharacter(character, name, gender, title, quote, skindesc, map, speech, survivability, addprefabs)
  AddPrefab(character)
  if addprefabs then
    AddPrefab(character .. "_none")
  end

  charname = character .. "_none"


  local gender = string.upper(gender)




  STRINGS.CHARACTER_NAMES[character] = name
  STRINGS.CHARACTER_TITLES[character] = title
  STRINGS.CHARACTER_QUOTES[character] = "\"" .. quote .. "\""
  STRINGS.SKIN_DESCRIPTIONS[charname] = skindesc


  --STRINGS.CHARACTER_ABOUTME[prefab] = about

  --STRINGS.SKIN_DESCRIPTIONS[charname] = description


  STRINGS.SKIN_NAMES[charname] = name


  AddMinimapAtlas("images/map_icons/" .. character .. ".xml")

  local prefab_speech = string.upper(character)

  STRINGS.NAMES[prefab_speech] = name
  STRINGS.CHARACTERS[prefab_speech] = require("speech_" .. speech)
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

function AddCharLobbyMusic(music, prefab)
  AddClassPostConstruct("screens/redux/lobbyscreen", function(self, ...)
    TheFrontEnd = GLOBAL.TheFrontEnd
    if not TheFrontEnd then return end
    if not music then return end

    local root
    local old_character
    local old_OnUpdate = self.OnUpdate
    self.OnUpdate = function(self, ...)
      old_OnUpdate(self, ...)
      root = self.panel and self.panel.character_scroll_list
      if root then                                                                 -- Some error checks
        local character = root:GetCharacter()
        if character and old_character ~= character and character == prefab then   -- To prevent it from repeatively running the code too many times
          if not TheFrontEnd:GetSound():PlayingSound("characterselect") then
            TheFrontEnd:GetSound():PlaySound(music, "characterselect")
          end
          TheFrontEnd:GetSound():SetVolume("characterselect", 1)
        else
          if TheFrontEnd:GetSound():PlayingSound("characterselect") then
            TheFrontEnd:GetSound():SetVolume("characterselect", 0)
          end
        end
      end
    end

    self.old_stopmusic = self.StopLobbyMusic
    self.StopLobbyMusic = function(self, ...)
      self.old_stopmusic(self, ...)
      TheFrontEnd:GetSound():KillSound("characterselect")
    end
  end)
end

--Adds skin for character. Name, description, quote, is the character modded ?, is dynamic asset used?, add prefab if modded skin not used
function AddCharacterSkin(character, skin, name, description, quote, modded, dynamicskin, addprefabs)
  local _G = GLOBAL
  local PREFAB_SKINS = _G.PREFAB_SKINS
  local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
  local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")




  local charname = modded and skin or character .. "_" .. skin

  if addprefabs then
    AddPrefab(charname)
  end



  STRINGS.SKIN_NAMES[charname] = name
  STRINGS.SKIN_DESCRIPTIONS[charname] = description
  STRINGS.SKIN_QUOTES[charname] = "\"" .. quote .. "\""

  if dynamicskin then
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
          TheFrontEnd:PushScreen(ThankYouPopup({ { item = charname, item_id = 0, gifttype = SkinGifts.types[charname] or "DEFAULT" } }))
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

function AnimatedBigPortrait(character, skin)
  if skin then
    character = character .. "_" .. skin
  end

  AddAnim(character .. "_bigportrait")



  AddClassPostConstruct("screens/redux/wardrobescreen", function(self, ...)
    local herocharacter = self.currentcharacter
    local skin = self.preview_skins.base



    self.heroportrait_anim = self.preview_root:AddChild(UIAnim())

    self.heroportrait_anim:GetAnimState():SetBank("bigportrait")
    self.heroportrait_anim:SetScale(0.50)
    self.heroportrait_anim:SetPosition(0, 220)
    self.heroportrait_anim:GetAnimState():PlayAnimation("idle", true)
    self.heroportrait_anim:MoveToFront()
    self.heroportrait_anim:Hide()

    local animated_skins =
    {
      whisky_none = true,
    }




    function self:_SetShowPortrait(show)
      local herocharacter = self.currentcharacter
      local skin = self.preview_skins.base

      if show then
        self.heroportrait:Show()
        self.heroportrait_anim:Show()

        self.heroportrait:Show()

        self.puppet_root:Hide()


        self.showing_portrait = true
      else
        self.heroportrait_anim:Hide()

        self.heroportrait:Hide()


        self.puppet_root:Show()
        self.showing_portrait = false
      end
    end

    function self:_SetPortrait()
      local herocharacter = self.currentcharacter
      local skin = self.preview_skins.base

      local found_name = _G.SetHeroNameTexture_Gold(self.heroname, herocharacter)
      if found_name then
        self.heroname:Show()
      else
        self.heroname:Hide()
      end

      if skin then
        _G.SetSkinnedOvalPortraitTexture(self.heroportrait, herocharacter, skin)

        self.heroportrait_anim:GetAnimState():SetBuild(character .. "_bigportrait")
      else
        _G.SetOvalPortraitTexture(self.heroportrait, herocharacter)
      end

      self.characterquote:SetMultilineTruncatedString(
        STRINGS.SKIN_QUOTES[skin] or STRINGS.CHARACTER_QUOTES[herocharacter] or "",
        3,    --maxlines
        300,  --maxwidth,
        55,   --maxcharsperline,
        true, --ellipses,
        false --shrink_to_fit
      )
    end
  end)
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
  STRINGS.CHARACTER_DESCRIPTIONS[character] = "*" .. first .. "\n*" .. second .. "\n*" .. third
end

--Adds character talking font file has to be talkingfont_yourcharacter.zip in fonts folder
function AddCharFont(prefab)
  local font = "TALKINGFONT_" .. prefab:upper()
  _G.global(font) --Fix provided by CarlZalph ty
  _G[font] = "talkingfont_" .. prefab


  local charfont = _G[font]

  if not charfont then
    return
  end

  AddSimPostInit(function()
    TheSim:UnloadFont(charfont)
    TheSim:UnloadPrefabs({ "char_fonts" })

    local Assets = {
      Asset("FONT", _G.resolvefilepath("fonts/talkingfont_" .. prefab .. ".zip")),
    }
    local FontsPrefab = _G.Prefab("char_fonts", function() return _G.CreateEntity() end, Assets)
    _G.RegisterPrefabs(FontsPrefab)
    TheSim:LoadPrefabs({ "char_fonts" })
    TheSim:LoadFont(_G.resolvefilepath("fonts/talkingfont_" .. prefab .. ".zip"), charfont)
    TheSim:SetupFontFallbacks(charfont, _G.DEFAULT_FALLBACK_TABLE_OUTLINE)
  end)
end

function AddCharSkilltree(prefab)
  table.insert(Assets, Asset("IMAGE", "images/" .. prefab .. "_skilltree.tex"))
  table.insert(Assets, Asset("ATLAS", "images/" .. prefab .. "_skilltree.xml"))

  table.insert(Assets, Asset("IMAGE", "images/skilltree_" .. prefab .. "_icons.tex"))
  table.insert(Assets, Asset("ATLAS", "images/skilltree_" .. prefab .. "_icons.xml"))

  RegisterSkilltreeBGForCharacter("images/" .. prefab .. "_skilltree.xml", prefab)


  for i = 1, 12 do
    RegisterSkilltreeIconsAtlas("images/skilltree_" .. prefab .. "_icons.xml", "skill_intimidating_" .. i .. ".tex")
    RegisterSkilltreeIconsAtlas("images/skilltree_" .. prefab .. "_icons.xml", "skill_unintimidating_" .. i .. ".tex")
  end

  local SkillTreeDefs = require("prefabs/skilltree_defs")

  local CreateSkillTree = function()
    print("Creating a skilltree for " .. prefab)
    local BuildSkillsData = require("prefabs/skilltree_" .. prefab) -- Load in the skilltree

    if BuildSkillsData then
      local data = BuildSkillsData(SkillTreeDefs.FN)

      if data then
        SkillTreeDefs.CreateSkillTreeFor(prefab, data.SKILLS)
        SkillTreeDefs.SKILLTREE_ORDERS[prefab] = data.ORDERS
        print("Created " .. prefab .. " skilltree")
      end
    end
  end
  CreateSkillTree();
end

function AddScorebBadge(prefab, state1, state2, state3)
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

--Add Stats for character
function NewStats(character, health, hunger, sanity)
  TUNING[string.upper(character) .. "_HEALTH"] = health
  TUNING[string.upper(character) .. "_HUNGER"] = hunger
  TUNING[string.upper(character) .. "_SANITY"] = sanity
end

--Adds inventory item for character
function AddItem(character, item, number)
  prefab = string.upper(character)
  if number == nil then
    number = 1
  end


  TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] = TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character] or {}



  for i = 1, number do table.insert(TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[character], item) end
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
      if root then                                                                  -- Some error checks
        local character = root:GetCharacter()
        if character and old_character ~= character and character == charsel then   -- To prevent it from repeatively running the code too many times
          if not TheFrontEnd:GetSound():PlayingSound("characterselect") then
            TheFrontEnd:GetSound():PlaySound(charsel .. "/characters/" .. charsel .. "/" .. charsel .. "_mu",
              "characterselect")
            TheFrontEnd:GetSound():SetParameter("characterselect", "fade", 0.4109)
          end
          TheFrontEnd:GetSound():SetParameter("characterselect", "fade", 1)
        else
          if TheFrontEnd:GetSound():PlayingSound("characterselect") then
            TheFrontEnd:GetSound():SetParameter("characterselect", "fade", 0.38)
          end
        end
      end
    end

    self.old_stopmusic = self.StopLobbyMusic
    self.StopLobbyMusic = function(self, ...)
      self.old_stopmusic(self, ...)
      TheFrontEnd:GetSound():KillSound("characterselect")
    end
  end)
end
