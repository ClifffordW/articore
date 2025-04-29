local lang_lookups = {
    modinfo_core = {
        en = {
            name = "[API] Articore (Server)",
            new = "󰀏 What's New",
            credits = "󰀭 Credits",
            modinfo_v = "󰀩 Modinfo Version",
            mod_v = "󰀩 Mod Version",
            modinfo_module = "Articore",
            desc = "Just API..",
            changes = "󰀈 Release",
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

versiontype = ""
name = lookup.name
author = ""
version = "1.0"
config = false
Language = "en"
contributors = "Cliffford W."
write_contributors = false
credits_only = true
main_icon = "articore"
priority = 2147483647
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
all_clients_require_mod = true
client_only_mod = false
server_only_mod = false
server_filter_tags = { "help", "api" }

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






	





icon_atlas = main_icon .. ".xml"
icon = main_icon .. ".tex"

lookup_v = lang_lookups.versiontypes[locale] or lang_lookups.versiontypes.en
versiontype = lookup_v[versiontype] or ""

if versiontype ~= "" then
    name = name .. "\n" .. versiontype
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
