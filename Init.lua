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
--	RPSCoreFramework:BadAddonProtection()
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
	RPS_MainFrame.Close:SetScript("OnClick", function() RPSCoreFramework:switchMainFrame() end);

	RPSCoreFramework:PaperdollDispInit()
	RPSCoreFramework:AddMinimapIcon()
	RPSCoreFramework:ChangeDefaultWords()

	-- Disp & Scale

	RPSCoreFramework:SendCoreMessage(".disp list")
	RPSCoreFramework:SendCoreMessage(".rps action aura list known")
	RPSCoreFramework:SendCoreMessage(".rps action aura list active")
	RPSCoreFramework:SendCoreMessage(".rps action scale info")

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
	
	RPS_InteractFrameHelp:SetScript("OnClick", function()	local msg = ".rps action help "..GetUnitName("target")	RPSCoreFramework:SendCoreMessage(msg) end);
	RPS_InteractFrameKill:SetScript("OnClick", function()	local msg = ".rps action kill "..GetUnitName("target")	RPSCoreFramework:SendCoreMessage(msg) end);
	
	RPSCoreFramework:StatsIncDecFunc()
	
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
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps stat reset"); end,
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
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action scale reset");	RPS_BTNAcceptScale:Enable();	RPS_CharScaleSlider:Enable() end,
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
		OnAccept = function() RPSCoreFramework:SendCoreMessage(".rps action scale apply "..RPSCoreFramework.ChoosedScale);	RPS_BTNAcceptScale:Disable();	RPS_CharScaleSlider:Disable() end,
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

	RPSCoreFramework.Map.PinButtons = {
		{"Tavern", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\inn", 0.504987, 0.903770, 301},
		{"House 1", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.742743, 0.579597, 301},
		{"House 2", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.626656, 0.447683, 301},
		{"House 3", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.556268, 0.403740, 301},
		{"House 4", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.577851, 0.495251, 301},
		{"Tavern 2", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\house", 0.751721, 0.543597, 301}
}

end