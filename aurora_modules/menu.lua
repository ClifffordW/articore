
function AddBG(screen, image, transparency)
  AddTex(image)
  AddClassPostConstruct("screens/redux/"..screen, function(self)
    if self.bg then self.bg:Kill() end


    if self.fixed_root then
      self.bg = self.fixed_root:AddChild(Image("images/"..image..".xml", image..".tex"))
      self.bg:MoveToBack()
    else
      self.bg = self.root:AddChild(Image("images/"..image..".xml", image..".tex"))
      self.bg:MoveToBack()

    end

    self.bg:SetTint(1,1,1, transparency)


  end)

end






function AddLogo(screen, image)
    AddTex(image)
  
    if screen == ("multiplayermainscreen" or "mainscreen") then

      AddClassPostConstruct("screens/redux/"..screen, function(self)
        if self.title then self.title:Kill() end


        if self.fixed_root and screen == "mainscreen" then
          self.title = self.fixed_root:AddChild(Image("images/"..image..".xml", image..".tex"))
          self.title:MoveToBack()


          self.title:SetScale(.65)
          self.title:SetPosition(title_x, title_y-5)
          self.title:SetTint(unpack(FRONTEND_TITLE_COLOUR))


        elseif screen == "multiplayermainscreen" then
          self.title = self.fixed_root:AddChild(Image("images/lavaarena_frontend.xml", "title.tex"))
          self.title:SetScale(.6)
          self.title:SetPosition( -RESOLUTION_X/2 + 160, 220)
          self.title:MoveToFront()
        end
      end)
    end
end



function SetMusic(music, number)
  if type(music) == "string" then
    GLOBAL.FE_MUSIC = music
  else
    GLOBAL.FE_MUSIC = music[math.random(1,number)]
  end
end



function ChangeMenuSel(image, transparency)
  AddTex(image)

  AddClassPostConstruct("widgets/redux/mainmenu_motdpanel", function(self)
    if self.config.bg then self.config.bg:Kill() end



    self.old = self.OnImagesLoaded
    self.OnImagesLoaded = function(self)
      self.old(self)


      if self.config.bg then self.config.bg:Kill() end
    end
  
  end)


  AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
    if self.bg then self.bg:Kill() end

    self.bg = self.fixed_root:AddChild(Image("images/"..image..".xml", image..".tex"))
    self.bg:SetScale(.669)
    self.bg:SetPosition(0, -160)
    self.bg:SetClickable(false)
    self.bg:MoveToBack()

    self.bg:SetTint(1,1,1, transparency)

    
    self.bg:MoveToFront()
    self.info_panel:MoveToFront()
    self.menu_root:MoveToFront()
    self.submenu:MoveToFront()


  end)
end






function HideMenuPanel()
 
  AddClassPostConstruct("widgets/redux/mainmenu_motdpanel", function(self)
    if self.config.bg then self.config.bg:Kill() end



    self.old = self.OnImagesLoaded
    self.OnImagesLoaded = function(self)
      self.old(self)


      if self.config.bg then self.config.bg:Kill() end
    end
  
  end)


  AddClassPostConstruct(redux.."multiplayermainscreen", function(self)
    



    self.inst:DoPeriodicTask(.1, function()
      self.info_panel:SetPosition(-5000,-5000)
    end)
    

    self.banner_root:Kill()
  end)
end










function VideoAdd(video)
  
  AddClassPostConstruct("screens/redux/mainscreen", function(self)

    self.oldinit = self.OnUpdate
    self.OnUpdate = function(self)
      GLOBAL.TheFrontEnd:GetSound():SetVolume("FEMusic",0)
      GLOBAL.TheFrontEnd:GetSound():KillSound("FEMusic")
      self.oldinit(self)

    end


    self:Hide()

    function OnMovieDone()

        
        
        GLOBAL.TheFrontEnd:Fade(FADE_IN, 1)
        self:Show()
        Mult = require("screens/redux/multiplayermainscreen")
        GLOBAL.TheFrontEnd:FadeToScreen(self, function() return Mult() end, nil)
        self.inst:DoTaskInTime(.5, function() GLOBAL.TheFrontEnd:GetSound():PlaySound(FE_MUSIC, "FEMusic") end)
    end


    self.presents_image:Kill()
    self.legalese_image:Kill()

    self.play_button:Hide()
    self.exit_button:Hide()

    self.updatename:Kill()

    self.bg:Kill()
    self.title:Kill()

    self.play_button:Disable()




    local vid = resolvefilepath("movies/"..video..".ogg")

    GLOBAL.TheFrontEnd:FadeToScreen( self, function() self:OnLoginButton(true)    return   MovieDialog(vid, OnMovieDone) end, nil )


  end)

