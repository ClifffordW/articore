--5.0.2

function AddUpgradeType(upgrade, material)
  if upgrade then upgrade = string.upper(upgrade) end
 
  local upgrade_type = UPGRADETYPES
  upgrade_type[upgrade] = material



  AddPrefabPostInit(material, function(inst)
    inst:AddComponent("upgrader")
    inst.components.upgrader.upgradetype = upgrade_type[upgrade]


  end)

  AddPlayerPostInit(function(player)

    player:AddTag(material.."_upgradeuser")

  end)


end


function AddRepairType(repair, material)
  if repair then repair = string.upper(repair) end
 
  local repair_type = GLOBAL.MATERIALS
  repair_type[repair] = material



  AddPrefabPostInit(material, function(inst)
    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = repair_type[repair]



  end)




end

--AddUpgradeType("new", "gears")






function RecipeDesc(prefab, describe) 
  if prefab then prefab = string.upper(prefab) end
 

  local item_describe = STRINGS.RECIPE_DESC
  item_describe[prefab] = describe

end



--RecipeDesc("meat", "spicy")






function Describe(character, prefab, describe)
    

  if character and prefab and describe then
    local Describe_Generic = "GENERIC"
    local Describe_Lookups = {
        maxwell = "waxwell",
        wigfrid = "wathgrithr",
        wilson = Describe_Generic,
    }

    if prefab == nil
    then
        return
    end
    character = string.upper(Describe_Lookups[character] or character or Describe_Generic)
    prefab = string.upper(prefab)
    local descriptions = STRINGS.CHARACTERS[character].DESCRIBE
    descriptions[prefab] = describe

  end

end



--Describe("wilson", "meat", "eeewww")



function  NewRecipe(recipe, recipetab, tech, number,atlas)




  if ingredients then


    if recipetab then
      recipetab = string.upper(recipetab)
    end

    tex = atlas



    if number == 2 then
      number = "_TWO"
    elseif number == 3 then
      number = "_THREE"
    elseif number == 4 then
      number = "_FOUR"
    end

    if tech then
      tech = string.upper(tech)..number
    end





    AddRecipe(recipe, ingredients[recipe], 
      RECIPETABS[recipetab], TECH[tech], nil, nil, nil, nil, nil, 
      "images/inventoryimages/"..atlas..".xml", ""..tex..".tex" )
  

  end


end










function Name(prefab, name)
  if prefab then prefab = string.upper(prefab) end
  local prefab_name = STRINGS.NAMES
  prefab_name[prefab] = name
  
end










function AddMapIcon(prefab, tex, atlas)
  if not Assets then
    Assets = {}
  end


  if not atlas then
    atlas = tex
  end


  table.insert(Assets, Asset("IMAGE", "images/map_icons/"..tex..".tex"))
  table.insert(Assets, Asset("ATLAS", "images/map_icons/"..atlas..".xml"))

  AddMinimapAtlas("images/map_icons/"..atlas..".xml")


  AddPrefabPostInit(prefab, function(inst)
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon(tex..".tex")  
  end)


  print("Imported "..tex..".tex and "..atlas..".xml")

end










--Add inventory textures
function AddInvTex(prefab, tex, atlas)
  if not Assets then
    Assets = {}
  end


  if not atlas then
    atlas = tex
  end

  table.insert(Assets, Asset("IMAGE", "images/inventoryimages/"..tex..".tex"))
  table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..atlas..".xml"))

  






  TUNING.STARTING_ITEM_IMAGE_OVERRIDE[prefab] = {image = prefab..".tex", atlas = "images/inventoryimages/"..prefab..".xml"}  
  AddPrefabPostInit(prefab, function(inst)
    


    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end



    if not inst.components.inventoryitem then inst:AddComponent("inventoryitem") end
    inst.components.inventoryitem.imagename = tex
    inst.components.inventoryitem.atlasname = "images/inventoryimages/"..atlas..".xml"


  end)


  print("Imported "..tex..".tex and "..atlas..".xml")

end



--Add loot to specific prefab
function AddPrefabLoot(prefab, item, chance)
  




    LootTables = GLOBAL.LootTables
    if chance == nil then 
      chance = 1
    end


    




    AddPrefabPostInit(prefab, function(inst)
      
      if not GLOBAL.TheWorld.ismastersim then
          return inst
      end



      inst:DoTaskInTime(3, function()  
        table.insert(LootTables["shark"], {item, chance})
      end)

    end)
end


--Add prefab by file name in the prefabs folder
function AddPrefab(name)
  if not PrefabFiles then
    PrefabFiles = {}
  end

  table.insert(PrefabFiles, name)





end




