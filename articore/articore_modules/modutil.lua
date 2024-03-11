function AddMod()
    
    if mods_download then
        for k, v in pairs(mods_download) do TheSim:SubscribeToMod("workshop-"..v)
    end
        
end
    


function _ServerCode(ispristine)

    
        if ispristine then
            inst.entity:SetPristine()
        end
       
        if not TheWorld.ismastersim then
            return inst
        end

end



function EnableMod()
    if mods then

        for k, v in pairs(mods) do KnownModIndex:Enable("workshop-"..v) end end
    end
end
    
    

function Wishes()
    if WORLD_SPECIAL_EVENT == ("WINTERS_FEAST" or "HALLOWED_NIGHTS") then  
        AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
        
            local EMOTES =
            {
                    
                HALLOWED_NIGHTS =
                {
                    "󰀗",
                    "󰀆",
                    "󰀊",
                    "󰀉",
                },


                WINTERS_FEAST =
                {
                    "󰀦",
                    "󰀢",
                    "󰀍",
                    "󰀤",
                },


            }




               

            local random_emote = EMOTES[WORLD_SPECIAL_EVENT][math.random(1,4)]
            
            
            
            local WISHES =
            {
                DESCRIPTION =
                {
                    
                    WINTERS_FEAST = "Klei wishes you merry christmas and so do i and the characters lost in the constant",
                    HALLOWED_NIGHTS = "Happy halloween to you from Klei and everyone you find in the constant",
                    
                },
                
                TITLE =
                {
                    WINTERS_FEAST = "Merry Christmas"..random_emote,
                    HALLOWED_NIGHTS = "Happy Halloween " ..random_emote,
                },
                
            }


                
                
            self.inst:DoTaskInTime(.50, function()
                
                GLOBAL.TheFrontEnd:PushScreen(
                PopupDialogScreen(WISHES.TITLE[WORLD_SPECIAL_EVENT], WISHES.DESCRIPTION[WORLD_SPECIAL_EVENT],
                {
                    {
                        text = "Thanks for the wishes",
                        cb = function()
                            GLOBAL.TheFrontEnd:PopScreen()
                            
                        end
                    },
                    
                }))
                        
                end)
            
                
                
        end)
    end
                    
end
                
              
function Warning(name, warning_msg)
    AddClassPostConstruct("screens/redux/mainscreen", function(self)
        GLOBAL.TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/Together_HUD/collectionscreen/mysterybox/LP", "notif")
        GLOBAL.TheFrontEnd:GetSound():SetVolume("FEMusic", 0.02)
        self.inst:DoTaskInTime(.50, function()
            GLOBAL.TheFrontEnd:PushScreen(
            PopupDialogScreen(name, warning_msg,
            {
                {
                    text = "Okay",
                    cb = function()
                        GLOBAL.TheFrontEnd:PopScreen()
                        GLOBAL.TheFrontEnd:GetSound():SetVolume("FEMusic", 1) -- popup
                        GLOBAL.TheFrontEnd:GetSound():KillSound("notif")
                        
                    end
                },
                
   
                    
            }))
                
        end)
    end)
end



function RequiredMod(mod, RequiredMod)
                    
    require "util"
    TheFrontEnd = GLOBAL.TheFrontEnd
    TheSim = GLOBAL.TheSim
    RequiredMod = KnownModIndex:GetModActualName(RequiredMod)
    

    MODREQUIRED =
    {
        DEFAULT = "Please make sure to enable the "..KnownModIndex:GetModFancyName("workshop-"..mod) .. " to make the main mod work properly. Enable button will only work if the mod is installed",
        APRIL = "A Peter a day keeps the skins awa- wait what. Just click on the right button",
    }

    
    local date = os.date("%b %d")
    
    if date == "April 01" then
        MODREQUIRED.DEFAULT = MODREQUIRED.APRIL
    end
    
    local notif_sounds =
    
    {
        "dontstarve/quagmire/HUD/new_recipe",
        "dontstarve/common/lava_arena/player_joined",
        
    }
                    


                            
    if not RequiredMod then
        
        AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
                


            function Info()
            
                TheFrontEnd:GetSound():PlaySound(notif_sounds[math.random(1, #notif_sounds)])
                TheFrontEnd:PushScreen(
                    PopupDialogScreen("Automatic Download", "A required workshop-"..mod.." mod will be automatically downloaded",
                    {
                        {
                            text = "Okay 󰀩",
                            cb = function()
                                TheFrontEnd:PopScreen() -- popup
                                TheFrontEnd:GetSound():SetVolume("FEMusic", 1) -- popup
                                TheFrontEnd:GetSound():KillSound("notif")
                                
                            end
                        },
                        
                    }))
                        
            end

            
            function AutoDownload()
                
                self.inst:DoTaskInTime(.50, function()
                    TheSim:SubscribeToMod("workshop-"..mod)
                end)
                
            end
                

            local IsOffline = TheFrontEnd:GetIsOfflineMode()
            if not IsOffline then 
                self.inst:DoTaskInTime(.50, function()
                    TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/Together_HUD/collectionscreen/mysterybox/intro")
                    TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/Together_HUD/collectionscreen/mysterybox/LP", "notif")
                    TheFrontEnd:GetSound():SetVolume("FEMusic", 0.02)

                    TheFrontEnd:GetSound():PlaySound(notif_sounds[math.random(1, #notif_sounds)])
                    TheFrontEnd:PushScreen(
                    PopupDialogScreen("Download mod?", "A required workshop-"..mod.." mod was found missing. Do you want it to be downloaded automatically?",
                    {
                        {
                            text = "Okay 󰀃",
                            cb = function()
                                TheFrontEnd:PopScreen() -- popup
                                AutoDownload()
                                self.inst:DoTaskInTime(.5, Info() )
                            end
                        },
                        
                        {
                            text = "No 󰀕",
                            cb = function()
                                TheFrontEnd:PopScreen() -- popup
                                
                                TheFrontEnd:GetSound():SetVolume("FEMusic", 1) -- popup
                                TheFrontEnd:GetSound():KillSound("notif")
                                
                            end
                        },


                        {
                            text = "Mod Page",
                            cb = function()

                                GLOBAL.VisitURL("https://steamcommunity.com/sharedfiles/filedetails/?id="..mod)
                            end
                        },



                        
                    }))
                end)

            end
        end)
    end
end
                



function GetMod(name, modname)
    local name = KnownModIndex:GetModActualName(modname)
    
end

                                       