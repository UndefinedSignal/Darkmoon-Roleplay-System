RPSCoreFramework = LibStub("AceAddon-3.0"):NewAddon(CreateFrame("Frame"), "RPSCoreFramework", "AceHook-3.0", "AceTimer-3.0" )
RegisterAddonMessagePrefix("DRPS");
RPSCoreFramework.TargetAura = 1000012;
RPSCoreFramework.TimerID = false;
RPSCoreFramework.ShowMain = false;
RPSCoreFramework.RequestUnlearn = 50000;
RPSCoreFramework.RequestRescale = 500000;
RPSCoreFramework.GetLastClickedSlot = "chest";
RPSCoreFramework.StatsLevel = 40;
RPSCoreFramework.Literature = {};
RPSCoreFramework.StatsDiff = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}
RPSCoreFramework.Stats = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}
RPSCoreFramework.ItemsStats = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}

RPSCoreFramework.SlotnameListPresets = {
	head = ".disp head ",
	shoulder = ".disp shoulder ",
	back = ".disp back ",
	chest = ".disp chest ",
	shirt = ".disp shirt ",
	tabard = ".disp tabard ",
	wrist = ".disp wrist ",
	hands = ".disp hands ",
	waist = ".disp waist ",
	legs = ".disp legs ",
	feet = ".disp feet ",
	mainhand = ".disp mainhand ",
	offhand = ".disp offhand "
}

RPSCoreFramework.SlotnameListNames = {
	shoulder = "наплечников",
	back = "плаща",
	chest = "тела",
	shirt = "рубашки",
	tabard = "гербовой накидки",
	wrist = "наручей",
	hands = "перчаток",
	waist = "пояса",
	legs = "штанов",
	feet = "обуви",
	mainhand = "оружия в правой руке",
	offhand = "оружия в левой руке"
}

RPSCoreFramework.FreeStats = 0;
RPSCoreFramework.FreeStatsCached = 0;

RPSCoreFramework.DropDownDisplayMenu = {
	    { text = "Display", isTitle = true, notCheckable = true},
	    { text = "Изменить", notCheckable = true, func = function() RPSCoreFramework:ShowDisplayInfo(RPSCoreFramework.GetLastClickedSlot); end },
	    { text = "Сбросить", notCheckable = true, func = function() RPSCoreFramework:RemoveDisplay(RPSCoreFramework.GetLastClickedSlot); end }
}	
local DropDownDisplayMenuFrame = CreateFrame("Frame", "DisplayMenuFrame", UIParent, "UIDropDownMenuTemplate")

function RPSCoreFramework:ShowDisplayDropDownMenu(inventorySlotId)
	if (GetInventoryItemID("player", inventorySlotId)) then
		EasyMenu(RPSCoreFramework.DropDownDisplayMenu, DropDownDisplayMenuFrame, "cursor", 5, -15, "MENU", 5);
	end
end

function RPSCoreFramework:IsFallen()
	local counter = 1;
	local aura = UnitAura("Target", counter)
	while aura do
		aura, _, _, _, _, _, _, _, _, _, spellId = UnitAura("Target", counter);
		counter = counter + 1;
		if (spellId == RPSCoreFramework.TargetAura) then
			return true;
		end
	end
	return false;
end

function RPSCoreFramework:UpdatePlayerModel()
	RPS_InteractFrameSelfModel:SetUnit("Player")
	RPS_InteractFrameTargetModel:SetUnit("Target")
end

function RPSCoreFramework:IsInteractCast()
	local name, _, _, _, _, _, _, _, _, _ = UnitCastingInfo("player");
	if (name == "Помочь" or name == "Добить") then
		return true;
	else
		return false;
	end;
end

function RPSCoreFramework:UpdateInteractionFrame()
	if (self:IsFallen() and CheckInteractDistance("target", 3) and not UnitIsUnit("player", "target") and not self:IsInteractCast()) then
		RPS_InteractFrame:Show();
	else
		RPS_InteractFrame:Hide();
	end
end

function RPSCoreFramework:AuraCheckTimer()
	self:UpdateInteractionFrame();
end

function RPSCoreFramework:UpdateTypingStatus(editbox)
	local chatType = editbox:GetAttribute("chatType");
	local text = editbox:GetText();
	local firstChar = text:sub(1, 1);
	if (editbox:IsShown() and text:len() > 0 and firstChar ~= "/" and firstChar ~= "." and firstChar ~= "!" and firstChar ~= "#" and (chatType == "SAY" or chatType == "YELL" or chatType == "EMOTE")) then
		if not self.isTypingMessage then
			self.isTypingMessage = true;
			self:SendCoreMessage(".typing on");
		end
	else
		if self.isTypingMessage then
			self.isTypingMessage = false;
			self:SendCoreMessage(".typing off");
		end
	end
end

function RPSCoreFramework:SendCoreMessage(msg)
	SendAddonMessage("DRPS", msg, "WHISPER", UnitName("player"));
end;

local function switchMainFrame()
	if RPS_MainFrame:IsVisible() then
		RPS_MainFrame:Hide();
	else
		RPS_MainFrame:Show();
	end
end

local function AddPlus(str)
	if (str>0) then
		return "+"..str;
	else
		return str;
	end;
end

