local lang_lookups = {
    modinfo_core = {
        en = {
            name = "Articore Test",
            new = "󰀏 What's New",
            credits = "󰀭 Credits",
            modinfo_v = "󰀩 Modinfo Version",
            mod_v = "󰀩 Mod Version",
            modinfo_module = "Articore",
            desc = "Adds Whisky, an airhead spider that loves caves.",
            changes = 
			[[
			
		󰀈 Added sideway talking sprites to Whisky.
		
		󰀈 Added quotes for new content and Wildcard.
		
		󰀈 Fixed a few config related crashes.
			]],
        },
        zh = {
			name = "威士忌",
			new = "󰀏 最新消息",
			credits = "󰀭 制作人员",
			modinfo_v = "󰀩 Modinfo 版本",
			mod_v = "󰀩 Mod 版本",
			modinfo_module = "Articore",
			desc = "新增了威士忌，一个喜欢洞穴的迟钝蜘蛛。",
			changes = [[
		󰀈 威士忌现在有了新的声音。
			]],
		},
    },
    modinfo_config = {
        en = {
            name = "Whisky",
            new = "󰀏 What's New",
            credits = "󰀭 Credits",
            modinfo_v = "󰀩 Modinfo Version",
            mod_v = "󰀩 Mod Version",
            modinfo_module = "Articore",
            desc = "Adds Whisky",
            changes = "󰀈 Whisky has new voice now.",
        },
        zh = {
            name = "Whisky",
            new = "󰀏 日志",
            credits = "󰀭 致谢",
            modinfo_v = "󰀩 Mod信息版本",
            mod_v = "󰀔 Mod版本",
            modinfo_module = "钴",
            desc = "Adds Whisky",
            changes = "󰀈 威士忌现在有了新的声音。",
        },
    },
    versiontypes = {
        en = {
            final = "[Final]",
            beta = "[Beta]",
            disc = "[Discontinued]",
            redux = "[Redux]",
            ov = "[Overhaul]",
            ea = "[Early Access]",
            dev = "[Dev Build]",
        },
        zh = {
            final = "[终版]",
            beta = "[测试版]",
            disc = "[已停产]",
            redux = "[重制版]",
            ov = "[大修]",
            ea = "[早期体验]",
            dev = "[开发版本]",
        },
    },
}

local lookup = lang_lookups.modinfo_core[locale] or lang_lookups.modinfo_core.en
local lookupconf = lang_lookups.modinfo_config[locale] or lang_lookups.modinfo_config.en

versiontype = ""
name = lookup.name
author = "mentos"

version = "4.0"
config = false


Language = "en"



contributors = "Cliffford W., Pumkin"
write_contributors = false
credits_only = true

main_icon = "modicon"

priority = 5


api_version = 10


dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false



all_clients_require_mod = false
client_only_mod = true
server_only_mod = false
server_filter_tags = { "character", "whisky" }





--[[ mod_dependencies = 
{
	{
		workshop = "workshop-2812783478",
		["[API] Modded Skins"] = true
	}
} ]]

local scales = {}
for i = 1, 20 do
    scales[i] = { description = "x" .. i / 10, data = i / 10 }
end

local pos = {}
pos[1] = { description = "Default", data = 0 }
for i = 2, 15 do
    pos[i] = { description = "+" .. i .. "0", data = i * 10 }
end

local opt_Empty = { { description = "", data = 0 } }
local function Title(title, hover)
    return {
        name = title,
        hover = hover,
        options = opt_Empty,
        default = 0,
    }
end

local SEPARATOR = Title("")
modinfo_ver = lookup.modinfo_module



