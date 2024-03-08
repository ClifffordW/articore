if load_note == true then
	LoadedArticore()
end

local cwfunc =require("articore/articore_modules/required")

--print(CurrentScreen(true, "mainscreen"))



AddClassPostConstruct("screens/redux/mainscreen", function(self, debugmode)
	local branch = string.upper(GLOBAL.BRANCH)
	if not GLOBAL.CHEATS_ENABLED and show_branch == true then
		print("--------------------------------------")
		print("You are running on " .. branch .. " branch")
		print("--------------------------------------")
	elseif show_branch == false then
		return
	else
		print("--------------------------------------")
		print("You are running on " .. branch .. " branch with debugmode enabled")
		print("--------------------------------------")
	end

	



end)

AddClassPostConstruct(cwfunc.CurrentScreen(true, "mainscreen"), function(self, ...)
	self.inst:DoTaskInTime(0, function()
		print("POGGERS")
	end)
end)


scheduler:ExecuteInTime(0.5, function()
	local KUID = hash(TheNet:GetUserID())
	if KUID == 2477691595 and TheFrontEnd then
			print("YES")
			TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/XP_bar_fill_unlock", 0.35)
		
	end

end)