local function FormatRoll(stat, bonus)
	local level = UnitLevel("player");
	local maxRoll = 100;
	if (level < RPSCoreFramework.StatsLevel) then
		maxRoll = "|cFFFF000080|r";
	end;
	if (bonus ~= nil and tonumber(bonus)>0) then
		local statbonus = stat+bonus;
		if (statbonus>80) then
			statbonus = "|cFFFF000080|r";
		end
		return statbonus.." - "..maxRoll.." ("..stat.."|cFF00FF00+"..bonus.."|r)";
	else
		return tostring(stat).." - "..maxRoll;
	end
end

function RPSCoreFramework:UpdateDiff()
	local levelLimit = UnitLevel("player") - 39;
	
	StrengthStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Strength))
	AgilityStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Agility))
	IntellectStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Intellect))
	CriticalChanceStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.CriticalChance))
	SpiritStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Spirit))
	EnduranceStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Endurance))
	DexterityStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Dexterity))
	WillStatValue:SetText(AddPlus(RPSCoreFramework.StatsDiff.Will))
	
	if (tonumber(RPSCoreFramework.FreeStats) <= 0) then
		StrengthPlus:Disable()
		AgilityPlus:Disable()
		IntellectPlus:Disable()
		CriticalChancePlus:Disable()
		SpiritPlus:Disable()
		EndurancePlus:Disable()
		DexterityPlus:Disable()
		WillPlus:Disable()
	else
		StrengthPlus:Enable()
		AgilityPlus:Enable()
		IntellectPlus:Enable()
		CriticalChancePlus:Enable()
		SpiritPlus:Enable()
		EndurancePlus:Enable()
		DexterityPlus:Enable()
		WillPlus:Enable()
	end
	
	if (RPSCoreFramework.StatsDiff.Strength >0) then
		StrengthMinus:Enable()
	else
		StrengthMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Agility >0) then
		AgilityMinus:Enable()
	else
		AgilityMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Intellect >0) then
		IntellectMinus:Enable()
	else
		IntellectMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.CriticalChance >0) then
		CriticalChanceMinus:Enable()
	else
		CriticalChanceMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Spirit >0) then
		SpiritMinus:Enable()
	else
		SpiritMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Endurance >0) then
		EnduranceMinus:Enable()
	else
		EnduranceMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Dexterity >0) then
		DexterityMinus:Enable()
	else
		DexterityMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Will >0) then
		WillMinus:Enable()
	else
		WillMinus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Strength + RPSCoreFramework.Stats.Strength < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		StrengthPlus:Enable()
	else
		StrengthPlus:Disable()
	end

	if (RPSCoreFramework.StatsDiff.Agility + RPSCoreFramework.Stats.Agility < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		AgilityPlus:Enable()
	else
		AgilityPlus:Disable()
	end

	if (RPSCoreFramework.StatsDiff.Intellect + RPSCoreFramework.Stats.Intellect < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		IntellectPlus:Enable()
	else
		IntellectPlus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.CriticalChance + RPSCoreFramework.Stats.CriticalChance < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		CriticalChancePlus:Enable()
	else
		CriticalChancePlus:Disable()
	end

	if (RPSCoreFramework.StatsDiff.Spirit + RPSCoreFramework.Stats.Spirit < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		SpiritPlus:Enable()
	else
		SpiritPlus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Endurance + RPSCoreFramework.Stats.Endurance < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		EndurancePlus:Enable()
	else
		EndurancePlus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Dexterity + RPSCoreFramework.Stats.Dexterity < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		DexterityPlus:Enable()
	else
		DexterityPlus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Will + RPSCoreFramework.Stats.Will < levelLimit and tonumber(RPSCoreFramework.FreeStats) > 0) then
		WillPlus:Enable()
	else
		WillPlus:Disable()
	end
	
	if (RPSCoreFramework.StatsDiff.Strength >0 or RPSCoreFramework.StatsDiff.Agility >0 or RPSCoreFramework.StatsDiff.Intellect >0 or RPSCoreFramework.StatsDiff.CriticalChance >0
	or RPSCoreFramework.StatsDiff.Spirit >0 or RPSCoreFramework.StatsDiff.Endurance >0 or RPSCoreFramework.StatsDiff.Dexterity >0 or RPSCoreFramework.StatsDiff.Will >0) then
		DarkmoonCharStatsInfoReset:Enable();
		DarkmoonCharStatsInfoSubmit:Enable();
	else
		DarkmoonCharStatsInfoReset:Disable();
		DarkmoonCharStatsInfoSubmit:Disable();
	end
end

function RPSCoreFramework:UpdateNormal()
	StrengthStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Strength, RPSCoreFramework.ItemsStats.Strength))
	AgilityStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Agility, RPSCoreFramework.ItemsStats.Agility))
	IntellectStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Intellect, RPSCoreFramework.ItemsStats.Intellect))
	CriticalChanceStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.CriticalChance, RPSCoreFramework.ItemsStats.CriticalChance))
	SpiritStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Spirit, RPSCoreFramework.ItemsStats.Spirit))
	EnduranceStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Endurance, RPSCoreFramework.ItemsStats.Endurance))
	DexterityStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Dexterity, RPSCoreFramework.ItemsStats.Dexterity))
	WillStatRoll:SetText(FormatRoll(RPSCoreFramework.Stats.Will, RPSCoreFramework.ItemsStats.Will))
	self:UpdateFreeStat()
end

