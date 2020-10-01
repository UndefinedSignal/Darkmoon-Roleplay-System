function RPSCoreFramework:ReloadDispList()
	local dispstring = ""
	for i=1, #RPSCoreFramework.Display.Scroll do
	    if tonumber(RPSCoreFramework.Display.Scroll[i][2]) ~= -1 then
	    	if tonumber(RPSCoreFramework.Display.Scroll[i][3]) ~= 0 then
	        	dispstring = dispstring .. RPSCoreFramework.Display.Scroll[i][1]..RPSCoreFramework.Display.Scroll[i][2].." "..RPSCoreFramework.Display.Scroll[i][3].."\n"
	        else
	        	dispstring = dispstring .. RPSCoreFramework.Display.Scroll[i][1]..RPSCoreFramework.Display.Scroll[i][2].."\n"
	        end
	    end
	end
	RPS_TextMacrosScrollText:SetText(dispstring)
	RPS_DispUpdateButton:Enable()
end

function RPSCoreFramework:UpdateScaleReset()
	if (GetMoney() < RPSCoreFramework.RequestRescale or RPSCoreFramework.MyScale == 0 or RPSCoreFramework.MyScale == -1) then
		RPS_BTNReScale:Disable();
	else
		RPS_BTNReScale:Enable();
	end
end

function RPSCoreFramework:UpdateScaleApplyButton()
	if (RPSCoreFramework.MyScale == -1 or RPSCoreFramework.MyScale ~= 0) then
		RPS_CharScaleSlider:Disable();
		RPS_BTNAcceptScale:Disable();
	else
		RPS_CharScaleSlider:Enable();
		RPS_BTNAcceptScale:Enable();
	end
end

function RPSCoreFramework:UpdateScrollerPosition()
	if RPSCoreFramework.MyScale > 0 then
		RPS_CharScaleSlider:SetValue(RPSCoreFramework.MyScale);
		RPS_CharScaleSlider:Disable();
	elseif RPSCoreFramework.MyScale == -1 then
		RPS_CharScaleSlider:SetValue(6);
		RPS_CharScaleSlider:Disable();
	else
		RPS_CharScaleSlider:SetValue(6);
		RPS_CharScaleSlider:Enable();
	end
end

function RPSCoreFramework:PeriodicallyUpdater()
	RPSCoreFramework:SendCoreMessage("rps action scale info");
	RPSCoreFramework:SendCoreMessage("rps action aura list active");
	RPSCoreFramework:UpdateScaleReset();
    if RPSCoreActionCam then
        RPSCoreActionCam = true;
        SetCVar("test_cameraDynamicPitch", 1);
        SetCVar("test_cameraOverShoulder", 1);
    else
        RPSCoreActionCam = false;
        SetCVar("test_cameraDynamicPitch", 0);
        SetCVar("test_cameraOverShoulder", 0);
    end
end

function RPSCoreFramework:UpdateScaleInfo(str)
	str = string.gsub(str, "RPS.Scale ", "");
	RPSCoreFramework.MyScale = tonumber(str);
	RPSCoreFramework.FrameUpdate = false;
	RPSCoreFramework:UpdateScaleReset();
	RPSCoreFramework:UpdateScrollerPosition();
	RPSCoreFramework:UpdateScaleApplyButton();
	RPSCoreFramework:ConfirmedAddonLoading();
end

function RPSCoreFramework:UpdateAuraKnownInfo(str)
	str = string.gsub(str, "RPS.AuraKnown ", "");
	local values = {strsplit(' ', str)};
	if (tonumber(str) == 0 or str == nil) then
		return false;
	end
	for i=1, #values do
		RPSCoreFramework.Interface.Auras[tonumber(values[i])][5] = 1;
	end
end

function RPSCoreFramework:UpdatePLayerAuraList(str)
	str = string.gsub(str, "RPS.AuraKnown ", "");
	local values = {strsplit(' ', str)};
	if (str == nil or str == "RPS.AuraKnown") then
		return false;
	end
	for i=1, #values do
		RPSCoreFramework.Interface.Auras[tonumber(values[i])][6] = 0;
	end
	if (_G["DarkmoonAurasFrame"]:IsShown() and _G["RPS_MainFrame"]:IsShown() ) then
		RPSCoreFramework:ScrollMenuUpdater();
	end
end

function RPSCoreFramework:UpdateAuraActiveInfo(str)
	str = string.gsub(str, "RPS.AuraActive ", "");
	local values = {strsplit(' ', str)};
	if (tonumber(str) == 0 or str == nil) then
		return false
	end
	if values[1] ~= nil and values[1] ~= "RPS.AuraActive" then
		for j=1, #RPSCoreFramework.Interface.Auras do
			RPSCoreFramework.Interface.Auras[j][6] = 0;
		end
		for i=1, #values do
			RPSCoreFramework.Interface.Auras[tonumber(values[i])][6] = 1;
			RPSCoreFramework.Interface.ActiveAuraCounter = RPSCoreFramework.Interface.ActiveAuraCounter + 1;
		end
	end
	RPSCoreFramework:UpdateActiveAurasCounter()
