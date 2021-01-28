function RPSCoreFramework:switchMainFrame()
	if RPS_MainFrame:IsVisible() then
		RPS_MainFrame:Hide();
	else
		RPS_MainFrame:Show();
	end
end

function RPSCoreFramework:UpdateInteractionFrame()
	if (self:IsFallen() and CheckInteractDistance("target", 3) and not UnitIsUnit("player", "target") and not self:IsInteractCast() and not self:HasAura(RPSCoreFramework.WoundsAura)) then
		if (not RPS_InteractFrame:IsShown()) then
			RPSCoreFramework:UpdateInteractButtons()
			RPS_InteractFrame:Show();
		end
	else
		RPSCoreFramework:UpdateInteractButtons()
		RPS_InteractFrame:Hide();
	end
end

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

function RPSCoreFramework:HideEffectAuraButtons() -- TODO Rework it
	RPS_AuraButton1Completed:Hide()
	RPS_AuraButton2Completed:Hide()
	RPS_AuraButton3Completed:Hide()
	RPS_AuraButton4Completed:Hide()
	RPS_AuraButton5Completed:Hide()
	RPS_AuraButton6Completed:Hide()
end

function RPSCoreFramework:OnClickCosmetic(frame)
	PlaySound(624, "SFX")
	for i = 1, #RPSCoreFramework.Interface.HighlightedButtons do
		RPSCoreFramework.Interface.HighlightedButtons[i]:UnlockHighlight()
	end
	frame:LockHighlight()
end

function RPSCoreFramework:OnClickCosmeticTabs(frame)
	PlaySound(21968, "SFX")
	for i = 1, #RPSCoreFramework.Interface.HighlightedTabButtons do
		RPSCoreFramework.Interface.HighlightedTabButtons[i]:UnlockHighlight()
	end
	frame:LockHighlight()
end

function RPSCoreFramework:OnClickFrameShowing(frame)
	for i=1, #RPSCoreFramework.Interface.HidingFrames do
		RPSCoreFramework.Interface.HidingFrames[i]:Hide()
	end
	frame:Show()
end

function RPSCoreFramework:MenstrelOnShow(self)
	if (GetItemInfo(1000207) == nil) then
	    PickupItem(1000207);
	    ClearCursor();
	end
end

function RPSCoreFramework:MenstrelCoinOnEnter(self)
    GameTooltip:ClearLines();
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
    local __, itemLink = GetItemInfo(1000207);
    GameTooltip:SetHyperlink(itemLink);
    GameTooltip:Show();
end

function RPSCoreFramework:MenstrelCoinOnLeave(self)
	GameTooltip:Hide();
end

function RPSCoreFramework:MinstrelCheckLock()
	if (RPSCoreFramework.MinstrelStatus == 0) then
		DarkmoonMinstrelFrameBuy:Disable();
		DarkmoonMinstrelFrameBuy:SetText("Заблокировано");
	elseif (RPSCoreFramework.MinstrelStatus == 1) then
		DarkmoonMinstrelFrameBuy:Disable();
		DarkmoonMinstrelFrameBuy:SetText("Активировано");
	elseif (RPSCoreFramework.MinstrelStatus == 2) then
		DarkmoonMinstrelFrameBuy:Enable();
		DarkmoonMinstrelFrameBuy:SetText("Активировать");
	end
end

function RPSCoreFramework:RPS_TextMinstrelBuyOnClick(self)
	if (GetItemCount(1000207) ~= 0) then
		StaticPopup_Show("buyMinstrel");
	else
		message("Недостаточно предметов для активации Менестрели");
	end
end

function RPSCoreFramework:PickupBattleSpell(name, button)
	if (button == "LeftButton") then
		PickupSpell(RPSCoreFramework.DB["CharStatsSpellID"][name][1]);
	elseif (button == "RightButton") then
		PickupSpell(RPSCoreFramework.DB["CharStatsSpellID"][name][2]);
	end
end

