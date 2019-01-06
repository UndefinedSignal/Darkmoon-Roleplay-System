function RPSCoreFramework:IsDifficultRace()
	race, raceEn = string.lower(UnitRace("player"));

	for k, v in ipairs(RPSCoreFramework.DifficultRaces) do
		if v == raceEn then
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
		RPSCoreFramework:ShowDifficultMessageConstructor(message);

		StaticPopupDialogs["PopupDifficultRaceOrClassMessage"] = {
			text = message,
			button1 = OKAY,
			OnAccept = function() RPSCoreFramework:SubmitDiff() end,
			timeout = 3,
			whileDead = true,
			hideOnEscape = false,
			StartDelay = function() return 1; end,
			exclusive = true,
			showAlert = 1,
			preferredIndex = 3, 
		}

		StaticPopup_Show("PopupDifficultRaceOrClassMessage")

		flag = false;
	end
end