end


--[[if intro == true then 
  if not Assets then
    Assets =
    {
      Asset("PKGREF", "movies/redstone.ogg"),
    }

  else
    table.insert(Assets, Asset("PKGREF", "movies/redstone.ogg"))
  end
end--]]








function ImageSetup(which)
  which:SetVRegPoint(ANCHOR_MIDDLE)
  which:SetHRegPoint(ANCHOR_MIDDLE)
  which:SetVAnchor(ANCHOR_MIDDLE)
  which:SetHAnchor(ANCHOR_MIDDLE)
  which:SetScaleMode(SCALEMODE_FILLSCREEN)
  which:MoveToBack()
end


function BackgroundImage(which)
  for k, v in pairs(which) do 
    AddClassPostConstruct("screens/redux/"..v.."screen", function(self)
      self.bg.bgplate.image:SetTexture(GLOBAL.resolvefilepath("images/ui.xml"), "bg_plain.tex")
      ImageSetup(self.bg.bgplate.image)
      self.bg.bgplate.image:SetTint(BGCOLOURS.GREEN[1],BGCOLOURS.GREEN[2],BGCOLOURS.GREEN[3], 1)
    end)
  end
end





function SkipLogging()
  
  AddClassPostConstruct("screens/modwarningscreen", function(self)
    self.root:Kill()
  end)


  AddClassPostConstruct("screens/redux/mainscreen", function(self, instant_log)

    self:OnLoginButton(true)
    Mult = require("screens/redux/multiplayermainscreen")
    GLOBAL.TheFrontEnd:FadeToScreen(self, function() return Mult() end, nil)
  end)
end







function CurioMenuMusic()
  AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self, prev_screen, profile, offline, session_data)
    function self:OnPlayerSummaryButton()

      if TheFrontEnd:GetIsOfflineMode() or not TheNet:IsOnlineMode() then
        TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.MAINSCREEN.OFFLINE, STRINGS.UI.MAINSCREEN.ITEMCOLLECTION_DISABLE, 
          {
            {text=STRINGS.UI.FESTIVALEVENTSCREEN.OFFLINE_POPUP_LOGIN, cb = function()
              GLOBAL.SimReset()
              end},
            {text=STRINGS.UI.FESTIVALEVENTSCREEN.OFFLINE_POPUP_BACK, cb=function() TheFrontEnd:PopScreen() end },
          }))
      else
          
          TheFrontEnd:GetSound():SetParameter("FEMusic", "fade", 1)
          self:_FadeToScreen(PlayerSummaryScreen, {GLOBAL.Profile})
      end
    end
  end)
  AddClassPostConstruct("screens/redux/playersummaryscreen", function(self)
    function self:StartMusic()

    end
  end)


end





