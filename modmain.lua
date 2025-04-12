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




scheduler:ExecutePeriodic(0.1, function()
	print(IsConsole())
end)



local path = "articore/articore_modules/"

local modules =



{
	"articore",

}



--Change stuff in it
for k,v in pairs(modules) do modimport(path..""..v) end

--Code to put into the actual mod

if GLOBAL.Articore then
    AddAnim = GLOBAL.Articore.AddAnim
    AddSound = GLOBAL.Articore.AddSound
    AddDynamic = GLOBAL.Articore.AddDynamic
    AddTex = GLOBAL.Articore.AddTex
    AddPrefab = GLOBAL.Articore.AddPrefab

	AddRepairType = GLOBAL.Articore.AddRepairType
	AddUpgradeType = GLOBAL.Articore.AddUpgradeType 
	
	AddCharacter = GLOBAL.Articore.AddCharacter
	AddAboutMe = GLOBAL.Articore.AddAboutMe
    AddCharacterSkin = GLOBAL.Articore.AddCharacterSkin
    CharacterAbility = GLOBAL.Articore.CharacterAbility
    AddSkinMode = GLOBAL.Articore.AddSkinMode


    HideMenuPanel = GLOBAL.Articore.HideMenuPanel

    
end











