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
	RPSCoreFramework:UpdateScaleReset();
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
function RPSCoreFramework:UpdatePOIPins(str)
	local values = {strsplit('#',str)};	
	RPSCorePOIPins[values[1]] = values;
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
function RPSCoreFramework:AddPOIPins(str)
	local values = {strsplit("#",str)}
	RPSCorePOIPins[values[1]] = values;
end

function RPSCoreFramework:UpdatePOIPins(str)
	local values = {strsplit('#',str)};
	if RPSCoreFramework.Map.POIWorkflow then
		RPSCorePOIPins[values[1]] = values;
	else
		RPSCoreFramework.Map.POIUpdateQueque = true;
		RPSCoreFramework.Map.UpdatePins[values[1]] = values;
	end
end

function RPSCoreFramework:RemovePOIPins(str)
	RPSCorePOIPins[str] = nil;
	RPSCoreFramework:GeneratePOIPlaces();
end

function RPSCoreFramework:GetCommandPOIPins(str)
	if (str == "refresh") then
		RPSCoreFramework.Map.POIWorkflow = false;
		RPSCorePOIPins = {};
	elseif (str == "done") then
		RPSCoreFramework.Map.POIWorkflow = true;
		if (RPSCoreFramework.Map.POIUpdateQueque) then
			RPSCoreFramework:POIUpdateIntoMainMassive();
		end
		RPSCoreFramework:GeneratePOIPlaces();
	end
end

function RPSCoreFramework:PeriodicallyScrollMenuUpdater()
	if RPSCoreFramework.Interface.Auras.Initialized then
		RPSCoreFramework:ScrollMenuUpdater();
	end
end

function RPSCoreFramework:OneShotUpdater()
	RPSCoreFramework:SendCoreMessage("disp list");
	RPSCoreFramework:SendCoreMessage("rps request poi init");
	RPSCoreFramework:SendCoreMessage("rps action scale info");
	RPSCoreFramework:SendCoreMessage("rps action aura list known");
	RPSCoreFramework:SendCoreMessage("rps action aura list active");
end

function RPSCoreFramework:PeriodicallyAurasUpdate()
	RPSCoreFramework:SendCoreMessage("rps action aura list known");
	RPSCoreFramework:SendCoreMessage("rps action aura list active");
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
	_G["ActiveAura"]:SetText(RPSCoreFramework.Interface.ActiveAuraCounter, 0.5, 0.5);
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

--"RPS.CON.i"
function RPSCoreFramework:InitializeContainer(msg)
	print("InitializeContainer: ".. msg);
	local values = {strsplit('#',msg)};	
	if RPSCoreFramework.ContainerDataFlow then
		--[[name(title)
		--	type
		--	size]]
		RPSCoreFramework.ContainerDataFlow = false;
		RPSCoreFramework.Container.title = values[1];
		RPSCoreFramework.Container.type = values[2];
		RPSCoreFramework.Container.size = tonumber(values[3]);
		RPSCoreFramework:SetUpContainerFrame();
		return;
	end
	--[[slot
	--	itemID
	--	count]]
	RPSCoreFramework:PushContainerItem(tonumber(values[1]), {isVirtual = true, itemID = tonumber(values[2]), count = tonumber(values[3]), locked = false});
end
--"RPS.CON.c"
function RPSCoreFramework:InvokeContainerComamnd(msg)
	print("InvokeContainerComamnd: ".. msg);
	if ( msg == "done" ) then
		RPSCoreFramework.ContainerDataFlow = true
		RPSCoreFramework:ContainerFrameGenerateFrame(_G["RPS_ContainerFrame"], RPSCoreFramework.Container.size, RPSCoreFramework.Container.title)
	end
end
--"RPS.CON.upd"
function RPSCoreFramework:UpdateContainer(msg)
	print("UpdateContainer: ".. msg);
	RPSCoreFramework:ContainerFrameUpdate();
end

function RPSCoreFramework:SalaryIndicator(msg)
	print("Salary coming in! ".. msg);

--[[treasuregoblin_coinimpact.m2
	treasuregoblin_portal.m2]]

end