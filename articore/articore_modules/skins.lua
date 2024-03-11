function AddItemSkin(prefab, skin, name, description, test)
	local _G = GLOBAL
	local PREFAB_SKINS = PREFAB_SKINS
	local PREFAB_SKINS_IDS = PREFAB_SKINS_IDS
	local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")
		local skinname = prefab.."_"..skin
		AddPrefab(skinname)
	 

	  STRINGS.SKIN_NAMES[skinname] = name
	  STRINGS.SKIN_DESCRIPTIONS[skinname] = description
	  
	  if not none_skin then
	    --AddDynamic(skin)
	  end

	  if not PREFAB_SKINS[prefab] then
	    PREFAB_SKINS[prefab] = {}
	  end


	  	if test then 
		    AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self)
		      self.inst:DoTaskInTime(FRAMES, function()

		        local online = TheNet:IsOnlineMode() and not TheFrontEnd:GetIsOfflineMode()


		        local ThankYouPopup = require "screens/thankyoupopup"
		        local SkinGifts = require("skin_gifts")
		        
		        if online then

		            TheFrontEnd:PushScreen(ThankYouPopup({{ item = string.lower(skinname), item_id = 0, gifttype = SkinGifts.types[skinname] or "DEFAULT" }}))
		        end
		      end)
		    end)
		end
	  table.insert(PREFAB_SKINS[prefab], skinname)
end