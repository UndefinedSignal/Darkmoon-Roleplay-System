function RPSCoreFramework:ShowDisplayDropDownMenu(inventorySlotId, weapon)
	if (GetInventoryItemID("player", inventorySlotId) and not weapon) then
		EasyMenu(RPSCoreFramework.DropDownDisplayMenu, RPSCoreFramework.DropDownDisplayMenuFrame, "cursor", 5, -15, "MENU", 5);
	elseif(GetInventoryItemID("player", inventorySlotId)) then
		EasyMenu(RPSCoreFramework.DropDownDisplayEnchantMenu, RPSCoreFramework.DropDownDisplayEnchantMenuFrame, "cursor", 5, -15, "MENU", 5);
	end
end

function RPSCoreFramework:ShowCharSpecChooseDropDownMenu()
	EasyMenu(RPSCoreFramework.DropDownCharSpecChooseMenu, RPSCoreFramework.DropDownClassChooseMenu, "DarkmoonDropSpecChooseButton", -110, 0, "MENU", 5);
end

function RPSCoreFramework:PaperdollDispInit()
	RPSCoreFramework:HookScript(CharacterHeadSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "head"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_HEAD)
	 end end)
	RPSCoreFramework:HookScript(CharacterShoulderSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "shoulder";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_SHOULDER)
	 end end)
	RPSCoreFramework:HookScript(CharacterBackSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "back";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_BACK)
	 end end)
	RPSCoreFramework:HookScript(CharacterChestSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "chest";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_CHEST)
	 end end)
	RPSCoreFramework:HookScript(CharacterShirtSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "shirt";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_BODY)
	 end end)
	RPSCoreFramework:HookScript(CharacterTabardSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "tabard";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_TABARD)
	 end end)
	RPSCoreFramework:HookScript(CharacterWristSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "wrist";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_WRIST)
	 end end)
	RPSCoreFramework:HookScript(CharacterHandsSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "hands";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_HAND)
	 end end)
	RPSCoreFramework:HookScript(CharacterWaistSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "waist";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_WAIST)
	 end end)
	RPSCoreFramework:HookScript(CharacterLegsSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "legs";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_LEGS)
	 end end)
	RPSCoreFramework:HookScript(CharacterFeetSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "feet";
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_FEET)
	 end end)
	RPSCoreFramework:HookScript(CharacterMainHandSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "mainhand"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_MAINHAND, true)
	 end end)
	RPSCoreFramework:HookScript(CharacterSecondaryHandSlot, "OnClick", function() if (GetMouseButtonClicked() == "RightButton") then RPSCoreFramework.GetLastClickedSlot = "offhand"
		RPSCoreFramework:ShowDisplayDropDownMenu(INVSLOT_OFFHAND, true)
	 end end)
end

function RPSCoreFramework:HideDialogPopup()
	StaticPopup_Hide("DispSlotEditMenu");
	StaticPopup_Hide("removeDisp");
	StaticPopup_Hide("removeWeaponEnchant");
	StaticPopup_Hide("EnchantOffHand");
	StaticPopup_Hide("EnchantMainHand");
end

function RPSCoreFramework:RemoveDisplay(slotname)
	local removeDispSlot;
	local menuTitle = "Вы действительно хотите убрать дисп?";
	for v,h in pairs(RPSCoreFramework.SlotnameListPresets) do
		if (v == slotname) then
			removeDispSlot = h .. "0";
			break
		end
	end
	for v,h in pairs(RPSCoreFramework.SlotnameListNames) do
		if (v == slotname) then
			menuTitle = "Вы действительно хотите убрать дисп для " .. h .. "?";
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
	RPSCoreFramework:HideDialogPopup();
	StaticPopup_Show("removeDisp");
end

