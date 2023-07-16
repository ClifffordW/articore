
local path = "articore/articore_modules/"

local modules =
{
    "articore_init",
    "required",
    "preinit",
    
    "game_assets",
    
    "menu",
    "prefab",
    "custom",
    "skins",
    "character",
    
    
    "modutil",

    "postinit",
}



--Change stuff in it
for k,v in pairs(modules) do modimport(path..""..v) end




--[[You can Enable mods by creating table of them for example

    

    mods = 
    {
        "1883649334",
        "1457039579",
    },

    or you can subscribe to them by using this table 

    mods_download = 
    {
        "1883649334",
        "1457039579",
    },


    be sure to put it before modimport("articore/articore")

]]







--custom.lua is for your can create anything within it


--[[Prefab Section

AddUpgradeType("omega", "gears") Creates upgrade OMEGA what requires gears to be upgraded

RecipeDesc("gears", "Gotta move that gear up") Adds description to a recipe gears

Describe("wilson","gears","Hey max move your gears") Adds quote to item gears said by wilson
	NOTE: You can use "wilson" instead of generic, "wigfrid" instead of wathgrithr and "maxwell" instead of waxwell

NewRecipe("meat", "survival", "science", 3, "meat") Creates recipe meat in tab survival requiring tech science 3
atlas is the recipe texture. List of techs below
crafting tabs are here too


Name("meat", "Guess what. Meat") Adds name to a prefab



AddMapIcon("gabe newell", "gabe") Adds map icon to prefab gabe newell (Yes this is not a joke it actually does it)


AddInvTex("stick", "sticky_stick") Adds inventory image to prefab stick (Not Tested)

AddPrefab("stick") Adds prefab stick
]]








--[[Asset Section

NOTE: if you leave the second like this AddSound("dontstarve") it will turn into
AddSound("donstarve", "dontstarve") in case you have same name of package and sound
it applies to all of these in the section

AddSound("dontstarve", "music") Adds sound music and sound package dontstarve to assets

AddAnim("gaben") Adds anim gaben to assets


AddDynamic("gaben", "gabeol") Adds dynamic animation gaben and dynamic file gabeol


AddTex("hitman") Adds texture and atlas hitman to assets



SetBranch("dev") Sets and enables Devmode which enables debug mode

valid branches are: release, staging and dev



]]





--[[Menu Section



AddBG("mainscreen", "tesla", .5) Adds background tesla to mainscreen with transparency set to .5

AddLogo("mainscreen", "dbd") Adds logo dbd to mainscreen

SetMusic("gaben") Changes menu music to gaben
if you have table of tracks created then use SetMusic("gaben", 4) where 4 is number of tracks in table


ChangeMenuSel("dbd", .5) Changes the motd background to dbd with transparency of 0.5


--5.0.5
SkipLogging() Skips mainscreen

HideMenuPanel() Hides the default motd panel with background

HorizontalMenu("top", "texture")  Sets the menu to horizontal (top or bottom) and the second option is naem of the bakground behind the menu

CurioMenuMusic() Sets curio cabinet music to default menu music



]]





--[[Character Section


AddCharacter("weslyn", "Weslyn", "female", "A quiet lady", "...", "weslyn", "weslyn") prefab, character name, gender, title, quote, map icon, speechfile


CharacterAbillity("aste", "Is quiet", "has balloons", "is nice") Adds abillities to description


AddCharacterSkin("aste", "triumphant", "Asteish", "Is Dark") Creates skin triumphant Asteish for char aste with description "Is Dark"

AddAboutMe(prefab, text) 

NewStats("weslyn", 150, 120, 200)

Stats of Weslyn get set to 
Health 150
Hunger 120
Sanity 200


AddItem("weslyn", "nightsword", 1)

Adds One Dark Sword to starting inventory of character called Weslyn


]]








--[[Recipe Tabs

    TOOLS =         { str = "TOOLS",        sort = 0,   icon = "tab_tool.tex" },
    LIGHT =         { str = "LIGHT",        sort = 1,   icon = "tab_light.tex" },
    SURVIVAL =      { str = "SURVIVAL",     sort = 2,   icon = "tab_trap.tex" },
    FARM =          { str = "FARM",         sort = 3,   icon = "tab_farm.tex" },
    SCIENCE =       { str = "SCIENCE",      sort = 4,   icon = "tab_science.tex" },
    WAR =           { str = "WAR",          sort = 5,   icon = "tab_fight.tex" },
    TOWN =          { str = "TOWN",         sort = 6,   icon = "tab_build.tex" },
    SEAFARING =     { str = "SEAFARING",    sort = 7,   icon = "tab_seafaring.tex" },
    REFINE =        { str = "REFINE",       sort = 8,   icon = "tab_refine.tex" },
    MAGIC =         { str = "MAGIC",        sort = 9,   icon = "tab_arcane.tex" },
    DRESS =         { str = "DRESS",        sort = 10,  icon = "tab_dress.tex" },


    ANCIENT =       { str = "ANCIENT",      sort = 100,  icon = "tab_crafting_table.tex",    crafting_station = true },
    CELESTIAL =     { str = "CELESTIAL",    sort = 100,  icon = "tab_celestial.tex",         crafting_station = true },
    MOON_ALTAR =    { str = "MOON_ALTAR",   sort = 100,  icon = "tab_moonaltar.tex",         crafting_station = true },
    CARTOGRAPHY =   { str = "CARTOGRAPHY",  sort = 100,  icon = "tab_cartography.tex",       crafting_station = true },
    SCULPTING =     { str = "SCULPTING",    sort = 100,  icon = "tab_sculpt.tex",            crafting_station = true },
    ORPHANAGE =     { str = "ORPHANAGE",    sort = 100,  icon = "tab_orphanage.tex",         crafting_station = true },
    PERDOFFERING =  { str = "PERDOFFERING", sort = 100,  icon = "tab_perd_offering.tex",     crafting_station = true },
    MADSCIENCE =    { str = "MADSCIENCE",   sort = 100,  icon = "tab_madscience_lab.tex",	 crafting_station = true, manufacturing_station = true },
    FOODPROCESSING = { str = "FOODPROCESSING", sort = 100, icon = "tab_foodprocessing.tex",  crafting_station = true },
]]














--[[

	Tech List

    SCIENCE_ONE = { SCIENCE = 1 },
    SCIENCE_TWO = { SCIENCE = 2 },
    SCIENCE_THREE = { SCIENCE = 3 },

    MAGIC_TWO = { MAGIC = 2 },
    MAGIC_THREE = { MAGIC = 3 },

    ANCIENT_TWO = { ANCIENT = 2 },
    ANCIENT_THREE = { ANCIENT = 3 },
    ANCIENT_FOUR = { ANCIENT = 4 },

    CELESTIAL_ONE = { CELESTIAL = 1 },

	MOON_ALTAR_TWO = { MOON_ALTAR = 2 },

    SHADOW_TWO = { SHADOW = 3 },

    CARTOGRAPHY_TWO = { CARTOGRAPHY = 2 },

    SEAFARING_ONE = { SEAFARING = 1 },
    SEAFARING_TWO = { SEAFARING = 2 },

    SCULPTING_ONE = { SCULPTING = 1 },
    SCULPTING_TWO = { SCULPTING = 2 },

]]













