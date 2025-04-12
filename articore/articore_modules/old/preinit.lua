init = "init/"

function LoadedArticore()
	branch = string.upper(GLOBAL.BRANCH)

	AddClassPostConstruct(mainscreen, function(self)
		self.inst:DoTaskInTime(1.7, function(self)
			print("----------------------")
			print("Articore Modules Loaded")
			print("Articore API Loaded..")

			print("----------------------")
			print("Version 3.0")
			print("Author: Clifford W.")
			print("----------------------")
		end)

		local OldFunc = self.OnUpdate

		self.OnUpdate = function(self, ...)
			local ret = { OldFunc(self, ...) }

			self.inst:DoTaskInTime(1.5, function(self)
				if not self.articore_loaded then
					TheFrontEnd:GetSound()
						:PlaySound("dontstarve/HUD/Together_HUD/collectionscreen/mysterybox/intro", "loaded")
					TheFrontEnd:GetSound():SetParameter("FEMusic", "fade", 1)
					--TheFrontEnd:GetSound():PlaySound("dontstarve/together_FE/portal_idle_vines", "FEPortalSFX")
					self.articore_loaded = true
				end
			end)

			return unpack(ret)
		end
	end)
end