function RPSCoreFramework:ShowBattleSpellGameTooltip(name)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
	GameTooltip:SetHyperlink(GetSpellLink(RPSCoreFramework.DB["CharStatsSpellID"][name][1]));
	GameTooltip:AddLine(" ")
	--GameTooltip:AddDoubleLine(" ", "Клик ЛКМ: Взять боевой спелл\nКлик ПКМ: Взять ролевой спелл", 1, 0, 0, 1.0, 0.82, 0.0);
	GameTooltip:AddLine("ЛКМ: Выбрать боевую способность\nПКМ: Выбрать ролевую способность")
	GameTooltip:Show();
end

function RPSCoreFramework:GOB_OnMouseWheel(self, delta, maxZoom, minZoom)
	maxZoom = maxZoom or self.maxZoom;
	minZoom = minZoom or self.minZoom;
	local zoomLevel = self.zoomLevel or minZoom;
	zoomLevel = zoomLevel + delta * 0.01;
	zoomLevel = min(zoomLevel, maxZoom);
	zoomLevel = max(zoomLevel, minZoom);
	self:SetModelScale(zoomLevel);
	self.zoomLevel = zoomLevel;
end

function RPSCoreFramework:GOBModelSceneZoomIn()
	RPSCoreFramework:GOB_OnMouseWheel(GameObjectPreviewBorderModel, 10, 1, 0.1)
end

function RPSCoreFramework:GOBModelSceneZoomOut()
	RPSCoreFramework:GOB_OnMouseWheel(GameObjectPreviewBorderModel, -10, 1, 0.1)
end

function RPSCoreFramework:AddGuildSalaryTab()
	local TabName="Зарплата";
	 
	local TabID=GuildInfoFrame.numTabs+1;
	local Tab=CreateFrame("Button","$parentTab"..TabID,GuildInfoFrame,"GuildInfoSalaryTemplate",TabID);
	PanelTemplates_SetNumTabs(GuildInfoFrame,TabID);
	Tab:SetPoint("LEFT","$parentTab"..(TabID-1),"RIGHT",0,0);
	Tab:SetText(TabName);
	PanelTemplates_TabResize(GuildInfoFrameTab4, 0);

	local d,p,a,x,y = GuildInfoFrameTab1:GetPoint();
	GuildInfoFrameTab1:SetPoint(d,p,a,x-16,y);

	local Panel=CreateFrame("Frame",nil,GuildInfoFrame);
	Panel:SetAllPoints(GuildInfoFrame);
end

function RPSCoreFramework:GuildSalaryFrameLink()
	GuildInfoFrameTab1:Show();
	if(GuildInfoFrameTab3:IsShown()) then
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..3,"RIGHT",0,0);
	elseif(GuildInfoFrameTab2:IsShown()) then
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..2,"RIGHT",0,0);
	else
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..1,"RIGHT",0,0);
	end
end

-- DarkmoonCharacterFrameInfoTRBody
-- DarkmoonDisplayPresetFrameRightItemsHead

local sepModificator, buttonItemString;
local slots = {"Head","Shoulder","Back","Chest","Shirt","Tabard","Wrist","Hand","Waist","Legs","Feet","Mainhand","Secondaryhand"}
local dispSlots = {"Head","Shoulder","Back","Chest","Shirt","Tabard","Wrist","Hand","Waist","Legs","Feet","Mainhand","Offhand"}
local slotsID = {1,3,15,5,4,19,9,10,6,7,8,16,17};

