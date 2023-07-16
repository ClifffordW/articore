
--Set The Global Prefix
_G = GLOBAL

--modimporter all
--modimport("scripts/c-library/fn_init")

--Game Requirements
require = _G.require
unpack = _G.unpack
rawget = _G.rawget
getmetatable = _G.getmetatable
next = _G.next
ANCHOR_MIDDLE = 0
SCALEMODE_FILLSCREEN = 1
SCALEMODE_PROPORTIONAL = 2
SPECIAL_EVENTS = _G.SPECIAL_EVENTS

AllRecipes = _G.AllRecipes
Ingredient = _G.Ingredient
RECIPETABS = _G.RECIPETABS
Recipe = _G.Recipe
TECH = _G.TECH

os = _G.os

----------------------------------------------------------
require("consolecommands")
require("debugkeys")
require("debugcommands")
require("os")
----------------------------------------------------------

MAINSCREEN_TOOL_LIST = _G.MAINSCREEN_TOOL_LIST
MAINSCREEN_TORSO_LIST = _G.MAINSCREEN_TORSO_LIST
MAINSCREEN_HAT_LIST = _G.MAINSCREEN_HAT_LIST

RESOLUTION_X = _G.RESOLUTION_X
RESOLUTION_Y = _G.RESOLUTION_Y
resolvefilepath = _G.resolvefilepath
softresolvefilepath = _G.softresolvefilepath
FRONTEND_TITLE_COLOUR = _G.FRONTEND_TITLE_COLOUR
title_x = 20
title_y = 10

ANCHOR_MIDDLE = 0
ANCHOR_BOTTOM = 0
ANCHOR_LEFT = 1
ANCHOR_RIGHT = 2
ANCHOR_TOP = 1
SCALEMODE_FILLSCREEN = 1
SCALEMODE_PROPORTIONAL = 2
BACK_BUTTON_Y = _G.BACK_BUTTON_Y
BACK_BUTTON_X = _G.BACK_BUTTON_X
GOLD = _G.GOLD
MOVE_DOWN = _G.MOVE_DOWN
MOVE_UP = _G.MOVE_UP
MOVE_RIGHT = _G.MOVE_RIGHT
MOVE_LEFT = _G.MOVE_LEFT
FRONTEND_PORTAL_COLOUR = _G.FRONTEND_PORTAL_COLOUR

BUTTONFONT = _G.BUTTONFONT
TALKINGFONT = _G.TALKINGFONT
NEWFONT = _G.NEWFONT
NEWFONT_OUTLINE = _G.NEWFONT_OUTLINE

MAX_CHAT_INPUT_LENGTH = _G.MAX_CHAT_INPUT_LENGTH


----------------------------------------------------------

--Mod Stuff
KnownModIndex = _G.KnownModIndex


----------------------------------------------------------

--Ingame Stuff

BRANCH = _G.BRANCH
CHEATS_ENABLED = _G.CHEATS_ENABLED

UPGRADETYPES = _G.UPGRADETYPES
CHARACTER_INGREDIENT = _G.CHARACTER_INGREDIENT
TheFrontEnd = _G.TheFrontEnd
TheWorld = _G.TheWorld
TheSim = _G.TheSim
TheNet = _G.TheNet
TheInput = _G.TheInput
SetPause = _G.SetPause
GetClosestInstWithTag = _G.GetClosestInstWithTag
SetDebugEntity = _G.SetDebugEntity
TUNING = _G.TUNING

TheMixer = _G.TheMixer
SpawnPrefab = _G.SpawnPrefab
SetSharedLootTable = _G.SetSharedLootTable
Vector3 = _G.Vector3
SEASONS = _G.SEASONS
FUELTYPE = _G.FUELTYPE
ACTIONS = _G.ACTIONS
GetTime = _G.GetTime
AllPlayers = _G.AllPlayers
STRINGS = _G.STRINGS
TheInputProxy = _G.TheInputProxy
FADE_IN = _G.FADE_IN
WORLD_FESTIVAL_EVENT = _G.WORLD_FESTIVAL_EVENT
FESTIVAL_EVENTS = _G.FESTIVAL_EVENTS
SCREEN_FADE_TIME = _G.SCREEN_FADE_TIME
TheInventory = _G.TheInventory
FE_MUSIC = GLOBAL.FE_MUSIC
DST_CHARACTERLIST = _G.DST_CHARACTERLIST
FRONTEND_CHARACTER_FAR_COLOUR = _G.FRONTEND_CHARACTER_FAR_COLOUR
FRONTEND_SMOKE_COLOUR = _G.FRONTEND_SMOKE_COLOUR
FRAMES = _G.FRAMES

CONTROL_CANCEL = _G. CONTROL_CANCEL
CONTROL_MENU_MISC_2 = _G.CONTROL_MENU_MISC_2
CONTROL_PREVVALUE = _G.CONTROL_PREVVALUE
CONTROL_PAUSE = _G.CONTROL_PAUSE
CONTROL_ACCEPT = _G.CONTROL_ACCEPT
CONTROL_NEXTVALUE = _G.CONTROL_NEXTVALUE

