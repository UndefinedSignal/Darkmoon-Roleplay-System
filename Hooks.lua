

function RPSCoreFramework:OnEventFrame(self, event, ...)
	if (event == "PLAYER_TARGET_CHANGED") then
		self.TimerID = self:ScheduleRepeatingTimer("AuraCheckTimer", 0.5)
		self:UpdatePlayerModel()
		self:UpdateInteractionFrame()
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_EQUIPMENT_CHANGED") then
		SendAddonMessage("DRPS", ".rps stat self", "WHISPER", UnitName("player"));
	elseif (event == "PLAYER_MONEY") then
		self:UpdateUnlearn()
	end
end