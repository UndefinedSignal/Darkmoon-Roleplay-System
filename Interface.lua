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
    PickupItem(1000207);
    ClearCursor();
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