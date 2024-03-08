load_note = false --Shows notification of loaded API in console
show_branch = false --Shows what branch are you running on and if you have debugmode it will show it too in console


do
    local GLOBAL = GLOBAL
    local modEnv = GLOBAL.getfenv(1)
    local rawget, setmetatable = GLOBAL.rawget, GLOBAL.setmetatable
    setmetatable(modEnv, {
        __index = function(self, index)
            return rawget(GLOBAL, index)
        end
        -- lack of __newindex means it defaults to modEnv, so we don't mess up globals.
    })

    _G = GLOBAL
end




local Screen = require "widgets/screen"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
local Button = require "widgets/button"
local Video = require "widgets/video"
 
local PopupDialogScreen = require "screens/redux/popupdialog"
local RedeemDialog = require "screens/redeemdialog"
local FestivalEventScreen = require "screens/redux/festivaleventscreen"
local MovieDialog = require "screens/moviedialog"
local CreditsScreen = require "screens/creditsscreen"
local ModsScreen = require "screens/redux/modsscreen"
local OptionsScreen = require "screens/redux/optionsscreen"
local PlayerSummaryScreen = require "screens/redux/playersummaryscreen"
local QuickJoinScreen = require "screens/redux/quickjoinscreen"
local ServerListingScreen = require "screens/redux/serverlistingscreen"
local ServerCreationScreen = require "screens/redux/servercreationscreen"
 
local TEMPLATES_NEW = require "widgets/redux/templates"
local TEMPLATES = require "widgets/templates"
 
local FriendsManager = require "widgets/friendsmanager"
local OnlineStatus = require "widgets/onlinestatus"
local ThankYouPopup = require "screens/thankyoupopup"
local SkinGifts = require("skin_gifts")
local Stats = require("stats")


local KitcoonPuppet = require "widgets/kitcoonpuppet"
local KitcoonPoop = require "widgets/kitcoonpoop"
local KitcoonFood = require "widgets/kitcoonfood"
local KitcoonPouch = require "widgets/kitcoonpouch"


GetPlayer = function()
    return ThePlayer
end

GetWorld = function()
    return TheWorld
end