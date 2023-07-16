if load_note == true then
	LoadedArticore()
end



AddClassPostConstruct("screens/redux/mainscreen", function(self, debugmode)
	local branch = string.upper(GLOBAL.BRANCH)
	if  not GLOBAL.CHEATS_ENABLED and show_branch == true then
		print("--------------------------------------")
		print("You are running on "..branch.." branch")
		print("--------------------------------------")
	elseif show_branch == false then
		return
	else
		
		print("--------------------------------------")
		print("You are running on "..branch.." branch with debugmode enabled")
		print("--------------------------------------")
	
	end

end)