function HorizontalMenu(position, bg)
  AddTex("menu_bar")
  AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self, profile)
    local function MakeMainMenuButton(text, onclick, tooltip_text, tooltip_widget)
      local btn = TEMPLATES.MenuButton(text, onclick, tooltip_text, tooltip_widget)
      return btn
    end


    local browse_button2  = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.BROWSE,    function() self:OnBrowseServersButton() end, STRINGS.UI.MAINSCREEN.TOOLTIP_BROWSE, self.tooltip)
    local host_button2    = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.CREATE,    function() self:OnCreateServerButton() end,  STRINGS.UI.MAINSCREEN.TOOLTIP_HOST, self.tooltip)
    local summary_button2 = MakeMainMenuButton(STRINGS.UI.PLAYERSUMMARYSCREEN.TITLE, function() self:OnPlayerSummaryButton() end, STRINGS.UI.MAINSCREEN.TOOLTIP_PLAYERSUMMARY, self.tooltip)
    local options_button2 = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.OPTIONS,   function() self:Settings() end,              STRINGS.UI.MAINSCREEN.TOOLTIP_OPTIONS, self.tooltip)
    local quit_button2    = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.QUIT,      function() self:Quit() end,                  STRINGS.UI.MAINSCREEN.TOOLTIP_QUIT, self.tooltip)






    local new_items = {
      {widget = quit_button2},
      {widget = options_button2},
      {widget = summary_button2},
      {widget = host_button2},
      {widget = browse_button2},
    }


    if IsConsole() then
      local shop_button = MakeMainMenuButton(STRINGS.UI.PLAYERSUMMARYSCREEN.PURCHASE, function() self:GotoShop() end, STRINGS.UI.PLAYERSUMMARYSCREEN.TOOLTIP_PURCHASE, self.tooltip)
      table.insert(new_items, 2, {widget = shop_button})
    end

    if GLOBAL.MODS_ENABLED then
      local mods_button = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.MODS, function() self:OnModsButton() end, STRINGS.UI.MAINSCREEN.TOOLTIP_MODS, self.tooltip)
      table.insert(new_items, 2, {widget = mods_button})
    end
    

    if SHOW_QUICKJOIN and not GLOBAL.TheFrontEnd:GetIsOfflineMode() and not IsAnyFestivalEventActive() then
      local quickjoin_button = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.QUICKJOIN, function() self:OnQuickJoinServersButton() end, STRINGS.UI.MAINSCREEN.TOOLTIP_QUICKJOIN, self.tooltip)
      table.insert(new_items, {widget = quickjoin_button})
    end
    
    if IsAnyFestivalEventActive() then
      local festival_button = MakeMainMenuButton(STRINGS.UI.MAINSCREEN.FESTIVALEVENT[string.upper(WORLD_FESTIVAL_EVENT)], function() self:OnFestivalEventButton() end, STRINGS.UI.MAINSCREEN.TOOLTIP_FESTIVALEVENT[string.upper(WORLD_FESTIVAL_EVENT)], self.tooltip)
      table.insert(new_items, {widget = festival_button})
    end

    self.menu:Kill()
    self.menu2 = self.menu_root:AddChild(TEMPLATES.StandardMenu(new_items, -280, 0, 0, true))
    self.menu2:SetScale(0.55)


    self.menu_root:SetScale(1.5)
    
    self.menu_bar = self.menu_root:AddChild(Image("images/"..bg..".xml", bg..".tex"))
    self.menu_bar:SetTint(1,1,1, .5)
    
    





    if position == "top" then
      self.menu_bar:SetPosition(-450,-120,0)
      self.menu_root:SetPosition(1320,520)
      self.submenu:SetScale(0.50)
      self.submenu:SetPosition(-600,280)
    elseif position == "bottom" then
      self.menu_bar:SetPosition(-450,-160,0)
      self.submenu:SetScale(0.50)
      self.submenu:SetPosition(-600,-280)
      self.menu_root:SetPosition(1320,-130)
    end

    self.menu2:MoveToFront()
    self.menu_root:MoveToFront()
    self.submenu:MoveToFront()



  end)
end



AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
  local function MakeMainMenuButton(text, onclick, tooltip_text, tooltip_widget)
      local btn = TEMPLATES.MenuButton(text, onclick, tooltip_text, tooltip_widget)
      return btn
  end





  function AnimBG(anim3, character)
    animbg = self.fixed_root:AddChild(UIAnim())
    animbg:GetAnimState():SetBuild(anim3)
    animbg:GetAnimState():SetBank(anim3)
    animbg:GetAnimState():PlayAnimation("loop", true)
    animbg:SetScale(1.35)
    animbg:SetPosition(0, 0)
    animbg:MoveToBack()
    animbg:GetAnimState():SetMultColour(255, 255, 255, .2)

    animbg:GetAnimState():HideSymbol("fade")
    animbg:GetAnimState():HideSymbol("flicker")
    animbg:GetAnimState():HideSymbol("lavaarena_player_teleport")
    animbg:GetAnimState():HideSymbol(character.."0")
    animbg:GetAnimState():HideSymbol(character.."1")
    animbg:GetAnimState():HideSymbol(character.."2")
    animbg:GetAnimState():HideSymbol(character.."3")
    animbg:GetAnimState():HideSymbol(character.."4")
    animbg:GetAnimState():HideSymbol(character.."5")
    animbg:GetAnimState():HideSymbol(character.."6")
    animbg:GetAnimState():HideSymbol(character.."7")
    animbg:GetAnimState():HideSymbol(character.."8")
    animbg:GetAnimState():HideSymbol(character.."9")
    animbg:GetAnimState():HideSymbol(character.."10")
    animbg:GetAnimState():HideSymbol(character.."11")
    animbg:GetAnimState():HideSymbol(character.."12")
    
    animbg:GetAnimState():HideSymbol("glint10")
    animbg:GetAnimState():HideSymbol("glint11")
    animbg:GetAnimState():HideSymbol("glint12")
    animbg:GetAnimState():HideSymbol("glint13")
    animbg:GetAnimState():HideSymbol("glint14")
    animbg:GetAnimState():HideSymbol("glint15")
    animbg:GetAnimState():HideSymbol("glint16")
    animbg:GetAnimState():HideSymbol("glint17")
    animbg:GetAnimState():HideSymbol("glint18")

  end
        




end)