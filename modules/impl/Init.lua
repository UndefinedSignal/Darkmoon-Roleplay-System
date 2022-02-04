function RPSCoreFramework:OnEnable()
	self.TimerID = self:ScheduleRepeatingTimer("GlobalTimer", 1);
	self:ScheduleTimer("OneShotUpdater", 10);
	self:ScheduleTimer("UpdateScrollerPosition", 7);
	self:ScheduleTimer("ConfirmedAddonLoading", 10);
	self:ScheduleRepeatingTimer("PeriodicallyScrollMenuUpdater", 5);
	self:ScheduleRepeatingTimer("StartGarbageCollection", 3600);
	
	if (not RPSCharEntersFirstTime) then
		RPSCoreFramework:switchMainFrame();
		RPSCharEntersFirstTime = true;
	end
	
	self:AdvancedCharacterMessageCheck();
end

function RPSCoreFramework:OnInitialize()

	LoggingChat(1);
	SetCVar("autoClearAFK", 0);

	self.isTypingMessage = false
	
	table.insert(UISpecialFrames, QuizFrame);
	table.insert(UISpecialFrames, RPS_MainFrame);

	self:EnableDrag(RPS_MainFrame);
	self:EnableDrag(RPS_InteractFrame);
	self:EnableDrag(QuizFrame);
	self:EnableDrag(RPS_BBoard);

	self:InitializeHooks();

	self:PaperdollDispInit();
	self:AddMinimapIcon();
	self:ChangeDefaultWords();

	self:PreGenerateDMButtons();
	self:FormatDMButtons();

	self:GenerateCharScaleSlider();
	self:GenerateClassBackground();
	self:UpdateScaleReset();

	self:PreGenerateShowAuras();

	self:AddGuildSalaryTab();

	--RPSCoreFramework:AddGuildPOIInfo();

	-- Disp & Scale

	self:SendCoreMessage("disp list");
	self:SendCoreMessage("rps action aura list known");
	self:SendCoreMessage("rps action aura list active");
	self:SendCoreMessage("rps action scale info");

	-- Guild Frame
	if (GetGuildInfo("player") ~= "0") then
		self:SendCoreMessage("rps guild infosalary");
		self:UpdateGuildRanks();
	end

	RPSCoreFramework:DailyStatusUpdate(RPSDailyStreak);

	-- Guild goals

	--[[GuildInfoFrameInfoChallenge1:Hide();
	GuildInfoFrameInfoChallenge2:Hide();
	GuildInfoFrameInfoChallenge3:Hide();
	GuildInfoFrameInfoChallenge4:Hide();
	GuildInfoFrameInfoChallenge5:Hide();
	GuildInfoFrameInfoHeader1Label:SetText("Гильдейские точки интереса (POI)");]]--

	-- Stats

	self:UpdateDiff();
	StrengthStatName:SetText("Сила");
	AgilityStatName:SetText("Ловкость");
	IntellectStatName:SetText("Интеллект");
	CriticalChanceStatName:SetText("Критический шанс");
	SpiritStatName:SetText("Дух");
	EnduranceStatName:SetText("Стойкость");
	DexterityStatName:SetText("Сноровка");
	WillStatName:SetText("Воля");

	DarkmoonSocialStatsFrameStat1StatName:SetText("Харизма"); -- INV_BandofBrothers
	DarkmoonSocialStatsFrameStat2StatName:SetText("Лидерство"); -- Achievement_PVP_Legion08
	DarkmoonSocialStatsFrameStat3StatName:SetText("Дипломатия"); -- Achievement_Reputation_08
	DarkmoonSocialStatsFrameStat4StatName:SetText("Торговля"); -- TimelessCoin
	DarkmoonSocialStatsFrameStat5StatName:SetText("Устрашение"); -- Ability_Warrior_Revenge
	DarkmoonSocialStatsFrameStat6StatName:SetText("Эрудиция"); -- INV_Misc_ScrollRolled04
	DarkmoonSocialStatsFrameStat7StatName:SetText("Искусство"); -- Achievement_Faction_GoldenLotus
	DarkmoonSocialStatsFrameStat8StatName:SetText("Выживание"); -- Ability_Hunter_ImprovedTracking
	DarkmoonSocialStatsFrameStat9StatName:SetText("Внимательность"); -- Ability_Hunter_MarkedForDeath
	DarkmoonSocialStatsFrameStat10StatName:SetText("Реакция"); -- Ability_Hunter_MarkedShot
	DarkmoonSocialStatsFrameStat11StatName:SetText("Поиск"); -- TRADE_ARCHAEOLOGY
	DarkmoonSocialStatsFrameStat12StatName:SetText("Слух"); -- Ability_Hunter_BeastCall
	DarkmoonSocialStatsFrameStat13StatName:SetText("Скрытность"); -- Ability_Hunter_Camouflage
	DarkmoonSocialStatsFrameStat14StatName:SetText("Ловкость рук"); -- Ability_Hunter_BeastSoothe
	DarkmoonSocialStatsFrameStat15StatName:SetText("Верховая езда"); -- ACHIEVEMENT_GUILDPERK_MOUNTUP
	DarkmoonSocialStatsFrameStat16StatName:SetText("Удача"); -- Achievement_Boss_CThun


	DarkmoonCharStatsInfoUnlearn:SetText("Разучить "..GetCoinTextureString(RPSCoreFramework.RequestUnlearn));
	DarkmoonSocialStatsFrameUnlearn:SetText("Разучить "..GetCoinTextureString(RPSCoreFramework.RequestUnlearn));
	
	DarkmoonCharStatsInfoReset:Disable();
	DarkmoonCharStatsInfoSubmit:Disable();
	DarkmoonCharStatsInfoUnlearn:Disable();

	RPS_BTNReScale:Disable();
	RPS_BTNAcceptScale:Disable();

	self:StatsIncDecFunc();
	
	StrengthIcon:SetTexture("Interface\\ICONS\\achievement_bg_most_damage_killingblow_dieleast");
    AgilityIcon:SetTexture("Interface\\ICONS\\ability_rogue_quickrecovery");
    IntellectIcon:SetTexture("Interface\\ICONS\\spell_shadow_brainwash");
	CriticalChanceIcon:SetTexture("Interface\\ICONS\\spell_impending_victory");
    SpiritIcon:SetTexture("Interface\\ICONS\\spell_holy_divinespirit");
    EnduranceIcon:SetTexture("Interface\\ICONS\\ability_warrior_intensifyrage");
    DexterityIcon:SetTexture("Interface\\ICONS\\ability_rogue_cheatdeath");
    WillIcon:SetTexture("Interface\\ICONS\\ability_shaman_astralshift");

	DarkmoonSocialStatsFrameStat1Icon:SetTexture("Interface\\ICONS\\INV_BandofBrothers");
	DarkmoonSocialStatsFrameStat2Icon:SetTexture("Interface\\ICONS\\Achievement_PVP_Legion08");
	DarkmoonSocialStatsFrameStat3Icon:SetTexture("Interface\\ICONS\\Achievement_Reputation_08");
	DarkmoonSocialStatsFrameStat4Icon:SetTexture("Interface\\ICONS\\TimelessCoin");
	DarkmoonSocialStatsFrameStat5Icon:SetTexture("Interface\\ICONS\\Ability_Warrior_Revenge");
	DarkmoonSocialStatsFrameStat6Icon:SetTexture("Interface\\ICONS\\INV_Misc_ScrollRolled04");
	DarkmoonSocialStatsFrameStat7Icon:SetTexture("Interface\\ICONS\\Achievement_Faction_GoldenLotus");
	DarkmoonSocialStatsFrameStat8Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_ImprovedTracking");
	DarkmoonSocialStatsFrameStat9Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_MarkedForDeath");
	DarkmoonSocialStatsFrameStat10Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_MarkedShot");
	DarkmoonSocialStatsFrameStat11Icon:SetTexture("Interface\\ICONS\\TRADE_ARCHAEOLOGY");
	DarkmoonSocialStatsFrameStat12Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_BeastCall");
	DarkmoonSocialStatsFrameStat13Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_Camouflage");
	DarkmoonSocialStatsFrameStat14Icon:SetTexture("Interface\\ICONS\\Ability_Hunter_BeastSoothe");
	DarkmoonSocialStatsFrameStat15Icon:SetTexture("Interface\\ICONS\\ACHIEVEMENT_GUILDPERK_MOUNTUP");
	DarkmoonSocialStatsFrameStat16Icon:SetTexture("Interface\\ICONS\\Achievement_Boss_CThun");

	DarkmoonSocialStatsFrameStat1Minus:Disable();
	DarkmoonSocialStatsFrameStat1Plus:Disable();
	DarkmoonSocialStatsFrameStat2Minus:Disable();
	DarkmoonSocialStatsFrameStat2Plus:Disable();
	DarkmoonSocialStatsFrameStat3Minus:Disable();
	DarkmoonSocialStatsFrameStat3Plus:Disable();
	DarkmoonSocialStatsFrameStat4Minus:Disable();
	DarkmoonSocialStatsFrameStat4Plus:Disable();
	DarkmoonSocialStatsFrameStat5Minus:Disable();
	DarkmoonSocialStatsFrameStat5Plus:Disable();
	DarkmoonSocialStatsFrameStat6Minus:Disable();
	DarkmoonSocialStatsFrameStat6Plus:Disable();
	DarkmoonSocialStatsFrameStat7Minus:Disable();
	DarkmoonSocialStatsFrameStat7Plus:Disable();
	DarkmoonSocialStatsFrameStat8Minus:Disable();
	DarkmoonSocialStatsFrameStat8Plus:Disable();
	DarkmoonSocialStatsFrameStat9Minus:Disable();
	DarkmoonSocialStatsFrameStat9Plus:Disable();
	DarkmoonSocialStatsFrameStat10Minus:Disable();
	DarkmoonSocialStatsFrameStat10Plus:Disable();
	DarkmoonSocialStatsFrameStat11Minus:Disable();
	DarkmoonSocialStatsFrameStat11Plus:Disable();
	DarkmoonSocialStatsFrameStat12Minus:Disable();
	DarkmoonSocialStatsFrameStat12Plus:Disable();
	DarkmoonSocialStatsFrameStat13Minus:Disable();
	DarkmoonSocialStatsFrameStat13Plus:Disable();
	DarkmoonSocialStatsFrameStat14Minus:Disable();
	DarkmoonSocialStatsFrameStat14Plus:Disable();
	DarkmoonSocialStatsFrameStat15Minus:Disable();
	DarkmoonSocialStatsFrameStat15Plus:Disable();
	DarkmoonSocialStatsFrameStat16Minus:Disable();
	DarkmoonSocialStatsFrameStat16Plus:Disable();

	-- RPSLiterature.lua text formatting

	self:LiteratureTextFormatting();

	-- Button extensions

	--RPS_CharInfoLabel:SetText(UnitName("player"));
	self:OnClickCosmeticTabs(RPS_FSBTN1);
	RPS_DashboardBottomContent:SetText(RPSCoreFramework.Literature.CharacterForce);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN1);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN2);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN3);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN4);

	RPSCoreFramework:GeneratePOIPlaces();
	