end

function RPSCoreFramework:UpdateMinstrelStatus(str)
	if (tonumber(str) == 0 or str == nil) then
		RPSCoreFramework.MinstrelStatus = tonumber(str);
		RPSCoreFramework:MinstrelCheckLock();
	else
		RPSCoreFramework.MinstrelStatus = tonumber(str);
		RPSCoreFramework:MinstrelCheckLock();
	end
end

function RPSCoreFramework:UpdateDisplayMacrosInfo(str)
	str = string.gsub(str, "RPS.Display ", ""); -- 5
	local values = {strsplit(' ', str)};
	local j = 1;
	for i = 1, 19 do
		RPSCoreFramework.Display.Scroll[i][2] = values[j];
		j = j + 1;
		RPSCoreFramework.Display.Scroll[i][3] = values[j];
		j = j + 1;
	end
end

function RPSCoreFramework:UpdateGuildSalary(str)
	local values = {strsplit(' ', str)}
	for i=1, #values do
		RPSCoreFramework.SalaryByRank[tostring(i)] = tonumber(values[i]);
	end
	if GuildInfoFrameSalary:IsShown() then
		RPSCoreFramework:ProcessGuildSalaryInterface();
	end
end

function RPSCoreFramework:RefreshActiveAuras(str)
	str = string.gsub(str, "RPS.AuraRefresh ", "")
	local values = {strsplit(' ', str)}
end

function RPSCoreFramework:UpdateInfo(str)
	str = string.gsub(str, "RPS.StatMe ", "");
	local values = {strsplit(' ', str)};
	self.FreeStats = values[1];
	self.FreeStatsCached = values[1];
	self.Stats.Strength = values[3];
    self.Stats.Agility = values[4];
    self.Stats.Intellect = values[5];
    self.Stats.Spirit = values[6];
    self.Stats.Endurance = values[7];
    self.Stats.Dexterity = values[8];
    self.Stats.Will = values[9];
	self.Stats.CriticalChance = values[17];
	self.ItemsStats.Strength = values[10];
    self.ItemsStats.Agility = values[11];
    self.ItemsStats.Intellect = values[12];
    self.ItemsStats.Spirit = values[13];
    self.ItemsStats.Endurance = values[14];
    self.ItemsStats.Dexterity = values[15];
    self.ItemsStats.Will = values[16];
	self.ItemsStats.CriticalChance = values[18];
	self:UpdateNormal();
	self:UpdateDiff();
	self:UpdateUnlearn();	
end

