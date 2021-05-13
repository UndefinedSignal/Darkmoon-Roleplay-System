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
		if (statbonus == 80) then
			statbonus = "|cFFFFFF0080|r";
		elseif (statbonus>80) then
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
function RPSCoreFramework:UpdateFreeStat()
	local level = UnitLevel("player");
	if (level >= RPSCoreFramework.StatsLevel) then
		DarkmoonCharStatsInfoFreeStat:SetText(RPSCoreFramework.FreeStats);
		DarkmoonCharStatsInfoFreeStatText:SetText("Свободный опыт");
	else
		DarkmoonCharStatsInfoFreeStat:SetText("0");
		DarkmoonCharStatsInfoFreeStatText:SetText("|cFFFF0000Требуется "..RPSCoreFramework.StatsLevel.." уровень.|r");
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
		RPSCoreFramework:SendCoreMessage("rps stat submit strength "..self.StatsDiff.Strength);
	end
	if (self.StatsDiff.Agility>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit agility "..self.StatsDiff.Agility);
	end
	if (self.StatsDiff.Intellect>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit intellect "..self.StatsDiff.Intellect);
	end
	if (self.StatsDiff.CriticalChance>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit criticalchance "..self.StatsDiff.CriticalChance);
	end
	if (self.StatsDiff.Spirit>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit spirit "..self.StatsDiff.Spirit);
	end
	if (self.StatsDiff.Endurance>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit endurance "..self.StatsDiff.Endurance);
	end
	if (self.StatsDiff.Dexterity>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit dexterity "..self.StatsDiff.Dexterity);
	end
	if (self.StatsDiff.Will>0) then
		RPSCoreFramework:SendCoreMessage("rps stat submit will "..self.StatsDiff.Will);
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
	RPSCoreFramework:SendCoreMessage("rps stat self")
end
function RPSCoreFramework:StatsIncDecFunc()
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
end