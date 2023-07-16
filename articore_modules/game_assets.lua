function AddSound(sound, soundpkg)
  if not Assets then
    Assets = {}
  end

  if not soundpkg then 
    soundpkg = sound 
  end

  table.insert(Assets, Asset("SOUND", "sound/"..sound..".fsb"))
  table.insert(Assets, Asset("SOUNDPACKAGE", "sound/"..soundpkg..".fev"))
  print("Imported "..sound.." and "..soundpkg..".")

end









function AddAnim(anim)
  if not Assets then
    Assets = {}
  end


  table.insert(Assets, Asset("ANIM", "anim/"..anim..".zip"))

  print("Imported "..anim..".zip")

end







function AddDynamic(anim, dynamic)
  if not Assets then
    Assets = {}
  end

  if not dynamic then
    dynamic = anim
  end



  table.insert(Assets, Asset("DYNAMIC_ANIM", "anim/dynamic/"..anim..".zip"))
  table.insert(Assets, Asset("PKGREF", "anim/dynamic/"..dynamic..".dyn"))


  print("Imported "..anim..".zip and "..dynamic..".dyn")

end









function AddTex(tex, atlas, inv)
  if not Assets then
    Assets = {}
  end


  if not atlas then
    atlas = tex
  end

  if not inv then
    table.insert(Assets, Asset("IMAGE", "images/"..tex..".tex"))
    table.insert(Assets, Asset("ATLAS", "images/"..atlas..".xml"))
  else
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/"..tex..".tex"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..atlas..".xml"))
  end


  print("Imported "..tex..".tex and "..atlas..".xml")

end



function SetBranch(branch, debugmode)



  local branches = 
  {
    dev = "dev",
    release = "release",
    stager = "stager",
  }


  if branch == branches[branch] then

    GLOBAL.BRANCH = branch
  else
    print("No branch called "..branch.." has been found")


  end
  


  if debugmode == true then
    GLOBAL.CHEATS_ENABLED = true
    print("Devmode and Debug tools enabled")
  end


end