function RPSCoreFramework:InitializeDispButtons()
	local number, name, description;
	local mainframe = _G["DarkmoonDisplayPresetFrameMenuSliderBody"];
	for i = 1, #RPSDispTable do
        local button = CreateFrame("Button", "DarkmoonDispButton"..i, mainframe, "CharDispButton");
        if i == 1 then
        	button:SetPoint("TOPLEFT", mainframe, 6, 0);
    	else
    		button:SetPoint("BOTTOM", _G["DarkmoonDispButton"..i-1], 0, -40);
    	end
    	button.IDLabel:SetText(i);
    	button.TitleLabel:SetText(RPSDispTable[i][2]);
    	button.DescriptionLabel:SetText(RPSDispTable[i][3]);
    	button.Mod:SetAtlas(RPSDispTableColors[math.random(#RPSDispTableColors)]);
    	button.Title = RPSDispTable[i][2];
    	button.Description = RPSDispTable[i][3];
    	button.Items = RPSDispTable[i];
    	button:Show();
	end
end

function RPSCoreFramework:DispListAcceptDisp()
	local frame;
	for i=1, #slots do
		frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[i]];
		if frame.DispID == nil then frame.DispID = "0"; end
		SendChatMessage(".disp "..dispSlots[i].." "..frame.DispID);
	end
end

function RPSCoreFramework:DispSetItemTexture(slotID, itemID)
	local frame;
	local name, _, _, _, _, _, _, _, _, texture = GetItemInfo(itemID)
	if not slotID then return; end
	frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[tonumber(slotID)]];
	frame.Normal:SetTexture(nil);
	frame.Normal:SetMask(nil);
	frame.Normal:SetMask("Interface\\COMMON\\Indicator-Gray");
	frame.Normal:SetTexture(nil);
	frame.Normal:SetTexture(texture);
	frame.DispID = itemID;
	frame.TooltipItemID = itemID;
	frame.Normal:Show();
end

function RPSCoreFramework:DispSetClearItemTexture(self)
	self.Normal:SetTexture(nil);
	self.Normal:SetMask(nil);
	self.Normal:SetMask("Interface\\COMMON\\Indicator-Gray");
	self.Normal:SetTexture(nil);
	self.Normal:SetTexture("transmog-nav-slot-"..self.InvSlot);
	self.TooltipItemID = 0;
	self.Normal:Show();
end

function RPSCoreFramework:DispSetClearAllItemTextures()
	local frame;
	for i=1, #slots do
		frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[i]];
		frame.Normal:SetTexture(nil);
		frame.Normal:SetMask(nil);
		frame.Normal:SetMask("Interface\\COMMON\\Indicator-Gray");
		frame.Normal:SetTexture(nil);
		frame.Normal:SetTexture("transmog-nav-slot-"..frame.InvSlot);
		frame.TooltipItemID = 0;
		frame.Normal:Show();
	end
end

function RPSCoreFramework:DispRemoveItemTexture(slotID, clearAll)
	local frame;
	if not slotID then return; end
	if not clearAll then
		frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[slotID]];
		frame.Normal:SetTexture(nil);
		frame.Normal:Hide();
	else
		for i = 1, 13 do
			frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[i]];
			frame.Normal:SetTexture(nil);
			frame.Normal:Hide();
		end
	end
end

function RPSCoreFramework:ClearDispModel(slotID)
	if slotID == nil then return; end
	if slotID == 0 then
		DarkmoonDisplayPresetFrameRightModel:Undress();
	else
		DarkmoonDisplayPresetFrameRightModel:UndressSlot(slotID);
	end
end

function RPSCoreFramework:DressUpDispModel(itemID)
	if RPSCoreFramework.DressUpOnLoad then
		RPSCoreFramework:ClearDispModel(0);
		RPSCoreFramework.DressUpOnLoad = false;
	end
	local __, itemLink, itemRarity = GetItemInfo(itemID);
	-- itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
	-- itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
	-- isCraftingReagent = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink") 
	DarkmoonDisplayPresetFrameRightModel:TryOn(itemLink);
end

