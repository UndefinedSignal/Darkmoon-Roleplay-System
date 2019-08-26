function RPSCoreFramework:InitializeHooks()
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("PLAYER_MONEY");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("BAG_UPDATE")
	for index = 1, NUM_CHAT_WINDOWS do
		local editbox = _G["ChatFrame" .. index .. "EditBox"];
		self:SecureHookScript(editbox, "OnTextChanged",   "UpdateTypingStatus");
		self:SecureHookScript(editbox, "OnEscapePressed", "UpdateTypingStatus");
		self:SecureHookScript(editbox, "OnEnterPressed",  "UpdateTypingStatus");
		self:SecureHookScript(editbox, "OnHide",          "UpdateTypingStatus");
	end	
	self:HookScript(self, "OnEvent", "OnEventFrame");
	self:HookScript(GameTooltip, "OnTooltipSetItem", "ItemTooltip");
	self:HookScript(ItemRefTooltip, "OnTooltipSetItem", "ItemTooltip");
	self:HookScript(ItemRefShoppingTooltip1, "OnTooltipSetItem", "ItemTooltip");
	self:HookScript(ItemRefShoppingTooltip2, "OnTooltipSetItem", "ItemTooltip");
	self:HookScript(ShoppingTooltip1, "OnTooltipSetItem", "ItemTooltip");
	self:HookScript(ShoppingTooltip2, "OnTooltipSetItem", "ItemTooltip");
	--self:SecureHook("ZoomOut", function()	RPSCoreFramework:GeneratePOIPlaces();	end);

--PlayerZoneChanged(currentPlayerUiMapID, currentPlayerUiMapType)
--Fires when the active zone map changes, passes the same arguments as calling HBD:GetPlayerZone() would return

	WorldMapFrame.ScrollContainer:HookScript("OnMouseDown", function(self, button)
		RPSCoreFramework:ProcessMapClick(button);
	end)
	--self:SecureHook("PlayerZoneChanged", function() 	if IsOutdoors() then RPSCoreFramework:GeneratePOIPlaces(); end	end)
	--self:SecureHook("ProcessMapClick", function()	RPSCoreFramework:GeneratePOIPlaces();	end);
	--self:SecureHook("SetMapZoom", function() 	RPSCoreFramework:FlushAllPinsOnMap();	end);
	self:SecureHook("ToggleWorldMap", function()	RPSCoreFramework:GeneratePOIPlaces();	end);

	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:HookScript("OnClick", function()	RPSCoreFramework:GeneratePOIPlaces();	end);
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton:HookScript("OnClick", function()	RPSCoreFramework:GeneratePOIPlaces();	end);
	RPS_BTNReScale:HookScript("OnMouseUp", function() if RPS_BTNReScale:IsEnabled() then StaticPopup_Show("setCharacterReScale") end end);
	RPS_BTNAcceptScale:HookScript("OnMouseUp", function() if RPS_BTNAcceptScale:IsEnabled() then StaticPopup_Show("setCharacterScale") end end);
	DarkmoonAurasFrameClearButton:HookScript("OnClick", function()	RPSCoreFramework:AurasSearch(RPSCoreFramework.Interface.Auras, DarkmoonAurasFrame.searchBox:GetText());	RPSCoreFramework:GenerateScrollMenu() end);
	RPS_MainFrame.Close:SetScript("OnClick", function() RPSCoreFramework:switchMainFrame() end);
	DarkmoonCharStatsInfoReset:SetScript("OnClick", function() RPSCoreFramework:ResetDiff() end);	
	DarkmoonCharStatsInfoSubmit:SetScript("OnClick", function() StaticPopup_Show("LearnStats") end);	
	DarkmoonCharStatsInfoUnlearn:SetScript("OnClick", function() StaticPopup_Show("UnlearnStats") end);
	RPS_InteractFrameHelp:SetScript("OnClick", function() StaticPopup_Show("ActionHelp"); end);
	RPS_InteractFrameKill:SetScript("OnClick", function() StaticPopup_Show("ActionKill"); end);
	RPS_InteractFramePillage:SetScript("OnClick", function() StaticPopup_Show("ActionPillageLoot"); end);

	RPSCoreFramework:HookAllPlayerBagButtons();

	--self:RawHook(MapCanvasMixin, "OnLoad()", RPSCoreFramework:AcquirePin(), true);
end

function RPSCoreFramework:AcquirePin()
	print("Meme succesful")
end

function RPSCoreFramework:HookAllPlayerBagButtons()
	local bagButton = nil;
	local num = nil;
	for i = 0, NUM_BAG_SLOTS do -- Пробег по всем сумкам, существуют ли они?
		local slots = GetContainerNumSlots(i) or 0;
		if slots > 0 then -- Пробег по всем слотам и прикручивание к ним нашего кода
			for j = 1, slots do
				num = i + 1;
				bagButton = _G["ContainerFrame"..num.."Item"..j]
				if (not RPSCoreFramework:IsHooked(bagButton, "OnClick")) then
					self:SecureHookScript(bagButton, "OnClick", "HookPlayerContainerClick");
				end
			end
		end
	end
end

