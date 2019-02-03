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
	if RPSCoreFramework.Interface.Auras[arg][5] > 0 then
		return true
	end
	return false
end

function RPSCoreFramework:isAuraActive(arg)
	if RPSCoreFramework.Interface.Auras[arg][6] > 0 then
		return true
	end
	return false
end

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

function RPSCoreFramework:ChangePassword(Oldpas, Newpas, NewpasRep)

	StaticPopupDialogs["ChangePassword"] = {
		text = "Вы действительно хотите изменить пароль?",
		button1 = "Да",
		button2 = "Нет",
		OnAccept = function (self)
				local msg = ".bnetaccount password "..Oldpas.." "..Newpas.." "..NewpasRep;
				SendChatMessage(msg, "WHISPER", "Common", GetUnitName("player"));
				RPS_TextOldPass:SetText("|cffFFFF00Старый пароль|r");
				RPS_TextNewPass:SetText("|cffFFFF00Новый пароль|r");
				RPS_TextOldPassRepeate:SetText("|cffFFFF00Повтор пароля|r");
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

	if Oldpas == '' or Newpas == '' or NewpasRep == '' then
		message("\nЗаполнены не все поля")
		if Oldpas == '' then -- Красный цвет, что-то пошло не так
			RPS_TextOldPass:SetText("|cffFF8040Старый пароль|r");
		end
		if Newpas == '' then
			RPS_TextNewPass:SetText("|cffFF8040Новый пароль|r");
		end
		if NewpasRep == '' then
			RPS_TextOldPassRepeate:SetText("|cffFF8040Повтор пароля|r");
		end
		return false;
	end
	if Oldpas == Newpas then
		message("\nНовый пароль не должен совпадать с старым");
		RPS_TextOldPass:SetText("|cffFF8040Старый пароль|r");
		RPS_TextNewPass:SetText("|cffFF8040Новый пароль|r");
		RPS_TextOldPassRepeate:SetText("|cffFFFF00Повтор пароля|r");
		return false;
	end
	if Newpas ~= NewpasRep then
		message("\nПароли не совпадают");
		RPS_TextNewPass:SetText("|cffFF8040Новый пароль|r");
		RPS_TextOldPassRepeate:SetText("|cffFF8040Повтор пароля|r");
		RPS_TextOldPass:SetText("|cffFFFF00Старый пароль|r");
		return false;
	end

	RPS_TextOldPass:SetText("|cff85FF85Старый пароль|r");
	RPS_TextNewPass:SetText("|cff85FF85Новый пароль|r");
	RPS_TextOldPassRepeate:SetText("|cff85FF85Повтор пароля|r");
	StaticPopup_Show("ChangePassword");
	return true;
end

function RPSCoreFramework:FormatDMButtons(button)
	local shift = 0;
	local y = -60;
	for i=1, #RPSCoreFramework.Interface.MenuButtons do
		if i == 1 then 
			_G[RPSCoreFramework.Interface.MenuButtons[i][2]]:SetPoint("TOPLEFT", RPS_MainFrameMenuScroll, 16, -60);
		else
			y = -25 + shift;
			if RPSCoreFramework.Interface.MenuButtons[i][6] then
				_G[RPSCoreFramework.Interface.MenuButtons[i][2]]:SetPoint("BOTTOMLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i-1][2]], 0, y - 20);
			else
				_G[RPSCoreFramework.Interface.MenuButtons[i][2]]:SetPoint("BOTTOMLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i-1][2]], 0, y);
			end
			shift = 0;
		end
		if RPSCoreFramework.Interface.MenuButtons[i][4] then
			if RPSCoreFramework.Interface.MenuButtons[i][2] == button then
				for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
					if RPSCoreFramework.Interface.SubMenuButtons[j][1] == RPSCoreFramework.Interface.MenuButtons[i][5] then
						if j==1 then
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i][2]], 25, y);
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:LockHighlight();
						else
							y = -25
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.SubMenuButtons[j-1][3]], 0, y);
						end
						_G[RPSCoreFramework.Interface.SubMenuButtons[j][3].."Label"]:SetText("|cffFFFFFF"..RPSCoreFramework.Interface.SubMenuButtons[j][2]);
						shift = shift - 25;
					end
					_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:Show();
				end
			else
				for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
					_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:Hide();
				end
			end
		end
	end