function RPSCoreFramework:UpdateUnlearn()
	if ((tonumber(RPSCoreFramework.Stats.Strength) >1 or tonumber(RPSCoreFramework.Stats.Agility) >1 or tonumber(RPSCoreFramework.Stats.Intellect) >1 or tonumber(RPSCoreFramework.Stats.CriticalChance) >1
	or tonumber(RPSCoreFramework.Stats.Spirit) >1 or tonumber(RPSCoreFramework.Stats.Endurance) >1 or tonumber(RPSCoreFramework.Stats.Dexterity) >1 or tonumber(RPSCoreFramework.Stats.Will) >1)
	and (GetMoney() >= RPSCoreFramework.RequestUnlearn)) then
		DarkmoonCharStatsInfoUnlearn:Enable();
	else
		DarkmoonCharStatsInfoUnlearn:Disable();
	end
end

function RPSCoreFramework:ReloadDispList()
	local dispstring = ""
	for i=1, #RPSCoreFramework.Display.Scroll do
	    if tonumber(RPSCoreFramework.Display.Scroll[i][2]) ~= -1 then
	        dispstring = dispstring .. RPSCoreFramework.Display.Scroll[i][1]..RPSCoreFramework.Display.Scroll[i][2].." "..RPSCoreFramework.Display.Scroll[i][3].."\n"
	    end
	end
	RPS_TextMacrosScrollText:SetText(dispstring)
	RPS_DispUpdateButton:Enable()
end

function RPSCoreFramework:UpdateScaleReset()
	if (GetMoney() <= RPSCoreFramework.RequestRescale or RPSCoreFramework.MyScale == 0 or RPSCoreFramework.MyScale == -1) then
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

function RPSCoreFramework:CreateDispMacro()
    if GetNumMacros() <= 120 then
        StaticPopup_Show("MakeMacros")
    end
    PlaySound(624, "SFX")
end

function RPSCoreFramework:UpdateScrollerPosition()
	if RPSCoreFramework.MyScale > 0 then
		RPS_CharScaleSlider:SetValue(RPSCoreFramework.MyScale)
		RPS_CharScaleSlider:Disable()
	elseif RPSCoreFramework.MyScale == -1 then
		RPS_CharScaleSlider:SetValue(6)
		RPS_CharScaleSlider:Disable()
	else
		RPS_CharScaleSlider:SetValue(6)
		RPS_CharScaleSlider:Enable()
	end
end

function RPSCoreFramework:UpdateFreeStat()
	local level = UnitLevel("player");
	if (level >= RPSCoreFramework.StatsLevel) then
		DarkmoonCharStatsInfoFreeStat:SetText("Свободный опыт: "..RPSCoreFramework.FreeStats)
	else
		DarkmoonCharStatsInfoFreeStat:SetText("|cFFFF0000Требуется "..RPSCoreFramework.StatsLevel.." уровень.|r")
	end	
end

