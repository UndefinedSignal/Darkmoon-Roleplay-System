function RPSCoreFramework:IsDifficultRace()
	race, raceEn = UnitRace("player");

	for k, v in ipairs(RPSCoreFramework.DifficultRaces) do
		if v == string.lower(raceEn) then
			return true
		end
	end

	return false
end

function RPSCoreFramework:IsDifficultClass()
	className, __, classID = UnitClass("player");
	for k, v in ipairs(RPSCoreFramework.DifficultClass) do
		if v == classID then
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

	if flag then
		StaticPopupDialogs["PopupDifficultRaceOrClassMessage"] = {
			text = message,	
			button1 = OKAY,
			OnAccept = function() RPSCoreFramework:SubmitDiff() end,
			--timeout = 15,
			whileDead = true,
			hideOnEscape = false,
			--StartDelay = function() return 1; end, -- Я не понял как это работает.
			exclusive = true,
			showAlert = 1,
			preferredIndex = 3, 
		}

		StaticPopup_Show("PopupDifficultRaceOrClassMessage")

		flag = false;
	end
end