function RPSCoreFramework:POIUpdateIntoMainMassive()
    for k, v in pairs(RPSCoreFramework.Map.UpdatePins) do
        RPSCorePOIPins[k](v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
    end
end

function string:splitstr(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function RPSCoreFramework:AddPOIPins(str)
	local values = {strsplit("#",str)}
	if tonumber(values[1]) ~= 0 then
		RPSCorePOIPins[values[1]] = values;
		RPSCoreFramework.Map.POICounter = RPSCoreFramework.Map.POICounter + 1;
		RPSCoreFramework:POIStreamingProcess();
	end
end

function RPSCoreFramework:DailyStatusUpdate(str)
	RPSCoreFramework.DailyCipherShow = tonumber(RPSCoreFramework.DailyCipherShow) + 1;
	local int = tonumber(5 - RPSCoreFramework.DailyCipher[tonumber(str)]);
	local text;
	RPSDailyStreak = str;
	if int == 1 then text = "остался"; else text = "осталось"; end
	_G["DarkmoonCharacterFrameInfoBodyAvaGraduate"]:SetText(int);
	for i = 1, 5 do
		_G["DarkmoonCharacterFrameInfoTRBodyDay"..i.."Seal"]:Hide();
	end
	for i = 1, RPSCoreFramework.DailyCipher[tonumber(str)] do
		_G["DarkmoonCharacterFrameInfoTRBodyDay"..i.."Seal"]:Show();
	end
	if RPSCoreFramework.DailyCipherShow > 2 then
		if RPSCoreFramework.DailyCipher[tonumber(str)] < 5 then
			print("|cFFFF8040♥♥♥ Поздравляем с |cFFFFFF00"..RPSCoreFramework.DailyCipher[tonumber(str)].."\'м |cFFFF8040днём Вашей ролевой активности! Вам "..text.." всего |cFFFFFF00"..int.."|cFFFF8040 дн. активности, чтобы получить награду! ♥♥♥|r");
		elseif RPSCoreFramework.DailyCipher[tonumber(str)] ~= 0 then
			print("|cFFFF8040Ура! Вы были с нами |cFFFFFF005|r|cFFFF8040 дней подряд и получаете награду|cFFFFFF00 "..GetCoinTextureString(30000).."|r|cFFFF8040!|r");
		end
	end
end

function MountModelStatusUpdate(str)
	local values = {strsplit(' ',str)}
	if tonumber(values[1]) ~= nil then
		RPSCharSpec = tonumber(values[1]) + 1;
	else
		RPSCharSpec = 1;
	end
	DarkmoonDropSpecChoose.Text:SetText(RPSCoreFramework.CharChooseSpec[tonumber(RPSCharSpec)]);
end

function RPSCoreFramework:UpdatePOIPins(str)
	local values = {strsplit('#',str)};
	if RPSCoreFramework.Map.POIWorkflow then
		RPSCorePOIPins[values[1]] = values;
		RPSCoreFramework:POIUpdatePinPool(values[1]);
	else
		RPSCoreFramework.Map.POIUpdateQueque = true;
		RPSCoreFramework.Map.UpdatePins[tostring(values[1])] = values;
	end
end

function RPSCoreFramework:RemovePOIPins(str)
	RPSCorePOIPins[str] = nil;
	RPSCoreFramework:GeneratePOIPlaces();
end

function RPSCoreFramework:GetCommandPOIPins(str)
	local values = {strsplit(' ',str)};
	if (values[1] == "refresh") then
		RPSCoreFramework.Map.POIWorkflow = false;
		RPSCorePOIPins = {};
		if (values[2] ~= nil) then
			RPSCoreFramework.Map.POICount = values[2];
			RPSCoreFramework:POIStreamingLoad();
		end
	elseif (values[1] == "done") then
		RPSCoreFramework.CharcterPOILoaded = true;
		RPSCoreFramework.Map.POIWorkflow = true;
		if (RPSCoreFramework.Map.POIUpdateQueque) then
			RPSCoreFramework:POIUpdateIntoMainMassive();
		end
		RPSCoreFramework:CharacterInfoPOIBlock(2);
		RPSCoreFramework:StreamingLoad_UpdateIcon(0);
		RPSCoreFramework:GeneratePOIPlaces();
		RPSCoreFramework:POISearchTable(UnitName("player"), RPSCoreFramework.POISearch);
	end
end

function RPSCoreFramework:InitializePool(str)
	local values = {strsplit('#',str)};
	if values[1] == nil then
		return;
	end
end

function RPSCoreFramework:PeriodicallyScrollMenuUpdater()
	if RPSCoreFramework.Interface.Auras.Initialized then
		RPSCoreFramework:ScrollMenuUpdater();
	end
end

function RPSCoreFramework:OneShotUpdater()
	RPSCoreFramework:SendCoreMessage("minstrel status");
	RPSCoreFramework:SendCoreMessage("disp list");
	RPSCoreFramework:SendCoreMessage("poi request");
	RPSCoreFramework:SendCoreMessage("rps action scale info");
	RPSCoreFramework:SendCoreMessage("rps action aura list known");
	RPSCoreFramework:SendCoreMessage("rps action aura list active");
end

function RPSCoreFramework:PeriodicallyAurasUpdate()
	RPSCoreFramework:SendCoreMessage("rps action aura list known");
	RPSCoreFramework:SendCoreMessage("rps action aura list active");
end

function RPSCoreFramework:GlobalTimer()
	RPSCoreFramework:QuizProcess();
	RPSCoreFramework:AuraCheckTimer();
end

function RPSCoreFramework:UpdateActiveAurasCounter()
	local counter = 0;
	if RPSCoreFramework.Interface.ActiveAuraCounter ~= 0 then
		for i = 1, #RPSCoreFramework.Interface.Auras do
			if RPSCoreFramework.Interface.Auras[i][6] > 0 then
				counter = counter + 1;
			end
		end
		RPSCoreFramework.Interface.ActiveAuraCounter = counter;
	end
	_G["ActiveAura"]:SetText(RPSCoreFramework.Interface.ActiveAuraCounter.."/3", 0.5, 0.5);
	return true
end

function RPSCoreFramework:ThreeTimesUpdate()
	self.ThreeTimesTimerCount = self.ThreeTimesTimerCount + 1;
	if self.ThreeTimesTimerCount == 4 then
		RPSCoreFramework.Interface.Auras.AllowUpdate = true;
		self.ThreeTimesTimerCount = 0;
		self:CancelTimer(self.ThreeTimesTimer);
	end
	RPSCoreFramework:PeriodicallyAurasUpdate();
	RPSCoreFramework:ScrollMenuUpdater();
end

function RPSCoreFramework:SalaryIndicator(msg)
	PlaySound(54125, "SFX")
	CurrencyFrameTextFrameString:SetText("Получено |cFFFFFF00".. GetCoinTextureString(tonumber(msg)).."|r")
	RPSCoreFramework.SalaryTimer = RPSCoreFramework:ScheduleTimer("HideSalaryIndicator", 2.5);

	CurrencyFrame:Show();
end

function RPSCoreFramework:HideSalaryIndicator()
	CurrencyFrame:Hide();
end