function RPSCoreFramework:ShowDisEnchantDialog(slotname)

	StaticPopupDialogs["removeWeaponEnchant"] = {
		text = "Убрать зачарование с выбранного предмета?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:SendCoreMessage("enchant "..slotname.." 0") end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		enterClicksFirstButton = true,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}
	RPSCoreFramework:HideDialogPopup();
	StaticPopup_Show("removeWeaponEnchant");
end

function RPSCoreFramework:ShowEnchantDialog(slotname)
	if (slotname == "mainhand") then
		StaticPopupDialogs["EnchantMainHand"] = {
			text = "Введите ID зачарования в пределах 1 - 197",
			button1 = "Применить",
			button2 = "Выйти",
			OnShow = function (self, data)

			end,
			OnAccept = function (self, data, data2)
				RPSCoreFramework:SendCoreMessage("enchant mainhand "..self.editBox:GetText());
			end,
		  	OnCancel = function (_,reason)
		  	end,
			hasEditBox = true,
		  	timeout = 15,
		  	whileDead = true,
		  	hideOnEscape = true,
		  	enterClicksFirstButton = true,
		}
		RPSCoreFramework:HideDialogPopup();
		StaticPopup_Show("EnchantMainHand");
	elseif(slotname == "offhand") then
		StaticPopupDialogs["EnchantOffHand"] = {
			text = "Введите ID зачарования в пределах 1 - 197",
			button1 = "Применить",
			button2 = "Выйти",
			OnShow = function (self, data)

			end,
			OnAccept = function (self, data, data2)
				RPSCoreFramework:SendCoreMessage("enchant offhand "..self.editBox:GetText());
			end,
		  	OnCancel = function (_,reason)
		  	end,
			hasEditBox = true,
		  	timeout = 15,
		  	whileDead = true,
		  	hideOnEscape = true,
		  	enterClicksFirstButton = true,
		}
		RPSCoreFramework:HideDialogPopup();
		StaticPopup_Show("EnchantOffHand");
	end
	assert("Некорректное значение slotname - "..slotname);
end

function RPSCoreFramework:ShowDisplayInfo(slotname)
	local displayMessage
	local menuTitle = "Введите ID предмета для выбранного слота.";
	for v,h in pairs(RPSCoreFramework.SlotnameListPresets) do
		if (v == slotname) then
			displayMessage = h;
			break;
		end
	end
	for v,h in pairs(RPSCoreFramework.SlotnameListNames) do
		if (v == slotname) then
			menuTitle = "Введите ID предмета для " .. h .. ".";
			break;
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
	  	end,
		hasEditBox = true,
	  	timeout = 15,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}
	StaticPopup_Hide("removeDisp");
	StaticPopup_Hide("DispSlotEditMenu");
	StaticPopup_Show("DipsSlotEditMenu");
end

function RPSCoreFramework:KnownAura(arg)
	if (RPSCoreFramework.Interface.Auras[arg][5] > 0) then
		return true;
	end
	
	return false;
end

