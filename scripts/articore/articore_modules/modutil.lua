function AddMod()
    
    if mods_download then
        for k, v in pairs(mods_download) do TheSim:SubscribeToMod("workshop-"..v)
    end
        
end
    






function EnableMod()
    if mods then

        for k, v in pairs(mods) do KnownModIndex:Enable("workshop-"..v) end end
    end
end
    
  

_G.GetCurrentAnimation = function(input)
    if _G.IsConsole() then print("This does not work on consoles!") return end
    return string.match(input.entity:GetDebugString(), "anim: ([^ ]+) ")
end

          
              


                                       