--	RPSCoreFramework:TalentAlertMessageHide(); WIP

	RPSCoreFramework:InitializeEnchantButtons();

--	UIErrorsFrame:Hide();
--	UIErrorsFrame:ClearAllPoints();
--	UIErrorsFrame:SetPoint("TOP", UIParent, "BOTTOM", 0, -100);

--	WorldMapPOIFrame:Hide();
end

local function SetupLockOnDeclineButtonAndEscape(self, declineTimeLeft)
	self.declineTimeLeft = declineTimeLeft or .5;
	self.button2:SetButtonState("NORMAL", true);
	self.ticker = C_Timer.NewTicker(.5, function()
		self.declineTimeLeft = self.declineTimeLeft - .5;
		if (self.declineTimeLeft == 0) then
			self.ticker:Cancel();
			self.button2:SetButtonState("NORMAL", false);
			return;
		else
			self.button2:SetButtonState("NORMAL", true);
		end
	end);
	self.hideOnEscape = false;
end

StaticPopupDialogs["ActionHelp"] = {
	text = "Вы действительно желаете помочь выбранному персонажу?",
	button1 = YES,
	button2 = NO,
	button1Pulse = true,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("rps action help"); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
				self.button1:Enable();
				self.ticker:Cancel();
				return;
			else
				self.button1:SetText(self.declineTimeLeft);
			end
		end);
	end,
	timeout = 10,
	whileDead = true,
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["ActionKill"] = {
	text = "|cFFFF0000С выбором этого действия нить судьбы выбранного персонажа обрывается...|r\n\nВы действительно желаете добить выбранного персонажа?",
	button1 = YES,
	button2 = NO,
	button2Pulse = true,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("rps action kill"); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
				self.button1:Enable();
				self.ticker:Cancel();
				return;
			else
				self.button1:SetText(self.declineTimeLeft);
			end
		end);
	end,
	timeout = 10,
	whileDead = true,
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["ActionPillageLoot"] = {
	text = "Вы действительно желаете ограбить выбранного персонажа?",
	button1 = NO,
	button2 = "Ограбить",
	button3 = "Ограбить и избить",
	button1Pulse = true,
	OnAccept = function() end,
	OnCancel = function() RPSCoreFramework:SendCoreMessage("rps action loot"); end,
	OnAlt = function(self) RPSCoreFramework:SendCoreMessage("rps action pillage"); self:Hide(); end,
	OnShow = function(self)
		if (RPSCoreFramework:HasAura(RPSCoreFramework.LootedAura, "target")) then
			self.canloot = false;
			self.text:SetText("|cFFFFFF00ВНИМАНИЕ!|r\n\nПерсонаж уже ограблен и может быть только избит.\nВый действительно желаете избить выбранного персонажа?");
		else
			self.canloot = true;
		end
		self.declineTimeLeft = 3;			
		if (self.canloot) then
			self.button2:SetText(self.declineTimeLeft);
		end
		self.button3:SetText(self.declineTimeLeft);
		self.button1:Enable();
		self.button2:Disable();
		self.button3:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				if (self.canloot) then
					self.button2:SetText("Ограбить");
					self.button2:Enable();
					self.button3:SetText("Ограбить и избить");
				else
					self.button3:SetText("Избить");
					self.text:SetText("|cFFFFFF00ВНИМАНИЕ!|r\n\nПерсонаж уже ограблен и может быть только избит.\nВый действительно желаете избить выбранного персонажа?");
				end
				self.button3:Enable();
				self.ticker:Cancel();
				return;
			else
				if (self.canloot) then
					self.button2:SetText(self.declineTimeLeft);
				end
				self.button3:SetText(self.declineTimeLeft);
			end
		end);
	end,
	timeout = 10,
	whileDead = true,
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["UnlearnStats"] = {
	text = "Вы действительно желаете разучить все ваши характеристики? Стоимость: 5 |cff00ff00|TInterface\\MoneyFrame\\UI-GoldIcon:16|t|r",
	button1 = YES,
	button2 = NO,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("rps stat reset"); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
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
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["LearnStats"] = {
	text = "Вы действительно желаете изучить выбранные характеристики?",
	button1 = YES,
	button2 = NO,
	OnAccept = function() RPSCoreFramework:SubmitDiff(); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
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
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["setCharacterReScale"] = {
	text = "Вы действительно желаете сбросить рост?",
	button1 = YES,
	button2 = NO,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("rps action scale reset");	RPS_BTNAcceptScale:Enable();	RPS_CharScaleSlider:Enable();	RPS_CharScaleSlider:SetValue(6); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
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
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["setCharacterScale"] = {
	text = "Вы действительно уверены в выбранном росте?",
	button1 = YES,
	button2 = NO,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("rps action scale apply "..RPSCoreFramework.ChoosedScale);	RPS_BTNAcceptScale:Disable();	RPS_CharScaleSlider:Disable(); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES);
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
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["MakeMacros"] = {
	text = "Выберите имя для макроса",
	button1 = "Применить",
	button2 = "Выйти",
	OnShow = function (self, data)
		if (data) then
			self.editBox:SetText(data[1]);
		end
	end,
	OnAccept = function (self, data, data2)
		local id = CreateMacro(self.editBox:GetText(), data[2], data[3], data[4]);
		PickupMacro(id);
	end,
	OnCancel = function (_,reason)
--      Nope
	end,
	hasEditBox = true,
	timeout = 15,
	whileDead = true,
	hideOnEscape = true,
}

StaticPopupDialogs["AdvancedCharacterMessage"] = {
	text = "|cFFFFFF00ВНИМАНИЕ!|r\n%s",	
	button1 = OKAY,
	OnAccept = function() end,
	OnShow = function(self)
		self.declineTimeLeft = 15;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
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

StaticPopupDialogs["buyMinstrel"] = {
	text = "Вы действительно хотите активировать Менестрель?",
	button1 = YES,
	button2 = NO,
	OnAccept = function() RPSCoreFramework:SendCoreMessage("minstrel activate"); end,
	OnShow = function(self)
		self.declineTimeLeft = 3;
		self.button1:SetText(self.declineTimeLeft);
		self.button1:Disable();
		if self.ticker then
			self.ticker:Cancel();
		end
		self.ticker = C_Timer.NewTicker(1, function()
			self.declineTimeLeft = self.declineTimeLeft - 1;
			if (self.declineTimeLeft <= 0) then
				self.button1:SetText(YES)
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
	hideOnEscape = true,
	StartDelay = function() return 3; end,
	exclusive = true,
	showAlert = 1,
	preferredIndex = 3, 
}

StaticPopupDialogs["MINSTREL_SUMMON"] = {
	text = "Менестрель |cfffdeaa8%s|r призывает вас к себе в |cff7fc800%s|r.\n\n|cFFFF0000ВНИМАНИЕ! Телепортация является неролевой!|r";
	button1 = ACCEPT,
	button2 = CANCEL,
	OnShow = function(self)
		self.timeleft = 15;
		SetupLockOnDeclineButtonAndEscape(self);
	end,
	OnAccept = function(self)
		RPSCoreFramework:SendCoreMessage("minstrel summonresult");
	end,
	OnUpdate = function(self, elapsed)
		if (UnitAffectingCombat("player") or (not PlayerCanTeleport())
		or RPSCoreFramework:HasAura(RPSCoreFramework.DeathAura) 
		or RPSCoreFramework:HasAura(RPSCoreFramework.FightAura) 
		or RPSCoreFramework:HasAura(RPSCoreFramework.UnconsciousAura)) then
			self.button1:Disable();
		else
			self.button1:Enable();
		end
	end,
	timeout = 0,
	interruptCinematic = 1,
	notClosableByLogout = 1,
	showAlert = 1,
};
