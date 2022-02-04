function RPSCoreFramework:IsAdvancedRace()
	_, raceEn = UnitRace("player");
	for i=1, #RPSCoreFramework.AdvancedRaces do
		if (RPSCoreFramework.AdvancedRaces[i] == string.lower(raceEn)) then
			return true;
		end
	end
	return false;
end
function RPSCoreFramework:IsAdvancedClass()
	_, _, classID = UnitClass("player");
	for i=1, #RPSCoreFramework.AdvancedClasses do
		if (RPSCoreFramework.AdvancedClasses[i] == classID) then
			return true;
		end
	end
	return false;
end
function RPSCoreFramework:IsCharsheetRequired()
	_, _, classID = UnitClass("player");
	for i=1, #RPSCoreFramework.AdvancedClassesCharsheetRequired do
		if (RPSCoreFramework.AdvancedClassesCharsheetRequired[i] == classID) then
			return true;
		end
	end
	return false;
end
function RPSCoreFramework:AdvancedCharacterMessageCheck()	
	if (not RPSCoreAdvancedCharacterCheckShown) then		
		RPSCoreAdvancedCharacterCheckShown = true;
	else
		return;
	end
	local message = "";
	local flag = false;
	local isAdvancedRace = self:IsAdvancedRace();
	local isAdvancedClass = self:IsAdvancedClass();
	local isCharsheetRequired = self:IsCharsheetRequired();
	if (isAdvancedRace) then
		message = message.."\n"..RPSCoreFramework.Literature.AdvancedRaceMessage;
	end
	if (isAdvancedClass) then
		message = message.."\n"..RPSCoreFramework.Literature.AdvancedClassMessage;
	end
	if (isCharsheetRequired) then
		message = message.."\n\n"..RPSCoreFramework.Literature.CharsheetRequiredMessage;
	end
	if (isAdvancedRace or isAdvancedClass or isCharsheetRequired) then
		flag = true;
	end
	if (flag) then	
		if ((isAdvancedRace or isAdvancedClass) and not isCharsheetRequired) then
			if (not isCharsheetRequired) then
				message = message.."\n\n"..RPSCoreFramework.Literature.CharsheetRecommendedMessage;
			end
		end
		C_Timer.NewTicker(5, function() StaticPopup_Show("AdvancedCharacterMessage", message); end, 1);
	end;		
end