function RPSCoreFramework:ShowDispalyItemTooltip(self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	if self.TooltipItemID == nil or self.TooltipItemID == 0 then
		GameTooltip:AddLine("Пустой слот");
	else
		local __, itemLink = GetItemInfo(self.TooltipItemID)
		GameTooltip:SetHyperlink(itemLink)
	end
	GameTooltip:Show();
end

function RPSCoreFramework:CharacterInfoPOIBlock(duration)
	local frame = DarkmoonCharacterFrameInfoMainContent.BlockOnLoad
	frame.content.flash1Rotation:SetDuration(duration);
end

function RPSCoreFramework:ApplyTransmogSet(button)
	local sepModificator;
	local buttonItemID;
	DarkmoonDisplayPresetFrameRightTitle:SetText("["..button.Title.."]")
	for i = 4, 16 do
		if button.Items[i] == nil then button.Items[i] = 0 end;
		sepModificator = string.find(button.Items[i], ":") or 0;
		if sepModificator > 0 then
			buttonItemID = string.sub(button.Items[i], 1, sepModificator-1);
			RPSCoreFramework:DressUpDispModel(buttonItemID);
		else
			buttonItemID = button.Items[i];
			RPSCoreFramework:DressUpDispModel(button.Items[i]);
		end
		RPSCoreFramework:DispSetItemTexture(i-3, tonumber(buttonItemID));
	end
	SetCursor(nil);
end

function RPSCoreFramework:ApplyDispTimer()
	RPSCoreFramework:ApplyTransmogSet(RPSCoreFramework.DispButtonFrame);
end

function RPSCoreFramework:InitializeDisplayButtons()
	local frame;
	for i=1, #slots do
		frame = _G["DarkmoonDisplayPresetFrameRightItems"..slots[i]];
		frame.Normal:SetAtlas("transmog-nav-slot-"..frame.InvSlot);
		frame.Main:SetAtlas("transmog-nav-slot-"..frame.InvSlot);
		frame.TooltipItemID = 0;
	end
end

function RPSCoreFramework:ConfirmedAddonLoading()
	RPSCoreFramework:InitializeDisplayButtons();
	RPSCoreFramework:playAnimation(DarkmoonWIPFrame.fadeOut);
end

function RPSCoreFramework:DispInsertItemLink(itemID)
	local _, itemLink = GetItemInfo(itemID)
	ChatEdit_InsertLink(itemLink);
end

function RPSCoreFramework:CharacterEXPBarUpdate(int)
	int = tonumber(int);
	DarkmoonCharacterEXPFrameContentTopEXPProgress:SetValue(int);
	DarkmoonCharacterEXPFrameContentTopEXPProgress.CurrentPercent:SetText(tostring(int).."%");
	DarkmoonCharacterEXPFrameContentTopEXPProgress.PercentLeft:SetText("До следующего уровня: "..tonumber(100-int).."%");
end

function RPSCoreFramework:UpdateCharacterXPInfo()
	local level = UnitLevel("player");
	DarkmoonCharacterEXPFrameContentTop.lvlLabel:SetText(level .. " уровень");
	DarkmoonCharacterEXPFrameContentTop.rankLabel:SetText(tostring(RPSCoreFramework:GetCharStrengthLevel(level)));
	DarkmoonCharacterEXPFrameContentTop.descrLabel:SetText(tostring(RPSCoreFramework:GetChatStrengthDesc(level)));
end

function RPSCoreFramework:GetCharStrengthLevel(level)
	if (level >= 110) then
		return "Великий героический персонаж";
	elseif (level >= 90) then
		return "Героический персонаж";
	elseif (level >= 70) then
		return "Выдающийся персонаж";
	elseif (level >= 50) then
		return "Умелый персонаж";
	end
	return "Обычный персонаж";
end

function RPSCoreFramework:GetChatStrengthDesc(level)
	if (level >= 110) then
		return RPSCoreFramework.Literature.CharPowerDescr["5"];
	elseif (level >= 90) then
		return RPSCoreFramework.Literature.CharPowerDescr["4"];
	elseif (level >= 70) then
		return RPSCoreFramework.Literature.CharPowerDescr["3"];
	elseif (level >= 50) then
		return RPSCoreFramework.Literature.CharPowerDescr["2"];
	end
	return RPSCoreFramework.Literature.CharPowerDescr["1"];
end