function RPSCoreFramework:isAuraActive(arg)
	if (RPSCoreFramework.Interface.Auras[arg][6] > 0) then
		return true;
	end
	
	return false;
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
		RPSCoreIconData = { hide = false, minimapPos = 140.35 }	
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
	  	end,
		hasEditBox = true,
	  	whileDead = true,
	  	hideOnEscape = true,
	  	enterClicksFirstButton = true,
	}
	if Oldpas == '' or Newpas == '' or NewpasRep == '' then
		message("\nЗаполнены не все поля")
		if Oldpas == '' then
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
	local subMenuNeedToShow = true;

	local selectedSubButtons = -1;

	for i=1, #RPSCoreFramework.Interface.MenuButtons do
		if (i == 1) then 
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

		if (tostring(RPSCoreFramework.Interface.MenuButtons[i][2]) == tostring(button)) then
			selectedSubButtons = RPSCoreFramework.Interface.MenuButtons[i][5];
		end

		local count = 1;

		if (RPSCoreFramework.Interface.MenuButtons[i][4]) then
			if (tostring(RPSCoreFramework.Interface.MenuButtons[i][2]) == tostring(button)) then
				for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
					if (tonumber(RPSCoreFramework.Interface.SubMenuButtons[j][1]) == tonumber(RPSCoreFramework.Interface.MenuButtons[i][5])) then
						if count==1 then
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.MenuButtons[i][2]], 25, y);
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:LockHighlight();
						else
							y = -25
							_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:SetPoint("TOPLEFT", _G[RPSCoreFramework.Interface.SubMenuButtons[j-1][3]], 0, y);
						end
						count = count + 1;
						_G[RPSCoreFramework.Interface.SubMenuButtons[j][3].."Label"]:SetText("|cffFFFFFF"..RPSCoreFramework.Interface.SubMenuButtons[j][2]);
						shift = shift - 25;
						_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:Show();
					end
				end
			else
				for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
					if RPSCoreFramework.Interface.SubMenuButtons[j][1] ~= selectedSubButtons then
						_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]:Hide();
					end
				end -- Привет из прошлого (+ из будущего \Test)
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

		if RPSCoreFramework.Interface.MenuButtons[i][4] then
			for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
				if (tonumber(RPSCoreFramework.Interface.SubMenuButtons[j][1]) == tonumber(RPSCoreFramework.Interface.MenuButtons[i][5])) then
					local SubMenuButton = CreateFrame('Button', RPSCoreFramework.Interface.SubMenuButtons[j][3], RPS_MainFrame, "RPS_CategoryButton");
					SubMenuButton:SetSize(130,24)
					_G[RPSCoreFramework.Interface.SubMenuButtons[j][3].."Label"]:SetText("|cffFFFFFF"..RPSCoreFramework.Interface.SubMenuButtons[j][2]);
					table.insert(RPSCoreFramework.Interface.HidingFrames, _G[RPSCoreFramework.Interface.SubMenuButtons[j][4]]);
					table.insert(RPSCoreFramework.Interface.HighlightedButtons, _G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]);

					SubMenuButton:SetScript('OnClick', function()
						RPSCoreFramework:OnClickCosmetic(_G[RPSCoreFramework.Interface.SubMenuButtons[j][3]]);
						RPSCoreFramework:OnClickFrameShowing(_G[RPSCoreFramework.Interface.SubMenuButtons[j][4]]);
					end)
				end
			end
		end
		_G[RPSCoreFramework.Interface.MenuButtons[i][2].."Label"]:SetText(RPSCoreFramework.Interface.MenuButtons[i][1]);
		local index = 1;
		for j=1, #RPSCoreFramework.Interface.SubMenuButtons do
			if RPSCoreFramework.Interface.SubMenuButtons[j][1] == RPSCoreFramework.Interface.MenuButtons[i][5] then
				index = j;
				break;
			end
		end

		MenuButton:SetScript('OnClick', function()
			RPSCoreFramework:FormatDMButtons(RPSCoreFramework.Interface.MenuButtons[i][2]);
			if RPSCoreFramework.Interface.MenuButtons[i][7] then
				RunScript(RPSCoreFramework.Interface.MenuButtons[i][8]);
			elseif RPSCoreFramework.Interface.MenuButtons[i][4] then
					RPSCoreFramework:OnClickCosmetic(_G[RPSCoreFramework.Interface.SubMenuButtons[index][3]]);
					RPSCoreFramework:OnClickFrameShowing(_G[RPSCoreFramework.Interface.SubMenuButtons[index][4]]);
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

function RPSCoreFramework:FormatQualityName(itemName, defaultQuality)
	local quality = RPSCoreFramework.itemsQuality[itemName] or defaultQuality;
	local _, _, _, hex = GetItemQualityColor(quality);	
	return "|c"..hex.._G["ITEM_QUALITY"..quality.."_DESC"].."|r";
end

function RPSCoreFramework:hex2rgb(hex)
    local hex = hex:gsub("#","")
    if hex:len() == 3 then
      return (tonumber("0x"..hex:sub(1,1))*17)/255, (tonumber("0x"..hex:sub(2,2))*17)/255, (tonumber("0x"..hex:sub(3,3))*17)/255
    else
      return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255
    end
end

local function splitWords(Lines, limit)
    while #Lines[#Lines] > limit do
        Lines[#Lines+1] = Lines[#Lines]:sub(limit+1)
        Lines[#Lines-1] = Lines[#Lines-1]:sub(1,limit)
    end
end

function RPSCoreFramework:WordWrap(str, limit)
    local Lines, here, limit, found = {}, 1, limit or 80, str:find("(%s+)()(%S+)()")

    if found then
        Lines[1] = string.sub(str,1,found-1)  -- Put the first word of the string in the first index of the table.
    else Lines[1] = str end

    str:gsub("(%s+)()(%S+)()",
        function(sp, st, word, fi)  -- Function gets called once for every space found.
            splitWords(Lines, limit)

            if fi-here > limit then
                here = st
                Lines[#Lines+1] = word                                             -- If at the end of a line, start a new table index...
            else Lines[#Lines] = Lines[#Lines].." "..word end  -- ... otherwise add to the current table index.
        end)
    splitWords(Lines, limit)
    return Lines
end

function RPSCoreFramework:GuildInfoFrame_Update()
	local selectedTab = PanelTemplates_GetSelectedTab(GuildInfoFrame);
	if ( selectedTab == 1 ) then
		GuildInfoFrameInfo:Show();
		--RPSCoreFramework.GuildInfoPOIFrame:Show();
		GuildInfoFrameRecruitment:Hide();
		GuildInfoFrameApplicants:Hide();
		GuildInfoFrameSalary:Hide();
	elseif ( selectedTab == 2 ) then
		GuildInfoFrameInfo:Hide();
		--RPSCoreFramework.GuildInfoPOIFrame:Hide();
		GuildInfoFrameRecruitment:Show();
		GuildInfoFrameApplicants:Hide();
		GuildInfoFrameSalary:Hide();
	elseif ( selectedTab == 3) then
		GuildInfoFrameInfo:Hide();
		--RPSCoreFramework.GuildInfoPOIFrame:Hide();
		GuildInfoFrameRecruitment:Hide();
		GuildInfoFrameApplicants:Show();
		GuildInfoFrameSalary:Hide();
	else
		GuildInfoFrameInfo:Hide();
		--RPSCoreFramework.GuildInfoPOIFrame:Hide();
		GuildInfoFrameRecruitment:Hide();
		GuildInfoFrameApplicants:Hide();
		GuildInfoFrameSalary:Show();
	end
end

function RPSCoreFramework:ProcessGuildSalaryInterface()
	local gname, grankname, granknum = GetGuildInfo("player");
	for i = 1, 10 do
		local rankFrame = _G["GuildInfoFrameSalaryRank"..i];
		if (GuildControlGetRankName(i) == "") then
			rankFrame:Hide();
		else
			rankFrame.rankLabel:SetText(i..": "..GuildControlGetRankName(i));
			rankFrame.nameBox:SetText(RPSCoreFramework.SalaryByRank[tostring(i)]);
			rankFrame.nameBox:SetTextColor(1, 1, 1, 1);

			if granknum == 0 then
				rankFrame.setup:Enable();
				rankFrame.nameBox:Enable();
				rankFrame.setup:Show();
			else
				rankFrame.nameBox:Disable();
				rankFrame.setup:Disable();
				rankFrame.setup:Hide();
			end
			rankFrame:Show();
		end
	end
end

function RPSCoreFramework:isvalid(n)
	return n==math.floor(n) and n>=0 and n<=10000
end

function RPSCoreFramework:CutDigits(msg)
	msg = tostring(msg);
	return msg:match("([1-9-]%d+)")
end

function RPSCoreFramework:SetGuildSalaryToRank(id)
	self:SendCoreMessage("rps guild salary "..tonumber(id-1).." "..RPSCoreFramework.SalaryByRank[tostring(id)]);
end

function RPSCoreFramework:StartGarbageCollection()
	RPSCoreFramework.GBCounter = collectgarbage("count")
	collectgarbage("collect")
	if RPSCoreFramework.PrintGarbageCollector then
		print("Collected " .. (RPSCoreFramework.GBCounter-collectgarbage("count")) .. " kB of garbage");
	end
end

SLASH_RPSGARBAGECOLLECTOR1 = "/rpsgarbage";

function SlashCmdList.RPSGARBAGECOLLECTOR()
    if RPSCoreFramework.PrintGarbageCollector then
    	print("Hide garbage collector debug message.")
    	RPSCoreFramework.PrintGarbageCollector = false;
    else
    	print("Show garbage collector debug message.")
    	RPSCoreFramework.PrintGarbageCollector = true;
    end
end

function RPSCoreFramework:playAnimation(animationGroup, callback)
	if animationGroup then
		animationGroup:Stop();
		animationGroup:Play();
		if callback then
			animationGroup:SetScript("OnFinished", callback)
		end
	elseif callback then
		callback();
	end
end

function RPSCoreFramework:AddGuildPOIInfo()
	RPSCoreFramework.GuildInfoPOIFrame = CreateFrame("Frame","GuildInfoPOIFrame",GuildFrame)
	RPSCoreFramework.GuildInfoPOIFrame:SetFrameStrata("HIGH")

	local t = RPSCoreFramework.GuildInfoPOIFrame:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
	t:SetAllPoints(RPSCoreFramework.GuildInfoPOIFrame)
	RPSCoreFramework.GuildInfoPOIFrame.texture = t

	RPSCoreFramework.GuildInfoPOIFrame:SetPoint("TOPLEFT",GuildInfoFrameInfo,5,-25)
	RPSCoreFramework.GuildInfoPOIFrame:SetPoint("BOTTOMRIGHT",GuildInfoFrameInfo,-5,200)

	RPSCoreFramework.GuildInfoPOIFrame:Show()
end
