init = "init/"

function LoadedCobalt()


  branch = string.upper(GLOBAL.BRANCH)
    
  AddClassPostConstruct(mainscreen, function(self)
      
    self.inst:DoTaskInTime(1.7, function(self)


		print("----------------------")
		print("Cobalt Modules Loaded")
		print("Cobalt API Loaded..")

		print("----------------------")
		print("Version 1.0")
		print("Author: Clifford W.")
		print("----------------------")
    

  	end)


    self.oldinit = self.OnUpdate
    self.OnUpdate = function(self)
      self.oldinit(self)

      self.inst:DoTaskInTime(1.5, function(self)

        if not self.cobalt_loaded then
            TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/Together_HUD/collectionscreen/mysterybox/intro","loaded")
            TheFrontEnd:GetSound():SetParameter("FEMusic", "fade", 1)
            --TheFrontEnd:GetSound():PlaySound("dontstarve/together_FE/portal_idle_vines", "FEPortalSFX")
            self.cobalt_loaded = true
        end





      end)
      
    

      
    end

  end)





end