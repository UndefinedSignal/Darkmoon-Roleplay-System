local DropDownDisplayMenuFrame = CreateFrame("Frame", "DisplayMenuFrame", UIParent, "UIDropDownMenuTemplate")

function RPSCoreFramework:ShowDisplayDropDownMenu(inventorySlotId)
	if (GetInventoryItemID("player", inventorySlotId)) then
		EasyMenu(RPSCoreFramework.DropDownDisplayMenu, DropDownDisplayMenuFrame, "cursor", 5, -15, "MENU", 5);
	end
end

function RPSCoreFramework:PaperdollDispInit()
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
		OnAccept = function() RPSCoreFramework:SendCoreMessage(removeDispSlot) end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		enterClicksFirstButton = true,
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
			displayMessage = displayMessage .. self.editBox:GetText()
			RPSCoreFramework:SendCoreMessage(displayMessage)
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
	  	timeout = 15,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}
	StaticPopup_Hide("removeDisp")
	StaticPopup_Hide("DipsSlotEditMenu")
	StaticPopup_Show("DipsSlotEditMenu")
end

function RPSCoreFramework:KnownAura(arg)
	if RPSCoreFramework.Interface.Auras[arg][4] > 0 then
		return true
	end
	return false
end

function RPSCoreFramework:isAuraActive(arg)
	if RPSCoreFramework.Interface.Auras[arg][5] > 0 then
		return true
	end
	return false
end

--function RPSCoreFramework:BadAddonProtection()
--	DisableAddOn("RPSDarkmoon")
--	return true
--end

function RPSCoreFramework:AddMinimapIcon()
	LDBObject = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("RPSCoreFramework", {
		type = "data source",
		icon = "Interface\\AddOns\\RPSDarkmoon\\resources\\darkmoon.tga",
		tocname = "rpscoreframework",
		OnClick = function(_, button)
			RPSCoreFramework:switchMainFrame();
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("|cffCD661DDarkmoon|r");
			tooltip:AddLine("|cffffcc00ПКМ\\ЛКМ: |cffFFC125открыть\\закрыть меню Darkmoon|r");
		end,
	})

	if (RPSCoreIconData == nil) then
		RPSCoreIconData = { hide = false }	
	end

	icon = LibStub("LibDBIcon-1.0");
	icon:Register("RPSDarkmoonIcon", LDBObject, RPSCoreIconData);
	icon:Show("RPSDarkmoonIcon");
end