function RPSCoreFramework:DecStrength()
	self.StatsDiff.Strength = math.max(0, self.StatsDiff.Strength - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1);
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecAgility()
	self.StatsDiff.Agility = math.max(0, self.StatsDiff.Agility - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1);
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecIntellect()
	self.StatsDiff.Intellect = math.max(0, self.StatsDiff.Intellect - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecCriticalChance()
	self.StatsDiff.CriticalChance = math.max(0, self.StatsDiff.CriticalChance - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecSpirit()
	self.StatsDiff.Spirit = math.max(0, self.StatsDiff.Spirit - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecEndurance()
	self.StatsDiff.Endurance = math.max(0, self.StatsDiff.Endurance - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecDexterity()
	self.StatsDiff.Dexterity = math.max(0, self.StatsDiff.Dexterity - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:DecWill()
	self.StatsDiff.Will = math.max(0, self.StatsDiff.Will - 1);
	self.FreeStats = math.min(self.FreeStatsCached, self.FreeStats + 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncStrength()
	self.StatsDiff.Strength = self.StatsDiff.Strength + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncAgility()
	self.StatsDiff.Agility = self.StatsDiff.Agility + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncIntellect()
	self.StatsDiff.Intellect = self.StatsDiff.Intellect + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncCriticalChance()
	self.StatsDiff.CriticalChance = self.StatsDiff.CriticalChance + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncSpirit()
	self.StatsDiff.Spirit = self.StatsDiff.Spirit + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncEndurance()
	self.StatsDiff.Endurance = self.StatsDiff.Endurance + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncDexterity()
	self.StatsDiff.Dexterity = self.StatsDiff.Dexterity + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:IncWill()
	self.StatsDiff.Will = self.StatsDiff.Will + 1;
	self.FreeStats = math.max(0, self.FreeStats - 1)
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:ResetDiff()
	self.StatsDiff.Strength = 0;
	self.StatsDiff.Agility = 0;
	self.StatsDiff.Intellect = 0;
	self.StatsDiff.CriticalChance = 0;
	self.StatsDiff.Spirit = 0;
	self.StatsDiff.Endurance = 0;
	self.StatsDiff.Dexterity = 0;
	self.StatsDiff.Will = 0;
	self.FreeStats = self.FreeStatsCached;
	self:UpdateFreeStat()
	self.UpdateDiff();
end

function RPSCoreFramework:SubmitDiff()
	if (self.StatsDiff.Strength>0) then
		self:SendCoreMessage(".rps stat submit strength "..self.StatsDiff.Strength);
	end
	if (self.StatsDiff.Agility>0) then
		self:SendCoreMessage(".rps stat submit agility "..self.StatsDiff.Agility);
	end
	if (self.StatsDiff.Intellect>0) then
		self:SendCoreMessage(".rps stat submit intellect "..self.StatsDiff.Intellect);
	end
	if (self.StatsDiff.CriticalChance>0) then
		self:SendCoreMessage(".rps stat submit criticalchance "..self.StatsDiff.CriticalChance);
	end
	if (self.StatsDiff.Spirit>0) then
		self:SendCoreMessage(".rps stat submit spirit "..self.StatsDiff.Spirit);
	end
	if (self.StatsDiff.Endurance>0) then
		self:SendCoreMessage(".rps stat submit endurance "..self.StatsDiff.Endurance);
	end
	if (self.StatsDiff.Dexterity>0) then
		self:SendCoreMessage(".rps stat submit dexterity "..self.StatsDiff.Dexterity);
	end
	if (self.StatsDiff.Will>0) then
		self:SendCoreMessage(".rps stat submit will "..self.StatsDiff.Will);
	end
	
	self.StatsDiff.Strength = 0;
	self.StatsDiff.Agility = 0;
	self.StatsDiff.Intellect = 0;
	self.StatsDiff.CriticalChance = 0;
	self.StatsDiff.Spirit = 0;
	self.StatsDiff.Endurance = 0;
	self.StatsDiff.Dexterity = 0;
	self.StatsDiff.Will = 0;
	
	DarkmoonCharStatsInfoReset:Disable();
	DarkmoonCharStatsInfoSubmit:Disable();
	
	self:SendCoreMessage(".rps stat self");
end

function RPSCoreFramework:UpdateScaleInfo(str)
	str = string.gsub(str, "RPS.Scale ", "")
	RPSCoreFramework.MyScale = tonumber(str)
	--print(str)
	RPSCoreFramework:UpdateScaleReset()
end

function RPSCoreFramework:UpdateAuraKnownInfo(str)
	str = string.gsub(str, "RPS.AuraKnown ", "") -- 4
	local values = {strsplit(' ', str)}
	if (tonumber(str) == 0 or str == nil) then
		return false
	end
	for i=1, #values do
		RPSCoreFramework.Interface.Auras[tonumber(values[i])][4] = 1
	end
end

function RPSCoreFramework:UpdateAuraActiveInfo(str)
	str = string.gsub(str, "RPS.AuraActive ", "") -- 5
	local values = {strsplit(' ', str)}
	if (tonumber(str) == 0 or str == nil) then
		return false
	end
	for j=1, #RPSCoreFramework.Interface.Auras do
		RPSCoreFramework.Interface.Auras[j][5] = 0
	end
	if (values[1] ~= "RPS.AuraActive") then
		for i=1, #values do
			RPSCoreFramework.Interface.Auras[tonumber(values[i])][5] = 1
			RPSCoreFramework.Interface.ActiveAuraCounter = RPSCoreFramework.Interface.ActiveAuraCounter + 1
		end
	end
	
	RPSCoreFramework:UpdateActiveAurasCounter()
end

function RPSCoreFramework:UpdateDisplayMacrosInfo(str)
	str = string.gsub(str, "RPS.Display ", "") -- 5
	local values = {strsplit(' ', str)}
	local j = 1
	for i = 1, 18 do
		RPSCoreFramework.Display.Scroll[i][2] = values[j]
		j = j + 1
		RPSCoreFramework.Display.Scroll[i][3] = values[j]
		j = j + 1
	end
end

function RPSCoreFramework:UpdateInfo(str)
	str = string.gsub(str, "RPS.StatMe ", "");
	local values = {strsplit(' ', str)};
	self.FreeStats = values[1];
	self.FreeStatsCached = values[1];
	-- values[2] - hp
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

function RPSCoreFramework:ItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local _, _, _, _, _, sType, _, _ = GetItemInfo(link);
	
	if (sType == "Доспехи" or sType == "Armor") then		
		local name = self:GetName()
		for i = 1, self:NumLines() do
			local left = _G[name .. "TextLeft" .. i]
			local right = _G[name .. "TextRight" .. i]
			if (left:GetText() ~= nil) then
				if (string.find(left:GetText(), ITEM_MOD_STRENGTH_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_STRENGTH_SHORT, "к стойкости"));
				elseif (string.find(left:GetText(), ITEM_MOD_AGILITY_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_AGILITY_SHORT, "к сноровке"));
				elseif (string.find(left:GetText(), ITEM_MOD_INTELLECT_SHORT )) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_INTELLECT_SHORT, "к воле"));
				end
			end

			if (right:GetText() ~= nil) then
				if (string.find(right:GetText(), "Декоративный предмет") or string.find(right:GetText(), "Cosmetic")) then
					_G[name .. "TextRight" .. i]:SetText("Предмет");
				end
			end

		end
	end
end
--DarkmoonPlayerModel
--<Texture file="Interface\DRESSUPFRAME\DressingRoomPaladin.BLP" horizTile="true" vertTile="true">
--<Anchor point="TOPLEFT" x="18" y="-16"/>
--<Anchor point="BOTTOMRIGHT" x="-18" y="18"/>
function RPSCoreFramework:GenerateClassBackground()
	local _, classFileName = UnitClass("player")
	if classFileName == nil then
		classFileName=PALADIN
	end

	local tex = DarkmoonPlayerModel:CreateTexture(nil, "BACKGROUND")
	tex:SetTexture(RPSCoreFramework.CharacterBackground[classFileName]);
	tex:SetPoint("TOPLEFT", 1, -3)
	tex:SetPoint("BOTTOMRIGHT", 22, -6)
end

function RPSCoreFramework:GenerateCharScaleSlider()
	RPS_CharScaleSlider:SetOrientation('VERTICAL')
	RPS_CharScaleSlider:SetMinMaxValues(1, 11)

	if RPSCoreFramework.MyScale > 0 then
		RPS_CharScaleSlider:SetValue(RPSCoreFramework.MyScale)
	else
		RPS_CharScaleSlider:SetValue(6)
	end
	
	RPS_CharScaleSlider:SetValueStep(1)
	RPS_CharScaleSlider:SetObeyStepOnDrag(true)

	RPS_CharScaleSliderLow:SetText(' ')
    RPS_CharScaleSliderHigh:SetText(' ')
    RPS_CharScaleSliderText:SetText(' ')

	DarkmoonPlayerModel:SetCamDistanceScale(0.75)
	DarkmoonPlayerModel:SetPosition(-1, 0, -0.05)

	RPS_CharScaleSlider.minValue, RPS_CharScaleSlider.maxValue = RPS_CharScaleSlider:GetMinMaxValues() 
	RPS_CharScaleSlider:SetScript("OnValueChanged", function(self,event,arg1) 
		if event == 1 then -- Огромный
			DarkmoonPlayerModel:SetCamDistanceScale(0.65)
			DarkmoonPlayerModel:SetPosition(-1, 0, 0)
			RPSCoreFramework.ChoosedScale = 1
		elseif event == 2 then -- 
			DarkmoonPlayerModel:SetCamDistanceScale(0.67)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.01)
			RPSCoreFramework.ChoosedScale = 2
		elseif event == 3 then -- Высокий
			DarkmoonPlayerModel:SetCamDistanceScale(0.69)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.02)
			RPSCoreFramework.ChoosedScale = 3
		elseif event == 4 then -- 
			DarkmoonPlayerModel:SetCamDistanceScale(0.71)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.03)
			RPSCoreFramework.ChoosedScale = 4
		elseif event == 5 then --
			DarkmoonPlayerModel:SetCamDistanceScale(0.73)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.04)
			RPSCoreFramework.ChoosedScale = 5
		elseif event == 6 then -- Нормальный
			DarkmoonPlayerModel:SetCamDistanceScale(0.75)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.05)
			RPSCoreFramework.ChoosedScale = 6
		elseif event == 7 then -- 
			DarkmoonPlayerModel:SetCamDistanceScale(0.77)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.06)
			RPSCoreFramework.ChoosedScale = 7
		elseif event == 8 then -- 
			DarkmoonPlayerModel:SetCamDistanceScale(0.79)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.07)
			RPSCoreFramework.ChoosedScale = 8
		elseif event == 9 then -- Невысокий
			DarkmoonPlayerModel:SetCamDistanceScale(0.81)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.08)
			RPSCoreFramework.ChoosedScale = 9
		elseif event == 10 then
			DarkmoonPlayerModel:SetCamDistanceScale(0.83)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.09)
			RPSCoreFramework.ChoosedScale = 10
		else -- Низкий
			DarkmoonPlayerModel:SetCamDistanceScale(0.85)
			DarkmoonPlayerModel:SetPosition(-1, 0, -0.1)
			RPSCoreFramework.ChoosedScale = 11
		end
	end)
