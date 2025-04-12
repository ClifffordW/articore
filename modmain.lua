do
	local GLOBAL = GLOBAL
	local modEnv = GLOBAL.getfenv(1)
	local rawget, setmetatable = GLOBAL.rawget, GLOBAL.setmetatable
	setmetatable(modEnv, {
		__index = function(self, index)
			return rawget(GLOBAL, index)
		end,
		-- lack of __newindex means it defaults to modEnv, so we don't mess up globals.
	})

	_G = GLOBAL
end







local path = "articore/articore_modules/"

local modules =



{
	"articore",

}



--Change stuff in it
for k,v in pairs(modules) do modimport(path..""..v) end



function Articore:DeployFallbacks(env, modname)
    if GLOBAL.Articore then
        -- Ensure modname is a string
        modname = tostring(modname) 

        local prefix = string.gsub(modname.."_", "^%l", string.upper) -- Dynamic prefix
        for k, v in pairs(GLOBAL.Articore) do
            if not string.find(k, "DeployFallbacks") then
			
				env[prefix .. k] = v
				print("Assigned:", prefix .. k, "->", tostring(v)) -- Debug output
			end
        end
        print("FALLBACKS DEPLOYED for mod:", modname)
    end
end


local reference = false

if reference then
	Menurift_AddAnim = GLOBAL.Articore.AddAnim
	Menurift_AddSound = GLOBAL.Articore.AddSound
	Menurift_AddDynamic = GLOBAL.Articore.AddDynamic
	Menurift_AddTex = GLOBAL.Articore.AddTex
	Menurift_AddPrefab = GLOBAL.Articore.AddPrefab
	Menurift_AddRepairType = GLOBAL.Articore.AddRepairType
	Menurift_AddUpgradeType = GLOBAL.Articore.AddUpgradeType
	Menurift_AddCharacter = GLOBAL.Articore.AddCharacter
	Menurift_AddAboutMe = GLOBAL.Articore.AddAboutMe
	Menurift_AddCharacterSkin = GLOBAL.Articore.AddCharacterSkin
	Menurift_CharacterAbility = GLOBAL.Articore.CharacterAbility
	Menurift_AddSkinMode = GLOBAL.Articore.AddSkinMode
	Menurift_HideMenuPanel = GLOBAL.Articore.HideMenuPanel
	Menurift_RGBA = GLOBAL.Articore.RGBA

	Menurift_UIAnim_Talk = GLOBAL.Articore.UIAnim_Talk


	Menurift_GetCurrentAnimation = GLOBAL.Articore.GetCurrentAnimation



end










