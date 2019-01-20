function RPSCoreFramework:OnEnable()
	self:ScheduleTimer("OneShotUpdater", 5);
	self:ScheduleTimer("UpdateScrollerPosition", 7);
	self:ScheduleRepeatingTimer("PeriodicallyScrollMenuUpdater", 5);
--	self:ScheduleRepeatingTimer("PeriodicallyUpdater", 10)
	RPSCoreFramework:DifficultMessageSendToPlayer()
	if (not RPSCoreShouldFirstTime) then
		RPSCoreFramework:switchMainFrame();
		RPSCoreShouldFirstTime = true;
	end
	
end

function RPSCoreFramework:OnInitialize()
	LoggingChat(1);
	SetCVar("autoClearAFK", 0);

	self.isTypingMessage = false

	table.insert(UISpecialFrames, RPS_MainFrame);

	self:EnableDrag(RPS_MainFrame);
	self:EnableDrag(RPS_InteractFrame);

	self:InitializeHooks();

	self:PaperdollDispInit();
	self:AddMinimapIcon();
	self:ChangeDefaultWords();

	self:PreGenerateDMButtons();
	self:FormatDMButtons();

	self:GenerateCharScaleSlider();
	self:GenerateClassBackground();
	self:UpdateScaleReset();

	-- Disp & Scale

	self:SendCoreMessage(".disp list");
	self:SendCoreMessage(".rps action aura list known");
	self:SendCoreMessage(".rps action aura list active");
	self:SendCoreMessage(".rps action scale info");

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
	DarkmoonCharStatsInfoUnlearn:SetText("Разучить "..GetCoinTextureString(RPSCoreFramework.RequestUnlearn));
	
	ITEM_MOD_MANA = "%c%s к духу";
	ITEM_MOD_MANA_SHORT = "к духу";
	
	ITEM_MOD_CRIT_RATING = "Показатель критического шанса +%s.";
	ITEM_MOD_CRIT_RATING_SHORT = "к критическому шансу";

	DarkmoonCharStatsInfoReset:Disable();
	DarkmoonCharStatsInfoSubmit:Disable();
	DarkmoonCharStatsInfoUnlearn:Disable();

	self:StatsIncDecFunc();
	
	StrengthIcon:SetTexture("Interface\\ICONS\\achievement_bg_most_damage_killingblow_dieleast");
    AgilityIcon:SetTexture("Interface\\ICONS\\ability_rogue_quickrecovery");
    IntellectIcon:SetTexture("Interface\\ICONS\\spell_shadow_brainwash");
	CriticalChanceIcon:SetTexture("Interface\\ICONS\\spell_impending_victory");
    SpiritIcon:SetTexture("Interface\\ICONS\\spell_holy_divinespirit");
    EnduranceIcon:SetTexture("Interface\\ICONS\\ability_warrior_intensifyrage");
    DexterityIcon:SetTexture("Interface\\ICONS\\ability_rogue_cheatdeath");
    WillIcon:SetTexture("Interface\\ICONS\\ability_shaman_astralshift");

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

--	RPS_DarkmoonInfo:LockHighlight(); -- Starting page
    RPS_CHRBTN1:LockHighlight();
    RPS_CHRBTN2:UnlockHighlight();

	self:OnClickCosmeticTabs(RPS_FSBTN1);
	RPS_DashboardBottomContent:SetText(RPSCoreFramework.Literature.CharacterForce);

	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN1);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN2);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN3);
	table.insert(RPSCoreFramework.Interface.HighlightedTabButtons, RPS_FSBTN4);
	


	-- Popup's
	
	StaticPopupDialogs["ActionHelp"] = {
		text = "Вы действительно желаете помочь выбранному персонажу?",
		button1 = YES,
		button2 = NO,
		button1Pulse = true,
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action help"); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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
	StaticPopupDialogs["ActionKill"] = {
		text = "|cFFFF0000С выбором этого действия нить судьбы выбранного персонажа обрывается...|r\n\nВы действительно желаете добить выбранного персонажа?",
		button1 = YES,
		button2 = NO,
		button2Pulse = true,
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action kill"); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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
	StaticPopupDialogs["ActionPillageLoot"] = {
		text = "Вы действительно желаете ограбить выбранного персонажа?",
		button1 = NO,
		button2 = YES,
		button3 = YES,
		button1Pulse = true,
		OnAccept = function() print(1) end,
		OnCancel = function() RPSCoreFramework:SendCoreMessage(".rps action loot"); end,
		OnAlt = function(self) RPSCoreFramework:SendCoreMessage(".rps action pillage"); self:Hide(); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button2:SetText(self.declineTimeLeft);
			self.button2:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
					self.button2:SetText(YES)
					self.button2:Enable();
					self.ticker:Cancel();
					return;
				else
					self.button2:SetText(self.declineTimeLeft);
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
	StaticPopupDialogs["UnlearnStats"] = {
		text = "Вы действительно желаете разучить все ваши характеристики? Стоимость: 5 |cff00ff00|TInterface\\MoneyFrame\\UI-GoldIcon:16|t|r",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps stat reset"); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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

	StaticPopupDialogs["LearnStats"] = {
		text = "Вы действительно желаете изучить выбранные характеристики?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SubmitDiff(); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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

	StaticPopupDialogs["setCharacterReScale"] = {
		text = "Вы действительно желаете сбросить рост?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action scale reset");	RPS_BTNAcceptScale:Enable();	RPS_CharScaleSlider:Enable() end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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

	StaticPopupDialogs["setCharacterScale"] = {
		text = "Вы действительно уверены в выбранном росте?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action scale apply "..RPSCoreFramework.ChoosedScale);	RPS_BTNAcceptScale:Disable();	RPS_CharScaleSlider:Disable(); end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft == 0) then
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

	RPSCoreFramework.Map.PinButtons = {
		{"Tavern", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\inn", 0.504987, 0.903770, 301},
		{"House 1", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.742743, 0.579597, 301},
		{"House 2", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.626656, 0.447683, 301},
		{"House 3", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.556268, 0.403740, 301},
		{"House 4", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.577851, 0.495251, 301},
		{"Tavern 2", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.751721, 0.543597, 301}
	}
end