end

function RPSCoreFramework:EnableDrag(frame)
	frame:RegisterForDrag("LeftButton");
	frame:SetScript("OnDragStart", frame.StartMoving);
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
end

function RPSCoreFramework:OnInitialize()
	LoggingChat(1)
	SetCVar("autoClearAFK", 0)
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("PLAYER_MONEY");
	self.isTypingMessage = false
	
	for index = 1, NUM_CHAT_WINDOWS do
		local editbox = _G["ChatFrame" .. index .. "EditBox"]
		self:HookScript(editbox, "OnTextChanged",   "UpdateTypingStatus")
		self:HookScript(editbox, "OnEscapePressed", "UpdateTypingStatus")
		self:HookScript(editbox, "OnEnterPressed",  "UpdateTypingStatus")
		self:HookScript(editbox, "OnHide",          "UpdateTypingStatus")
	end
	
	self:HookScript(self, "OnEvent", "OnEventFrame")	
	self:HookScript(GameTooltip, "OnTooltipSetItem", "ItemTooltip")
	self:HookScript(ItemRefTooltip, "OnTooltipSetItem", "ItemTooltip")
	self:HookScript(ItemRefShoppingTooltip1, "OnTooltipSetItem", "ItemTooltip")
	self:HookScript(ItemRefShoppingTooltip2, "OnTooltipSetItem", "ItemTooltip")
	self:HookScript(ShoppingTooltip1, "OnTooltipSetItem", "ItemTooltip")
	self:HookScript(ShoppingTooltip2, "OnTooltipSetItem", "ItemTooltip")

	--RPS_CharScaleSlider:HookScript("OnMouseUp", function() StaticPopup_Show("setCharacterScale") end)
	RPS_BTNReScale:HookScript("OnMouseUp", function() if RPS_BTNReScale:IsEnabled() then StaticPopup_Show("setCharacterReScale") end end)
	RPS_BTNAcceptScale:HookScript("OnMouseUp", function() if RPS_BTNAcceptScale:IsEnabled() then StaticPopup_Show("setCharacterScale") end end)
	--RPS_BTNResetScale:HookScript("", handler)

	-- Mainframe misc settings		
	--tinsert(UISpecialFrames, RPS_MainFrame);
	RPSCoreFramework:EnableDrag(RPS_MainFrame);
	RPSCoreFramework:EnableDrag(RPS_InteractFrame);
	RPS_MainFrame.Close:SetScript("OnClick", function() switchMainFrame() end);

	-- Paperdoll disp menu

	RPSCoreFramework:HookScript(_G["CharacterHeadSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "head"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_HEAD)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterShoulderSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "shoulder";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_SHOULDER)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterBackSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "back";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_BACK)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterChestSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "chest";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_CHEST)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterShirtSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "shirt";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_BODY)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterTabardSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "tabard";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_TABARD)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterWristSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "wrist";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_WRIST)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterHandsSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "hands";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_HAND)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterWaistSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "waist";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_WAIST)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterLegsSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "legs";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_LEGS)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterFeetSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "feet";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_FEET)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterMainHandSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "mainhand"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_MAINHAND)
	 end end)
	RPSCoreFramework:HookScript(_G["CharacterSecondaryHandSlot"], "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "offhand"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_OFFHAND)
	 end end)

	-- Disp & Scale

	self:SendCoreMessage(".disp list");
	self:SendCoreMessage(".rps action aura list known");
	self:SendCoreMessage(".rps action aura list active");
	self:SendCoreMessage(".rps action scale info");

	-- Minimap icon
	
	LDBObject = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("RPSCoreFramework", {
		type = "data source",
		icon = "Interface\\AddOns\\RPSDarkmoon\\resources\\darkmoon.tga",
		tocname = "rpscoreframework",
		OnClick = function(_, button)
			switchMainFrame();
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("|cffCD661DDarkmoon|r");
			--tooltip:AddLine("|cffFFC125Ролевая система|r");
			tooltip:AddLine("|cffffcc00ПКМ\\ЛКМ: |cffFFC125открыть\\закрыть меню Darkmoon|r");
		end,
	})

	if (RPSCoreIconData == nil) then
		RPSCoreIconData = { hide = false }	
	end

	icon = LibStub("LibDBIcon-1.0");
	icon:Register("RPSDarkmoonIcon", LDBObject, RPSCoreIconData);
	icon:Show("RPSDarkmoonIcon");
	
	-- Text
	AFK = "Вне роли";
	CHAT_AFK_GET = "%s <Вне роли>:\32";
	CLEAR_AFK = "Автоматическая отмена режима \"Вне роли\"";
	OPTION_TOOLTIP_CLEAR_AFK = "Автоматический выход из режима \"Вне роли\"\nпри движении персонажа или начале разговора.";
	CLEARED_AFK = "Вы вышли из режима \"Вне роли\".";
	MARKED_AFK = "Вы находитесь вне роли.";
	MARKED_AFK_MESSAGE = "Вы вне роли, оставив сообщение: \"%s\".";
	CHAT_FLAG_AFK = "<Вне роли>";
	CHAT_MSG_AFK = "Вне роли";
	DEFAULT_AFK_MESSAGE = "Вне роли";	
	GM_EMAIL_NAME  = "Darkmoon";
	FRIENDS_LIST_AWAY = "Вне роли";
	
	-- Stats

	RPSCoreFramework:UpdateDiff()
	StrengthStatName:SetText("Сила")
	AgilityStatName:SetText("Ловкость")
	IntellectStatName:SetText("Интеллект")
	CriticalChanceStatName:SetText("Критический шанс")
	SpiritStatName:SetText("Дух")
	EnduranceStatName:SetText("Стойкость")
	DexterityStatName:SetText("Сноровка")
	WillStatName:SetText("Воля")
	DarkmoonCharStatsInfoUnlearn:SetText("Разучить "..GetCoinTextureString(RPSCoreFramework.RequestUnlearn))
	
	ITEM_MOD_MANA = "%c%s к духу";
	ITEM_MOD_MANA_SHORT = "к духу";
	
	ITEM_MOD_CRIT_RATING = "Показатель критического шанса +%s.";
	ITEM_MOD_CRIT_RATING_SHORT = "к критическому шансу";

	DarkmoonCharStatsInfoReset:Disable();
	DarkmoonCharStatsInfoSubmit:Disable();
	DarkmoonCharStatsInfoUnlearn:Disable();
	
	DarkmoonCharStatsInfoReset:SetScript("OnClick", function() RPSCoreFramework:ResetDiff() end);	
	DarkmoonCharStatsInfoSubmit:SetScript("OnClick", function() StaticPopup_Show("LearnStats") end);	
	DarkmoonCharStatsInfoUnlearn:SetScript("OnClick", function() StaticPopup_Show("UnlearnStats") end);
	
	RPS_InteractFrameHelp:SetScript("OnClick", function() self:SendCoreMessage(".rps action help %t") end);
	RPS_InteractFrameKill:SetScript("OnClick", function() self:SendCoreMessage(".rps action kill %t") end);
	
	StrengthMinus:SetScript("OnClick", function() RPSCoreFramework:DecStrength() end);
	AgilityMinus:SetScript("OnClick", function() RPSCoreFramework:DecAgility() end);
	IntellectMinus:SetScript("OnClick", function() RPSCoreFramework:DecIntellect() end);
	SpiritMinus:SetScript("OnClick", function() RPSCoreFramework:DecSpirit() end);
	CriticalChanceMinus:SetScript("OnClick", function() RPSCoreFramework:DecCriticalChance() end);
	EnduranceMinus:SetScript("OnClick", function() RPSCoreFramework:DecEndurance() end);
	DexterityMinus:SetScript("OnClick", function() RPSCoreFramework:DecDexterity() end);
	WillMinus:SetScript("OnClick", function() RPSCoreFramework:DecWill() end);
		
	StrengthPlus:SetScript("OnClick", function() RPSCoreFramework:IncStrength() end);
	AgilityPlus:SetScript("OnClick", function() RPSCoreFramework:IncAgility() end);
	IntellectPlus:SetScript("OnClick", function() RPSCoreFramework:IncIntellect() end);
	CriticalChancePlus:SetScript("OnClick", function() RPSCoreFramework:IncCriticalChance() end);
	SpiritPlus:SetScript("OnClick", function() RPSCoreFramework:IncSpirit() end);
	EndurancePlus:SetScript("OnClick", function() RPSCoreFramework:IncEndurance() end);
	DexterityPlus:SetScript("OnClick", function() RPSCoreFramework:IncDexterity() end);
	WillPlus:SetScript("OnClick", function() RPSCoreFramework:IncWill() end);
	
	StrengthIcon:SetTexture("Interface\\ICONS\\achievement_bg_most_damage_killingblow_dieleast")
    AgilityIcon:SetTexture("Interface\\ICONS\\ability_rogue_quickrecovery")
    IntellectIcon:SetTexture("Interface\\ICONS\\spell_shadow_brainwash")
	CriticalChanceIcon:SetTexture("Interface\\ICONS\\spell_impending_victory");
    SpiritIcon:SetTexture("Interface\\ICONS\\spell_holy_divinespirit")
    EnduranceIcon:SetTexture("Interface\\ICONS\\ability_warrior_intensifyrage")
    DexterityIcon:SetTexture("Interface\\ICONS\\ability_rogue_cheatdeath")
    WillIcon:SetTexture("Interface\\ICONS\\ability_shaman_astralshift")

	-- RPSLiterature.lua text formatting

	
	RPS_DarkmoonInfoFrameContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DarkmoonInfoFrameContent:SetFontObject("p", GameFontNormal);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_DarkmoonInfoFrameContent:SetText(RPSCoreFramework.Literature.DarkmoonInfo);

	RPS_DashboardBottomContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DashboardBottomContent:SetFontObject("p", GameFontNormal);
	RPS_DashboardBottomContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DashboardBottomContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DashboardBottomContent:SetFontObject("h3", GameFontNormalLarge);

	
	RPS_RulesScrollContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_RulesScrollContent:SetFontObject("p", GameFontNormal);
	RPS_RulesScrollContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_RulesScrollContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_RulesScrollContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_RulesScrollContent:SetText(RPSCoreFramework.Literature.DarkmoonRules);

	
	RPS_DarkmoonDispFrameContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DarkmoonDispFrameContent:SetFontObject("p", GameFontNormal);
	RPS_DarkmoonDispFrameContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DarkmoonDispFrameContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DarkmoonDispFrameContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_DarkmoonDispFrameContent:SetText(RPSCoreFramework.Literature.DarkmoonDispDesc);


	RPS_DarkmoonBARBERSHOPBUTTONText:SetFont('Fonts\FRIZQT___CYR.TTF', 12);
	RPS_DarkmoonBARBERSHOPBUTTONText:SetFontObject("p", GameFontNormal);
	RPS_DarkmoonBARBERSHOPBUTTONText:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DarkmoonBARBERSHOPBUTTONText:SetFontObject("h2", GameFontNormalHuge);
	RPS_DarkmoonBARBERSHOPBUTTONText:SetFontObject("h3", GameFontNormalLarge);
	RPS_DarkmoonBARBERSHOPBUTTONText:SetText(RPSCoreFramework.Literature.DarkmoonSettingsBarbershop);
	


	-- Button extensions

	RPS_DarkmoonInfo:LockHighlight() -- Starting page
    RPS_CHRBTN1:LockHighlight()
    RPS_CHRBTN2:UnlockHighlight()

	RPSCoreFramework:OnClickCosmeticTabs(RPS_FSBTN1);
	RPS_DashboardBottomContent:SetText(RPSCoreFramework.Literature.CharacterForce);

	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_DarkmoonInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_RulesInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_BattleSystemInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_StatsInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_ScaleInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_AurasInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedButtons, RPS_DisplayInfo)
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN1)
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN2)
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN3)
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN4)
	

	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonInfoFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonRulesFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonFightSystemFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonCharStatsFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonCharacterFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonAurasFrame)
	table.insert(RPSCoreFramework.Interface.HidingFrames, DarkmoonDisplayInfoFrame)
	
	RPSCoreFramework:GenerateCharScaleSlider()
	RPSCoreFramework:GenerateClassBackground()
	RPSCoreFramework:UpdateScaleReset()

	-- Popup's

	StaticPopupDialogs["UnlearnStats"] = {
		text = "Вы действительно желаете разучить все ваши характеристики? Стоимость: 5 |cff00ff00|TInterface\\MoneyFrame\\UI-GoldIcon:16|t|r",
		button1 = YES,
		button2 = NO,
		OnAccept = function() self:SendCoreMessage(".rps stat reset"); end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		StartDelay = function() return 1; end,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}

	StaticPopupDialogs["LearnStats"] = {
		text = "Вы действительно желаете изучить выбранные характеристики?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SubmitDiff() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		StartDelay = function() return 1; end,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}

	StaticPopupDialogs["setCharacterReScale"] = {
		text = "Вы действительно желаете сбросить рост?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() self:SendCoreMessage(".rps action scale reset");	RPS_BTNAcceptScale:Enable();	RPS_CharScaleSlider:Enable() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		StartDelay = function() return 1; end,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}

	StaticPopupDialogs["setCharacterScale"] = {
		text = "Вы действительно уверены в выбранном росте?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() self:SendCoreMessage(".rps action scale apply "..RPSCoreFramework.ChoosedScale);	RPS_BTNAcceptScale:Disable();	RPS_CharScaleSlider:Disable() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		StartDelay = function() return 1; end,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}

	StaticPopupDialogs["MakeMacros"] = {
	    text = "Выберите имя для макроса",
	    button1 = "Применить",
	    button2 = "Выйти",
	    OnShow = function (self, data)

	    end,
	    OnAccept = function (self, data, data2)
	        CreateMacro(self.editBox:GetText(), "INV_DARKMOON_VENGEANCE", RPS_TextMacrosScrollText:GetText(), 1);
	        PickupMacro(tostring(self.editBox:GetText()));
	    end,
	    OnCancel = function (_,reason)
	--      Nope
	    end,
	    hasEditBox = true,
	    timeout = 15,
	    whileDead = true,
	    hideOnEscape = true,
	}
end

function RPSCoreFramework:OnEnable()
	self:ScheduleTimer("OneShotUpdater", 5)
	self:ScheduleTimer("UpdateScrollerPosition", 7)
	self:ScheduleRepeatingTimer("PeriodicallyScrollMenuUpdater", 5)
	self:ScheduleRepeatingTimer("PeriodicallyUpdater", 10)
	if (not RPSCoreShouldFirstTime) then
		switchMainFrame();
		RPSCoreShouldFirstTime = true;
	end
end

function RPSCoreFramework:RemoveDisplay(slotname)
	local removeDispSlot
	local menuTitle = "Вы действительно хотите убрать дисп?"
	for v,h in pairs(RPSCoreFramework.SlotnameListPresets) do
		if v == slotname then
			removeDispSlot = h .. "0"
			break
		end
	end

	for v,h in pairs(RPSCoreFramework.SlotnameListNames) do
		if v == slotname then
			menuTitle = "Вы действительно хотите убрать дисп для " .. h .. "?"
			break
		end
	end

	StaticPopupDialogs["removeDisp"] = {
		text = menuTitle,
		button1 = YES,
		button2 = NO,
		OnAccept = function() self:SendCoreMessage(removeDispSlot) end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}
	StaticPopup_Hide("DipsSlotEditMenu")
	StaticPopup_Hide("removeDisp")
	StaticPopup_Show("removeDisp")
end

function RPSCoreFramework:ShowDisplayInfo(slotname)
	local displayMessage
	local menuTitle = "Введите ID предмета для выбранного слота."
	for v,h in pairs(RPSCoreFramework.SlotnameListPresets) do
		if v == slotname then
			displayMessage = h
			break
		end
	end

	for v,h in pairs(RPSCoreFramework.SlotnameListNames) do
		if v == slotname then
			menuTitle = "Введите ID предмета для " .. h .. "."
			break
		end
	end

	StaticPopupDialogs["DipsSlotEditMenu"] = {
		text = menuTitle,
		button1 = "Применить",
		button2 = "Выйти",
		OnShow = function (self, data)

		end,
		OnAccept = function (self, data, data2)
			displayMessage = displayMessage .. self.editBox:GetText();
			self:SendCoreMessage(displayMessage);
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
	  	timeout = 15,
	  	whileDead = true,
	  	hideOnEscape = true,
	}
	StaticPopup_Hide("removeDisp")
	StaticPopup_Hide("DipsSlotEditMenu")
	StaticPopup_Show("DipsSlotEditMenu")
end

function RPSCoreFramework:PeriodicallyUpdater()
	self:SendCoreMessage(".rps action scale info");
	self:SendCoreMessage(".rps action aura list active");
	RPSCoreFramework:UpdateScaleReset();

	-- Action Camera
    if RPSCoreActionCam then
        RPSCoreActionCam = true
        SetCVar("test_cameraDynamicPitch", 1);
        SetCVar("test_cameraOverShoulder", 1);
    else
        RPSCoreActionCam = false
        SetCVar("test_cameraDynamicPitch", 0);
        SetCVar("test_cameraOverShoulder", 0);
    end
end

function RPSCoreFramework:EnableDrag(frame)
	frame:RegisterForDrag("LeftButton");
	frame:SetScript("OnDragStart", frame.StartMoving);
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
end

function sysMsg(self, event, msg, author, ...)
	if (string.find(msg, "RPS.StatMe")) then
		RPSCoreFramework:UpdateInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.Scale")) then
		RPSCoreFramework:UpdateScaleInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.AuraKnown")) then
		RPSCoreFramework:UpdateAuraKnownInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.AuraActive")) then
		RPSCoreFramework:UpdateAuraActiveInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.Display")) then
		RPSCoreFramework:UpdateDisplayMacrosInfo(msg);
		return true;
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", sysMsg)

function RPSCoreFramework:OnEventFrame(self, event, ...)
	if (event == "PLAYER_TARGET_CHANGED") then
		self.TimerID = self:ScheduleRepeatingTimer("AuraCheckTimer", 0.5)
		self:UpdatePlayerModel();
		self:UpdateInteractionFrame();
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_EQUIPMENT_CHANGED") then
		self:SendCoreMessage(".rps stat self");
	elseif (event == "PLAYER_MONEY") then
		self:UpdateUnlearn();
	end
end
