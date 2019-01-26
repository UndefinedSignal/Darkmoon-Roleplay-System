function RPSCoreFramework:IsDifficultRace()
	_, raceEn = UnitRace("player");
	for i=1, #RPSCoreFramework.DifficultRaces do
		if (RPSCoreFramework.DifficultRaces[i] == string.lower(raceEn)) then
			return true
		end
	end

	return false
end

function RPSCoreFramework:IsDifficultClass()
	_, _, classID = UnitClass("player");
	for i=1, #RPSCoreFramework.DifficultClass do
		if (RPSCoreFramework.DifficultClass[i] == classID) then
			return true
		end
	end

	return false
end

function RPSCoreFramework:DifficultMessageSendToPlayer()
	local message = "";
	local flag = false;
	if (RPSCoreFramework:IsDifficultRace() and RPSCoreFramework:IsDifficultClass()) then
		message = RPSCoreFramework.Literature.StartMessageDifficultRaceAndClass;
		flag = true;
	elseif RPSCoreFramework:IsDifficultRace() then
		message = RPSCoreFramework.Literature.StartMessageDifficultRace;
		flag = true;
	elseif RPSCoreFramework:IsDifficultClass() then
		message = RPSCoreFramework.Literature.StartMessageDifficultClass;
		flag = true;
	end

	StaticPopupDialogs["PopupDifficultRaceOrClassMessage"] = {
		text = "|cFFFFFF00ВНИМАНИЕ!|r\n\n"..message,	
		button1 = OKAY,
		OnAccept = function() end,
		OnShow = function(self)
			self.declineTimeLeft = 15;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
					self.button1:SetText(OKAY)
					self.button1:Enable();
					self.ticker:Cancel();
					return;
				else
					self.button1:SetText(self.declineTimeLeft);
				end
			end);
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		StartDelay = function() return 15; end,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}

	if flag then		
		C_Timer.NewTicker(5, function() StaticPopup_Show("PopupDifficultRaceOrClassMessage"); end, 1);	
		flag = false;
	end
end