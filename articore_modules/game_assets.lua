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




--Experimental
function AddScrapbookItem(prefab, category, subcat, description, is_burnable, bank, build, atlas)

  if not MODDED_CRAFTING[string.upper(prefab)] then print("MISSING RECIPE") return end

  local categories = {
    creature = true,
    item = true,
    food = true,
    giant = true,
    thing = true,
    POI = true,
  }

  category = categories[category] and category or "thing"
  if subcat == nil or subcat == "" then
    subcat = nil
  end


  local scrapbook_prefabs = require("scrapbook_prefabs")
  local scrapbookdata = require("screens/redux/scrapbookdata")
  

  STRINGS.SCRAPBOOK.SPECIALINFO[string.upper(prefab)] = description or "PLACEHOLDER"
  local scrapbookitems = {
    [prefab] = 
    {
      subcat = subcat, 
      fueltype = is_burnable and "BURNABLE" or nil, 
      fuelvalue = is_burnable or nil, 
      burnable = is_burnable and true or false, 
      
      
      build = build, bank = bank, anim = "idle", 
      
      
      
      specialinfo = string.upper(prefab),


      deps = {unpack(MODDED_CRAFTING[string.upper(prefab).."_SCRAPBOOK"])}

      

    },

  }
  


    
  for k, v in pairs(scrapbookitems) do
    if v.subcat and STRINGS.SCRAPBOOK.SUBCATS[string.upper(v.subcat)] == nil then
      STRINGS.SCRAPBOOK.SUBCATS[string.upper(v.subcat)] = v.subcat -- TEMP fix of missing subcat until end of the beta lmao
    end
    v.name = v.name or k
    v.prefab = k
    v.tex = v.tex or k..".tex"
    v.type = v.type or "item"
    v.deps = v.deps or {}
    v.notes = v.notes or {}
    
    scrapbook_prefabs[k] = true
    scrapbookdata[k] = v
    
  end
  print("Succesfully added "..prefab.." to scrapbook")

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