function RPSCoreFramework:OnEventFrame(self, event, prefix, msg, channel, sender)
	if (event == "PLAYER_TARGET_CHANGED") then
		self.TimerID = self:ScheduleRepeatingTimer("AuraCheckTimer", 0.5);
		self:UpdatePlayerModel();
		self:UpdateInteractionFrame();
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_EQUIPMENT_CHANGED") then
		RPSCoreFramework:SendCoreMessage("rps stat self");
	elseif (event == "PLAYER_MONEY") then
		self:UpdateUnlearn();
		self:UpdateScaleReset();
		self:PeriodicallyScrollMenuUpdater();
	elseif (event == "CHAT_MSG_ADDON" and sender == (GetUnitName("player").."-"..string.gsub(GetRealmName(), " ", ""))) then
		if (prefix == "RPS.POI.i") then
			RPSCoreFramework:AddPOIPins(msg)
		elseif (prefix == "RPS.POI.u") then
			RPSCoreFramework:UpdatePOIPins(msg)
		elseif (prefix == "RPS.POI.r") then
			RPSCoreFramework:RemovePOIPins(msg)
		elseif (prefix == "RPS.POI.c") then
			RPSCoreFramework:GetCommandPOIPins(msg)
		elseif (prefix == "RPS.StatMe") then
			RPSCoreFramework:UpdateInfo("RPS.StatMe "..msg);
		elseif (prefix == "RPS.Scale") then
			RPSCoreFramework:UpdateScaleInfo("RPS.Scale "..msg);
		elseif (prefix == "RPS.AuraKnown") then
			RPSCoreFramework:UpdateAuraKnownInfo("RPS.AuraKnown "..msg);
		elseif (prefix == "RPS.AuraActive") then
			RPSCoreFramework:UpdateAuraActiveInfo("RPS.AuraActive "..msg);
		elseif (prefix == "RPS.Display") then
			RPSCoreFramework:UpdateDisplayMacrosInfo("RPS.Display "..msg);
		elseif (prefix == "RPS.AuraRefresh") then
			RPSCoreFramework:RefreshActiveAuras("RPS.AuraRefresh "..msg);
		elseif (prefix == "RPS.CON.i") then
			RPSCoreFramework:InitializeContainer(msg);
		elseif (prefix == "RPS.CON.c") then
			RPSCoreFramework:InvokeContainerComamnd(msg);
		elseif (prefix == "RPS.CON.u") then
			RPSCoreFramework:UpdateContainer(msg);
		elseif (prefix == "RPS.ECO.ti") then
			RPSCoreFramework:SalaryIndicator(msg)
		elseif (prefix == "RPS.AuraOff") then
			RPSCoreFramework:UpdatePLayerAuraList(msg)
		elseif (prefix == "RPS.Minstrel") then
			RPSCoreFramework:UpdateMinstrelStatus(msg);
		end
	elseif (event == "BAG_UPDATE") then
		RPSCoreFramework:HookAllPlayerBagButtons();
--[[	elseif (event == "RPS.POLL") then
		RPSCoreFramework:InitializePool(msg);]]
	end
end

function RPSCoreFramework:ItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local _, _, _, _, _, sType, _, _ = GetItemInfo(link);
	if (sType == "Доспехи" or sType == "Armor") then		
		local name = self:GetName()
		for i = 1, self:NumLines() do
			local left = _G[name .. "TextLeft" .. i]
			local right = _G[name .. "TextRight" .. i]
			if (left:GetText() ~= nil) then
				if (string.find(left:GetText(), ITEM_MOD_STRENGTH_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_STRENGTH_SHORT, "к стойкости"));
				elseif (string.find(left:GetText(), ITEM_MOD_AGILITY_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_AGILITY_SHORT, "к сноровке"));
				elseif (string.find(left:GetText(), ITEM_MOD_INTELLECT_SHORT )) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_INTELLECT_SHORT, "к воле"));
				end
			end
			if (right:GetText() ~= nil) then
				if (string.find(right:GetText(), "Декоративный предмет") or string.find(right:GetText(), "Cosmetic")) then
					_G[name .. "TextRight" .. i]:SetText("Предмет");
				end
			end
		end
	end
end

function RPSCoreFramework:HookPlayerContainerClick(self)
	RPSCoreFramework.Container.ClickedBag = tonumber(self:GetParent():GetID());
	RPSCoreFramework.Container.ClickedSlot = tonumber(self:GetID());
	local itemID = GetContainerItemID(RPSCoreFramework.Container.ClickedBag, RPSCoreFramework.Container.ClickedSlot);
	local __, itemCount = GetContainerItemInfo(RPSCoreFramework.Container.ClickedBag, RPSCoreFramework.Container.ClickedSlot)
	if (itemID and (RPSCoreFramework.PlayerCursorInformation == nil or not RPSCoreFramework:GetCursorItem())) then
		local temp = {}
		temp.isVirtual = false;
		temp.itemID = itemID;
		temp.count = itemCount;
		temp.slotID = 0;
		RPSCoreFramework.PlayerCursorInformation = temp;
	elseif (RPSCoreFramework:GetCursorItem() and RPSCoreFramework.PlayerCursorInformation) then
		if (not RPSCoreFramework.PlayerCursorInformation.isVirtual) then
			RPSCoreFramework.PlayerCursorInformation = nil;
		end
	end

	if RPSCoreFramework.PlayerCursorInformation then
		if RPSCoreFramework.PlayerCursorInformation.isVirtual then
			RPSCoreFramework:ContainerToInventory(RPSCoreFramework.Container.ClickedBag, RPSCoreFramework.Container.ClickedSlot);
			return
		end
	end
end

function RPSCoreFramework:ProcessMapClick(button)
	if button == "RightButton" then
		RPSCoreFramework:GeneratePOIPlaces();
	elseif button == "LeftButton" then
		RPSCoreFramework:GeneratePOIPlaces();
--[[	elseif button == "MiddleButton" then
		print("Middle button!");
	elseif button == "Button4" then
		print("Button4 button!");
	elseif button == "Button5" then
		print("Button5 button!");]]--
	end
end