configuration_options = {
	
		


	Title("Stats 󰀓"),
	{
	name = "WHISKY_HEALTH",
	label = "Whisky's Max HP",
	hover = "How much health Whisky has by default.",
	options =
	{
		{description = "10", data = 10, hover="Hard Mode 󰀀"},
		{description = "30", data = 30} ,
		{description = "80", data = 80, hover="Default 󰀗"},
		{description = "100", data = 100} ,
		{description = "150", data = 150} ,
		{description = "200", data = 200, hover="Ez Mode 󰀍"},
	},
	default = 80
},
{
	name = "WHISKY_SANITY",
	label = "Whisky's Max Sanity",
	hover = "How much sanity Whisky has by default.",
	options =
	{
		{description = "30", data = 30, hover="Hard Mode 󰀀"},
		{description = "70", data = 70} ,
		{description = "100", data = 100, hover="Default 󰀗"},
		{description = "150", data = 150} ,
		{description = "200", data = 200, hover="Ez Mode 󰀍"},
	},
	default = 100
},
{
	name = "WHISKY_HUNGER",
	label = "Whisky's Max Hunger",
	hover = "How much hunger Whisky has by default.",
	options =
	{
		{description = "50", data = 50, hover="Hard Mode 󰀀"},
		{description = "90", data = 90} ,
		{description = "120", data = 120, hover="Default 󰀗"},
		{description = "150", data = 150} ,
		{description = "200", data = 200, hover="Ez Mode 󰀍"}, 
	},
	default = 120
},


{
	name = "WHISKY_DAMAGE",
	label = "Whisky's Damage Multiplier",
	hover = "How hard Whisky hits.",
	options =
	{
		{description = "0.6", data = 0.6},
		{description = "0.7", data = 0.7},
		{description = "0.8", data = 0.8, hover="Default 󰀗"},
		{description = "0.9", data = 0.9},
		{description = "1", data = 1},
		{description = "1.2", data = 1.2},
		{description = "1.5", data = 1.5}
		
	},
	default = 0.8
},



{
	name = "WHISKY_MOVE_SPEED",
	label = "Whisky's Move Speed",
	hover = "How fast Whisky runs.",
	options =
	{
		{description = "1", data = 1},
		{description = "1.1", data = 1.1, hover="Default 󰀗"},
		{description = "1.2", data = 1.2},
		{description = "1.3", data = 1.3},
		{description = "1.4", data = 1.4},
		{description = "1.5", data = 1.5}
		
	},
	default = 1.1
},



Title("Crafting & Abillities 󰀔"),

{
	name = "SILKYARN_COST",
	label = "Silk Yarn Crafting Cost",
	hover = "The amount of silk required to craft yarns.",
	options =
	{
		{description = "2", data = 2},
		{description = "4", data = 4},
		{description = "6", data = 6},
		{description = "8", data = 8, hover="Default 󰀗"},
		{description = "10", data = 10},
		{description = "12", data = 12},
		{description = "14", data = 14}
	},
	default = 8
},


{
	name = "WHISKY_CRAFTINGITEMS",
	label = "Whisky's Unique Craftables",
	hover = "Disable or enable Whisky's custom items.",
	options =
	{
		{description = "Enabled", data = 2, hover="Default 󰀗"},
		{description = "Disabled", data = 1}
	},
	default = 2
},

{
	name = "WHISKY_BACKPAIN",
	label = "Chronic Back Pain",
	hover = "No body slot items",
	options =
	{
		{description = "Enabled", data = 1, hover="Default 󰀗"},
		{description = "Disabled", data = 0}
	},
	default = 1
},

{
	name = "WHISKY_BACKPAIN_EXCEPTIONS",
	label = "Back Pain Exceptions",
	hover = "Allow Whisky to wear certain body items.",
	options =
	{
		{description = "None", data = 0, hover="Default 󰀗"},
		{description = "Allow Backpacks", data = 1},
		{description = "Allow Armor", data = 2},
		{description = "Allow Clothing", data = 3}
	},
	default = 0
},

{
	name = "WHISKY_LEAPOPTION",
	label = "Whisky's Leap Ability",
	hover = "Disable or enable Whisky's leap.",
	options =
	{
		{description = "Enabled", data = 2, hover="Default 󰀗"},
		{description = "Disabled", data = 1}
	},
	default = 2
},

{
	name = "WHISKY_LEAP_DIST",
	label = "Max Leap Distance",
	hover = "How far Whisky can leap.",
	options =
	{
		{description = "5", data = 5},
		{description = "10", data = 10, hover="Default 󰀗"},
		{description = "15", data = 15},
		{description = "20", data = 20}
		
	},
	default = 10
},


{
	name = "WHISKY_MONSTROSITY",
	label = "Whisky's Monsterness",
	hover = "Enable or disable other creatures seeing Whisky as a monster.",
	options =
	{
		{description = "Enabled", data = 2, hover="Default 󰀗"},
		{description = "Disabled", data = 1}
	},
	default = 2
},





Title("Misc 󰀏"),
{
	name = "WHISKY_HEAVY_ITEM_DROP_DELAY",
	label = "Heavy Item Drop Delay",
	hover = "Whisky's delay before dropping heavy items i.e marble pieces, sculptures.",
	options =
	{
		{description = "3", data = 3, hover="Default 󰀗"},
		{description = "6", data = 6},
		{description = "9", data = 9},
		{description = "12", data = 12},
		{description = "15", data = 15}
		
	},
	default = 3
},
{
	name = "WHISKPACK_OPTION",
	label = "Silk Pouch",
	hover = "Whisky's unique backpack, disabled by default.",
	options =
	{
		{description = "Disabled", data = 1, hover="Default 󰀗"},
		{description = "Enabled", data = 2}			
	},
	default = 1
},
{
	name = "WHISKYWHIP_OPTION",
	label = "Whipsky",
	hover = "Whisky's unique whip, disabled by default.",
	options =
	{
		{description = "Disabled", data = 1, hover="Default 󰀗"},
		{description = "Enabled", data = 2}			
	},
	default = 1
},
--[[ 	{
	name = "whip_repair",
	label = "Repairable Whip",
	hover = "Option to repair whip ",
	options =
	{
		{description = "Enabled", data = 1},
		{description = "Disabled", data = 0} ,

	},
	default = 0
}, ]]
{
	name = "MUSHYSHAVE_REWARD",
	label = "Webbed Mushtree Silk Reward",
	hover = "The amount of silk Whisky gets back when shaving webbed mushtrees",
	options =
	{
		{description = "1", data = 1, hover="Default 󰀗"},
		{description = "2", data = 2},
		{description = "3", data = 3},
		{description = "4", data = 4}
	},
	default = 1
},






Title("󰀩 Mod Version"..":".." "..version),

}



	





icon_atlas = main_icon .. ".xml"
icon = main_icon .. ".tex"

lookup_v = lang_lookups.versiontypes[locale] or lang_lookups.versiontypes.en
versiontype = lookup_v[versiontype] or ""

if versiontype ~= "" then
    name = name .. "\n" .. versiontype
end

folder_name = folder_name or "workshop-"
if not folder_name:find("workshop-") then
	name = name .. " - GitHub Ver."
end

old_author = author
if contributors ~= "" and contributors ~= nil and write_contributors then
    author = author .. " and " .. contributors
end

desc = lookup.desc
changelog = lookup.new .. "\n" .. lookup.changes
credits = lookup.credits .. ": " .. contributors
mark2 = lookup.modinfo_v .. ": " .. modinfo_ver

if write_contributors or credits_only and contributors ~= "" then
    descfill = desc .. "\n" .. credits .. "\n\n" .. lookup.mod_v .. ": " .. version .. "\n\n" .. changelog .. "\n\n"
else
    descfill = desc .. "\n 󰀝 " .. lookup.mod_v .. ": " .. version .. "\n\n" .. changelog .. "\n\n\n\n"
end

description = descfill
description = description