end

function RPSCoreFramework:PreGenerateDMButtons()
	local shift = 0;
	local y = -60;
	for i=1, #RPSCoreFramework.Interface.MenuButtons do
		local MenuButton = CreateFrame('Button', RPSCoreFramework.Interface.MenuButtons[i][2], RPS_MainFrame, "RPS_CategoryButton")
		if i == 1 then 
			MenuButton:SetPoint("TOPLEFT", RPS_MainFrameMenuScroll, 16, -60);
			MenuButton:LockHighlight();
		else
			y = -25 + shift;
			if RPSCoreFramework.Interface.MenuButtons[i][6] then
				MenuButton:SetPoint("BOTTOMLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i-1][2]], 0, y - 20);
			else
				MenuButton:SetPoint("BOTTOMLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i-1][2]], 0, y);
			end
			shift = 0;
		end
		MenuButton:SetSize(158, 24);
		-- If button have a submenu
		if RPSCoreFramework.Interface.MenuButtons[i][4] then
			for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
				if RPSCoreFramework.Interface.SubMenuButtons[j][1] == RPSCoreFramework.Interface.MenuButtons[i][5] then
					local SubMenuButton = CreateFrame('Button', RPSCoreFramework.Interface.SubMenuButtons[j][3], RPS_MainFrame, "RPS_CategoryButton");
					if j==1 then
						SubMenuButton:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i][2]], 25, y);
					else
						y = -25
						SubMenuButton:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.SubMenuButtons[j-1][3]], 0, y);
					end
					SubMenuButton:SetSize(130,24)
					_G[RPSCoreFramework.Interface.SubMenuButtons[j][3].."Label"]:SetText("|cffFFFFFF"..RPSCoreFramework.Interface.SubMenuButtons[j][2]);
					table.insert(RPSCoreFramework.Interface.HidingFrames, _G[RPSCoreFramework.Interface.SubMenuButtons[j][4]]);
					table.insert(RPSCoreFramework.Interface.HighlightedButtons, _G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]);
					SubMenuButton:SetScript('OnClick', function()
						RPSCoreFramework:OnClickCosmetic(_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]);
						RPSCoreFramework:OnClickFrameShowing(_G[RPSCoreFramework.Interface.SubMenuButtons[j][4]]);
					end)
					shift = shift - 25;
				end
			end
		end
		_G[RPSCoreFramework.Interface.MenuButtons[i][2].."Label"]:SetText(RPSCoreFramework.Interface.MenuButtons[i][1]);
		MenuButton:SetScript('OnClick', function()
			RPSCoreFramework:FormatDMButtons(RPSCoreFramework.Interface.MenuButtons[i][2]);
			if RPSCoreFramework.Interface.MenuButtons[i][4] then
				RPSCoreFramework:OnClickCosmetic(_G[RPSCoreFramework.Interface.SubMenuButtons[1][3]]);
				RPSCoreFramework:OnClickFrameShowing(_G[RPSCoreFramework.Interface.SubMenuButtons[1][4]]);
			else
				RPSCoreFramework:OnClickCosmetic(_G[RPSCoreFramework.Interface.MenuButtons[i][2]]);
				RPSCoreFramework:OnClickFrameShowing(_G[RPSCoreFramework.Interface.MenuButtons[i][3]]);
			end
		end)
		if RPSCoreFramework.Interface.MenuButtons[i][3] ~= nil then
			table.insert(RPSCoreFramework.Interface.HidingFrames, _G[RPSCoreFramework.Interface.MenuButtons[i][3]]);
			table.insert(RPSCoreFramework.Interface.HighlightedButtons, _G[RPSCoreFramework.Interface.MenuButtons[i][2]]);
		end
	end
end
