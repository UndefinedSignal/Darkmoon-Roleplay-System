function RPSCoreFramework:OnEnable()
	self:ScheduleTimer("OneShotUpdater", 5)
	self:ScheduleTimer("UpdateScrollerPosition", 7)
	self:ScheduleRepeatingTimer("PeriodicallyScrollMenuUpdater", 5)
	self:ScheduleRepeatingTimer("PeriodicallyUpdater", 10)
	if (not RPSCoreShouldFirstTime) then
		RPSCoreFramework:switchMainFrame();
		RPSCoreShouldFirstTime = true;
	end
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
	RPS_MainFrame.Close:SetScript("OnClick", function() RPSCoreFramework:switchMainFrame() end);

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

	SendAddonMessage(RPSCoreFramework.Prefix, ".disp list", "WHISPER", UnitName("player"))
	SendAddonMessage(RPSCoreFramework.Prefix, ".rps action aura list known", "WHISPER", UnitName("player"))
	SendAddonMessage(RPSCoreFramework.Prefix, ".rps action aura list active", "WHISPER", UnitName("player"))
	SendAddonMessage(RPSCoreFramework.Prefix, ".rps action scale info", "WHISPER", UnitName("player"))

	-- Minimap icon
	
	LDBObject = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("RPSCoreFramework", {
		type = "data source",
		icon = "Interface\\AddOns\\RPSDarkmoon\\resources\\darkmoon.tga",
		tocname = "rpscoreframework",
		OnClick = function(_, button)
			RPSCoreFramework:switchMainFrame();
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
	
	RPS_InteractFrameHelp:SetScript("OnClick", function() SendAddonMessage(RPSCoreFramework.Prefix, ".rps action help %t", "WHISPER", UnitName("player")) end);
	RPS_InteractFrameKill:SetScript("OnClick", function() SendAddonMessage(RPSCoreFramework.Prefix, ".rps action kill %t", "WHISPER", UnitName("player")) end);
	
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
		OnAccept = function() SendAddonMessage(RPSCoreFramework.Prefix, ".rps stat reset", "WHISPER", UnitName("player")); end,
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
		OnAccept = function() SendAddonMessage(RPSCoreFramework.Prefix, ".rps action scale reset", "WHISPER", UnitName("player"));	RPS_BTNAcceptScale:Enable();	RPS_CharScaleSlider:Enable() end,
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
		OnAccept = function() SendAddonMessage(RPSCoreFramework.Prefix, ".rps action scale apply "..RPSCoreFramework.ChoosedScale, "WHISPER", UnitName("player"));	RPS_BTNAcceptScale:Disable();	RPS_CharScaleSlider:Disable() end,
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