BGCOLOURS = _G.BGCOLOURS

Settings = _G.Settings
DoRestart = _G.DoRestart
Profile = _G.Profile

SCROLL_REPEAT_TIME = .05
MOUSE_SCROLL_REPEAT_TIME = 0

TITLEFONT = _G.TITLEFONT

rcol = RESOLUTION_X / 2 - 200
lcol = -RESOLUTION_X / 2 + 280
title_x = 20
title_y = 10
subtitle_offset_x = 20
subtitle_offset_y = -260

bottom_offset = 60

menuX = lcol + 10
menuY = -215

titleX = lcol - 90
titleY = 195

GetSkinName = _G.GetSkinName

State = _G.State
TimeEvent = _G.TimeEvent
EventHandler = _G.EventHandler
TheCamera = _G.TheCamera
GetString = _G.GetString

----------------------------------------------------------






--Components stuff
FUELTYPE = _G.FUELTYPE

BGCOLOURS =
{
    RED = {255 / 255, 89 / 255, 46 / 255},
    PURPLE = {184 / 255, 87 / 255, 198 / 255},
    YELLOW = {255 / 255, 196 / 255, 45 / 255},
    TEAL = {80 / 255, 193 / 255, 204 / 255},
    
    MUSTARD = {255 / 255, 127 / 255, 159 / 255}, -- THIS ONE
    GREEN = {87 / 255, 164 / 255, 86 / 255}, -- THIS ONE
}

allscreens = {"options", "main", "mods", "serverlisting", "servercreation", "morgue", "collection", "mysterybox", "playersummary", "purchasepackscreen", "wardrobescreen"}
allnomain = {"options", "mods", "serverlisting", "servercreation", "morgue", "collection", "mysterybox", "playersummary"}

options = {"options"}
main = {"main"}
mods = {"mods"}
serverlisting = {"serverlisting"}
servercreation = {"servercreation"}
morgue = {"morgue"}
collection = {"collection"}
mysterybox = {"mysterybox"}
playersummary = {"playersummary"}

muliplayerscreen = "screens/redux/multiplayermainscreen"
mainscreen = "screens/redux/mainscreen"

redux = "screens/redux/"
retro = "screens/"

----------------------------------------------------------





--Require Stuff
require "mods"
require "playerdeaths"
require "saveindex"
require "map/extents"
require "perfutil"
require "maputil"
require "constants"
require "knownerrors"

require "usercommands"
require "builtinusercommands"
require "emotes"
require "os"

Screen = require "widgets/screen"
AnimButton = require "widgets/animbutton"
ImageButton = require "widgets/imagebutton"
Menu = require "widgets/menu"
Text = require "widgets/text"
Image = require "widgets/image"
UIAnim = require "widgets/uianim"
Widget = require "widgets/widget"
Button = require "widgets/button"
Video = require "widgets/video"

PopupDialogScreen = require "screens/redux/popupdialog"
RedeemDialog = require "screens/redeemdialog"
FestivalEventScreen = require "screens/redux/festivaleventscreen"
MovieDialog = require "screens/moviedialog"
CreditsScreen = require "screens/creditsscreen"
ModsScreen = require "screens/redux/modsscreen"
OptionsScreen = require "screens/redux/optionsscreen"
PlayerSummaryScreen = require "screens/redux/playersummaryscreen"
QuickJoinScreen = require "screens/redux/quickjoinscreen"
ServerListingScreen = require "screens/redux/serverlistingscreen"
ServerCreationScreen = require "screens/redux/servercreationscreen"

--TEMPLATES = require "widgets/redux/templates"
TEMPLATES = require "widgets/redux/templates"
TEMPLATES_OLD = require "widgets/templates"

FriendsManager = require "widgets/friendsmanager"
OnlineStatus = require "widgets/onlinestatus"
ThankYouPopup = require "screens/thankyoupopup"
SkinGifts = require("skin_gifts")
Stats = require("stats")



----------------------------------------------------------













--Functions

function MakeMainMenuButton(text, onclick, tooltip)
    local btn = Button()
end

function IsSpecialEventActive(event)
    return WORLD_SPECIAL_EVENT == event
end

function IsAnyFestivalEventActive()
    return WORLD_FESTIVAL_EVENT ~= FESTIVAL_EVENTS.NONE
end

function IsFestivalEventActive(event)
    return WORLD_FESTIVAL_EVENT == event
end

function JapaneseOnPS4()
    if PLATFORM == "PS4" and APP_REGION == "SCEJ" then
        return true
    end
    return false
end

function ShowLoading()
    if global_loading_widget then
        global_loading_widget:SetEnabled(true)
    end
end

AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
    local function MakeMainMenuButton(text, onclick, tooltip_text, tooltip_widget)
        local btn = TEMPLATES.MenuButton(text, onclick, tooltip_text, tooltip_widget)
        return btn
    end
end)

function IsConsole()
    return (PLATFORM == "PS4") or (PLATFORM == "XBONE")
end
