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

function RPSCoreFramework:ChangePlayerPassword()
	local oldpass, newpass, newpassrep;

	StaticPopupDialogs["OldPassword"] = {
		text = "Введите старый пароль",
		button1 = "Продолжить",
		button2 = "Выйти",
		OnShow = function (self, data)

		end,
		OnAccept = function (self, data, data2)
			oldpass = self.editBox:GetText()
			StaticPopup_Hide("OldPassword")
			StaticPopup_Show("NewPassword")
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
--	  	timeout = 3,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}

	StaticPopupDialogs["NewPassword"] = {
		text = "Введите новый пароль",
		button1 = "Продолжить",
		button2 = "Выйти",
		OnShow = function (self, data)

		end,
		OnAccept = function (self, data, data2)
			newpass = self.editBox:GetText()
			if string.len(newpass) < 4 then
				message("\nПароль не может содержать менее 4 символов")
				return false
			end
			StaticPopup_Hide("NewPassword")
			StaticPopup_Show("NewPasswordRepeat")
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
--	  	timeout = 3,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}

	StaticPopupDialogs["NewPasswordRepeat"] = {
		text = "Повторите новый пароль",
		button1 = "Продолжить",
		button2 = "Выйти",
		OnShow = function (self, data)

		end,
		OnAccept = function (self, data, data2)
			newpassrep = self.editBox:GetText()
			StaticPopup_Hide("NewPasswordRepeat")
			
			if newpassrep ~= newpass then
				message("\nПароли не совпадают")
				return false
			end
			local msg = ".bnetaccount password "..oldpass.." "..newpass.." "..newpass
			SendChatMessage(msg, "WHISPER", "Common", GetUnitName("player"));
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
--	  	timeout = 3,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}

	StaticPopup_Show("OldPassword")
end