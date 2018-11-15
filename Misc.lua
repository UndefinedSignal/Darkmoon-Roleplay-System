local DropDownDisplayMenuFrame = CreateFrame("Frame", "DisplayMenuFrame", UIParent, "UIDropDownMenuTemplate")

function RPSCoreFramework:ShowDisplayDropDownMenu(inventorySlotId)
	if (GetInventoryItemID("player", inventorySlotId)) then
		EasyMenu(RPSCoreFramework.DropDownDisplayMenu, DropDownDisplayMenuFrame, "cursor", 5, -15, "MENU", 5);
	end
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
		OnAccept = function() SendAddonMessage("DRPS", removeDispSlot, "WHISPER", UnitName("player")) end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
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
			SendAddonMessage("DRPS", displayMessage, "WHISPER", UnitName("player"))
		end,
	  	OnCancel = function (_,reason)
	--		Nope
	  	end,
		hasEditBox = true,
	  	timeout = 15,
	  	whileDead = true,
	  	hideOnEscape = true,
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