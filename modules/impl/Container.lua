containerFrame = nil;

local ALLOWED_SIZES = {1,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34}
local BAG_SOUND = 862;
local BAG_DEFAULT_NAME = "Контейнер";

function RPSCoreFramework:SetUpContainerFrame()
	if (not containerFrame) then
		containerFrame = CreateFrame("Frame", "RPS_ContainerFrame", UIParent, "RPS_ContainerFrameTemplate");
	end
	containerFrame.items = {};
	containerFrame:SetPoint("CENTER", nil, "CENTER", 0, 0 );
	containerFrame:Show();
end

function RPSCoreFramework:ContainerFrameGenerateFrame(frame, size, title, icon, specialTexture)
	frame.size = size;
	local name = frame:GetName();
	local containerName = title or BAG_DEFAULT_NAME;
	local bgTextureTop = _G[name .. "BackgroundTop"];
	local bgTextureMiddle = _G[name .. "BackgroundMiddle1"];
	local bgTextureBottom = _G[name .. "BackgroundBottom"];
	local columns = NUM_CONTAINER_COLUMNS;
	local rows = ceil(size / columns);

	local bagTextureSuffix = specialTexture or "";
	if (specialTexture == "Bank" or specialTexture == "Keyring") then
		bagTextureSuffix = "-" .. specialTexture;
	end
	bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
	for i = 1, MAX_BG_TEXTURES do
		_G[name .. "BackgroundMiddle" .. i]:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
		_G[name .. "BackgroundMiddle" .. i]:Hide();
	end
	bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
	_G[name .. "MoneyFrame"]:Hide();

	if (size == 1) then
		local bgTextureTop = _G[name .. "BackgroundTop"];
		local bgTextureMiddle = _G[name .. "BackgroundMiddle1"];
		local bgTextureMiddle2 = _G[name .. "BackgroundMiddle2"];
		local bgTextureBottom = _G[name .. "BackgroundBottom"];
		local bgTexture1Slot = _G[name .. "Background1Slot"];

		bgTexture1Slot:Show();
		bgTextureTop:Hide();
		bgTextureMiddle:Hide();
		bgTextureMiddle2:Hide();
		bgTextureBottom:Hide();

		frame:SetHeight(70);
		frame:SetWidth(99);
		_G[frame:GetName() .. "Name"]:SetText("");
		local itemButton = _G[name .. "Item1"];
		itemButton:SetID(1);
		itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -10, 5);
		itemButton:Show();

	else
		-- non 1 slot
		local bgTextureTop = _G[name .. "BackgroundTop"];
		local bgTextureMiddle = _G[name .. "BackgroundMiddle1"];
		local bgTextureMiddle2 = _G[name .. "BackgroundMiddle2"];
		local bgTextureBottom = _G[name .. "BackgroundBottom"];
		local bgTexture1Slot = _G[name .. "Background1Slot"];

		bgTexture1Slot:Hide();
		bgTextureTop:Show();

		local bgTextureCount, height;
		local rowHeight = 41;
		-- Subtract one, since the top texture contains one row already
		local remainingRows = rows - 1;

		-- See if the bag needs the texture with two slots at the top
		local isPlusTwoBag;
		if (mod(size, columns) == 2) then
			isPlusTwoBag = 1;
		end

		-- Bag background display stuff
		if (isPlusTwoBag) then
			bgTextureTop:SetTexCoord(0, 1, 0.189453125, 0.330078125);
			bgTextureTop:SetHeight(72);
		else
			if (rows == 1) then
				-- If only one row chop off the bottom of the texture
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.16796875);
				bgTextureTop:SetHeight(86);
			else
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.18359375);
				bgTextureTop:SetHeight(94);
			end
		end
		-- Calculate the number of background textures we're going to need
		bgTextureCount = ceil(remainingRows / ROWS_IN_BG_TEXTURE);

		local middleBgHeight = 0;
		-- I f one row only special case
		if (rows == 1) then
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "TOP", 0, 0);
			bgTextureBottom:Show();
			-- Hide middle bg textures
			for i = 1, MAX_BG_TEXTURES do
				_G[name .. "BackgroundMiddle" .. i]:Hide();
			end
		else
			-- Try to cycle all the middle bg textures
			local firstRowPixelOffset = 9;
			local firstRowTexCoordOffset = 0.353515625;
			for i = 1, bgTextureCount do
				bgTextureMiddle = _G[name .. "BackgroundMiddle" .. i];

				if (remainingRows > ROWS_IN_BG_TEXTURE) then
					-- if more rows left to draw than can fit in a texture th en draw the max possible
					height = (ROWS_IN_BG_TEXTURE * rowHeight) + firstRowTexCoordOffset;
					bgTextureMiddle:SetHeight(height);
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, (height / BG_TEXTURE_HEIGHT + firstRowTexCoordOffset));
					bgTextureMiddle:Show();
					remainingRows = remainingRows - ROWS_IN_BG_TEXTURE;
					middleBgHeight = middleBgHeight + height;
				else
					-- I f not its a huge bag
					bgTextureMiddle:Show();
					height = remainingRows * rowHeight - firstRowPixelOffset;
					bgTextureMiddle:SetHeight(height);
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, (height / BG_TEXTURE_HEIGHT + firstRowTexCoordOffset));
					middleBgHeight = middleBgHeight + height;
				end
			end
			-- Position bottom texture
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "BOTTOM", 0, 0);
			bgTextureBottom:Show();
		end

		-- Set the frame height
		frame:SetHeight(bgTextureTop:GetHeight() + bgTextureBottom:GetHeight() + middleBgHeight);
		frame:SetWidth(CONTAINER_WIDTH);

		_G[frame:GetName() .. "Name"]:SetText(title);
		_G[frame:GetName() .. "Name"]:SetJustifyH("LEFT");
	end

	SetPortraitToTexture(name.."Portrait", "Interface\\Buttons\\Button-Backpack-Up");

	for j = 1, size, 1 do
		local index = size - j + 1;
		local itemButton = _G[name .. "Item" .. j];
		itemButton:SetID(j);
		itemButton.guid = nil;
		itemButton.count = nil;
		if (j == 1) then
			-- Anchor the first item differently if its the backpack frame
			if (id == 0) then
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 30);
			else
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 9);
			end
		else
			if (mod((j - 1), columns) == 0) then
				itemButton:SetPoint("BOTTOMRIGHT", name .. "Item" .. (j - columns), "TOPRIGHT", 0, 4);
			else
				itemButton:SetPoint("BOTTOMRIGHT", name .. "Item" .. (j - 1), "BOTTOMLEFT", -5, 0);
			end
		end

		local cooldownFrame = _G[itemButton:GetName() .. "Cooldown"];
		CooldownFrame_Set(cooldownFrame, GetTime() - (1), 1, 1); -- fixes cooldown frames not initializing correctly

		itemButton:Show();
	end
	for j = size + 1, MAX_CONTAINER_ITEMS, 1 do
		_G[name .. "Item" .. j]:Hide();
	end

	frame:SetMovable(true);
	RPSCoreFramework:EnableDrag(frame);
	-- Set up button for drag
	local btn = _G[name.."Plate"];
	btn:RegisterForDrag("LeftButton")
	btn:SetMovable(true);
	btn:SetScript("OnDragStart", frame.StartMoving);
	btn:SetScript("OnDragStop", frame.StopMovingOrSizing);
	
	--RPSCoreFramework:PushContainerItem(6, {isVirtual = true, itemID = 112095, count = 13, quaility = 2, locked = false})
	
	RPSCoreFramework:ContainerFrameUpdate();
end

function RPSCoreFramework:ContainerFrameUpdate()
	local frameName = containerFrame:GetName();
	for j = 1, containerFrame.size, 1 do
		local itemButton = _G[frameName .. "Item" .. j];
		local itemID, texture, count, locked = RPSCoreFramework:GetContainerItem(j);
		itemButton.guid = itemID;
		itemButton.count = count;
		SetItemButtonTexture(itemButton, texture);
		SetItemButtonCount(itemButton, count);
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);
		itemButton.slotID = j;

		if (itemID) then
			--GHI_ContainerFrame_UpdateCooldown(itemID, itemButton);
			itemButton.hasItem = 1;
		else
			_G[frameName .. "Item" .. j .. "Cooldown"]:Hide();
			itemButton.hasItem = nil;
		end
	end

--[[if RPSCoreFramework:CursorIsNotValid() then
		print("Invalid cursor information. Container frame would be rebuild.")
		RPSCoreFramework:ContainerFrameUpdate()
	end]]
end

function RPSCoreFramework:ContainerFrameItemButtonOnLoad(self)
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("AnyUp");
end

function RPSCoreFramework:ContainerFrameOnLoad()
	-- Nothing
end

function RPSCoreFramework:ContainerFrameOnShow(self)
	PlaySound(BAG_SOUND);
	--RPSCoreFramework:ContainerFrameUpdate(self)
end

function RPSCoreFramework:ContainerFrameOnHide(self)
--[[	if ( self.hasStackSplit and (self.hasStackSplit == 1) ) then
		StackSplitFrame:Hide();
	end]]
end

function RPSCoreFramework:ContainerFrameOnDragStop()
	if RPSCoreFramework.DraggingContainerFrame then
		RPSCoreFramework:PlaceContainerItem(RPSCoreFramework.DraggingContainerFrame);
	else
		RPSCoreFramework:ClearCursor();
		RPSCoreFramework:UnlockContainerItem(self);
		RPSCoreFramework:ContainerFrameUpdate();
	end
end

function RPSCoreFramework:ClearCursor()
	ClearCursor(); -- Clears player cursor icon
end

function RPSCoreFramework:GetCursorItem()
	if (CursorHasItem() == false and RPSCoreFramework.PlayerCursorInformation ~= nil) then
		if (RPSCoreFramework.PlayerCursorInformation.isVirtual == false) then
			RPSCoreFramework.PlayerCursorInformation = nil;
			return false;
		end
	end
	if (CursorHasItem() or RPSCoreFramework.PlayerCursorInformation) then
		return true;
	end
	return false;
end

function RPSCoreFramework:GetContainerItem(slotID)
	local item = containerFrame.items[tonumber(slotID)];

	if (item) then
		return item.itemID, item.texture, item.count, item.locked;
	end
end

function RPSCoreFramework:ShowContainerToolTip(self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	--ContainerGameTooltip:ClearLines();
	--ContainerGameTooltip:SetOwner(self, "ANCHOR_LEFT");
	if self.guid ~= nil then
		local __, itemLink = GetItemInfo(self.guid)
		GameTooltip:SetHyperlink(itemLink)
		--ContainerGameTooltip:SetHyperlink(itemLink)
	elseif (RPS_ContainerFramePortraitDescription == self) then
		GameTooltip:AddLine(RPS_ContainerFrameName:GetText());
		--ContainerGameTooltip:AddLine(RPS_ContainerFrameName:GetText());
	else
		return;
	end
	GameTooltip:Show();
	--ContainerGameTooltip:Show();
end

function RPSCoreFramework:HideContainerToolTip()
	GameTooltip:ClearLines()
	GameTooltip:Hide();
	--ContainerGameTooltip:ClearLines()
	--ContainerGameTooltip:Hide();
end

function RPSCoreFramework:ContainerFrameOnEnter(self)
	RPSCoreFramework:ShowContainerToolTip(self)
	RPSCoreFramework.DraggingContainerFrame = self;
end

function RPSCoreFramework:ContainerFrameOnLeave(self)
	self.updateTooltip = nil;
	RPSCoreFramework.DraggingContainerFrame = nil;
	ContainerGameTooltip:Hide();
	--ResetCursor();
end

function RPSCoreFramework:ContainerFrameItemButtonOnClick(self, button)
	if (button == "LeftButton") then
		local infoType = GetCursorInfo()
		if (RPSCoreFramework:GetCursorItem()) then
			print("has item -> place")
			RPSCoreFramework:PlaceContainerItem(self)
		else
			if (IsShiftKeyDown()) then
				print("shift");
				-- todo do the real paste in chatbox
			else
				print("no item -> pick")
				RPSCoreFramework:PickupContainerItem(self)
			end
		end
	--elseif button == "RightButton" then
	--	print("click right");
	end
end

function RPSCoreFramework:PickupContainerItem(self)
	local id = self:GetID()
	local item = containerFrame.items[id]
	local parent = self:GetParent();

	if item == nil or item.locked then return; end

	item.locked = true;
	RPSCoreFramework.PlayerCursorInformation = {isVirtual = item.isVirtual, itemID = item.itemID, count = item.count, slotID = id};
	PickupItem(item.itemID)


	RPSCoreFramework:ContainerFrameUpdate();

	RPSCoreFramework.Timers.ContainerStatus = RPSCoreFramework:ScheduleRepeatingTimer("ContainerMouseItemChecker", 0.5)
end

function RPSCoreFramework:ClearItemByID(id)
	containerFrame.items[id] = nil;
end

function RPSCoreFramework:UnlockItemByID(id)
	containerFrame.items[id].locked = false;
end

function RPSCoreFramework:ContainerMouseItemChecker()
	if (GetCursorInfo() == nil) then
		if (RPSCoreFramework.PlayerCursorInformation) then
			if (RPSCoreFramework.PlayerCursorInformation.isVirtual) then
				RPSCoreFramework:UnlockItemByID(RPSCoreFramework.PlayerCursorInformation.slotID)
				RPSCoreFramework.PlayerCursorInformation = nil;
			end
		end
		RPSCoreFramework:ContainerFrameUpdate()
		self:CancelTimer(RPSCoreFramework.Timers.ContainerStatus)
	end
end

function RPSCoreFramework:UnlockContainerItem(arg1, itemID)
	local id = nil;
	if arg1 ~= nil then
		id = arg1:GetID()
	else
		id = itemID;
	end
	if containerFrame.items[id] ~= nil then
		RPSCoreFramework:UnlockItemByID(id);
	end
	RPSCoreFramework.PlayerCursorInformation = nil;
	RPSCoreFramework.Container.ClickedBag = nil;
	RPSCoreFramework.Container.ClickedSlot = nil;
end

function RPSCoreFramework:PlaceContainerItem(self)
--	print("0")
	if RPSCoreFramework:GetCursorItem() then
		local id = self:GetID()
		local item = containerFrame.items[id]
		local parent = self:GetParent();
		if (item ~= nil and RPSCoreFramework.PlayerCursorInformation) then
			print("1")
			if RPSCoreFramework.PlayerCursorInformation.isVirtual then
				print("2")
				RPSCoreFramework:SwapContainerItems(self) -- self = a slotbutton that was clicked
			else
				-- 
				ClearCursor();
				RPSCoreFramework.PlayerCursorInformation = nil;
				return;
			end --local msg = "rps container put "..bag.." "..slot.." "..conSlot;
		elseif (RPSCoreFramework.PlayerCursorInformation) then
			print("3")
			if (RPSCoreFramework.Container.ClickedBag ~= nil and RPSCoreFramework.Container.ClickedSlot ~= nil) then
				print("4")
				--RPSCoreFramework:PushContainerItem(id, {isVirtual = true, itemID = RPSCoreFramework.PlayerCursorInformation.itemID, count = RPSCoreFramework.PlayerCursorInformation.count, locked = false})
				RPSCoreFramework:InventoryToContainer(RPSCoreFramework.Container.ClickedBag, RPSCoreFramework.Container.ClickedSlot, id)
				--containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID] = nil;
				RPSCoreFramework:ClearItemByID(RPSCoreFramework.PlayerCursorInformation.slotID)
				
				--containerFrame.items[id].locked = false;
				RPSCoreFramework.Container.ClickedBag = nil;
				RPSCoreFramework.Container.ClickedSlot = nil;
			else
				print("5")
				RPSCoreFramework:SwapContainerItems(self)
			end
		end
	end
	print("6")
	RPSCoreFramework:ClearCursor();
	RPSCoreFramework.PlayerCursorInformation = nil;
	RPSCoreFramework:ContainerFrameUpdate();
end

function RPSCoreFramework:InventoryToContainer(bag, slot, conSlot)
	local msg = "container put "..bag.." "..slot.." "..conSlot;
	print(msg)
	RPSCoreFramework:SendCoreMessage(msg)
end

function RPSCoreFramework:ContainerSwap(prevSlot, secSlot)
	local msg = "container swap "..prevSlot.." "..secSlot;
	print(msg)
	RPSCoreFramework:SendCoreMessage(msg)
end

function RPSCoreFramework:ContainerToInventory(bag, bagSlot)
	local itemID = GetContainerItemID(bag, bagSlot);
	if (RPSCoreFramework:GetCursorItem() and RPSCoreFramework.PlayerCursorInformation) then
		if (RPSCoreFramework.PlayerCursorInformation.isVirtual and itemID == nil) then
			local count = RPSCoreFramework.PlayerCursorInformation.count;
			local containerSlotID = RPSCoreFramework.PlayerCursorInformation.slotID;
			local msg = "container take "..bag.." "..bagSlot.." "..containerSlotID;
			print(msg)
			RPSCoreFramework:SendCoreMessage(msg);

			containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID] = nil
			RPSCoreFramework:UnlockContainerItem(nil, RPSCoreFramework.PlayerCursorInformation.slotID)
			RPSCoreFramework.PlayerCursorInformation = nil;
			RPSCoreFramework:ClearCursor()
		else
			RPSCoreFramework:UnlockContainerItem(nil, RPSCoreFramework.PlayerCursorInformation.slotID)
		end
	end
end

function RPSCoreFramework:SwapContainerItems(slot)
	local targetID = slot:GetID();
	local targetItem = containerFrame.items[targetID]
	if RPSCoreFramework.PlayerCursorInformation == nil then
		return;
	end
	if targetID == RPSCoreFramework.PlayerCursorInformation.slotID then
		RPSCoreFramework:UnlockItemByID(targetID);
		return;
	end
--[[
	if targetItem == nil then
		--RPSCoreFramework:PushContainerItem(targetID, {isVirtual = true, itemID = RPSCoreFramework.PlayerCursorInformation.itemID, count = RPSCoreFramework.PlayerCursorInformation.count, locked = false})
		--containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID] = nil;
		print("targetItem == nil");
	else
		--RPSCoreFramework:PushContainerItem(targetID, {isVirtual = true, itemID = RPSCoreFramework.PlayerCursorInformation.itemID, count = RPSCoreFramework.PlayerCursorInformation.count, locked = false})
		--RPSCoreFramework:PushContainerItem(RPSCoreFramework.PlayerCursorInformation.slotID, {isVirtual = true, itemID = targetItem.itemID, count = targetItem.count, locked = false})
		--containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID].locked = false;
		--RPSCoreFramework:ContainerSwap(RPSCoreFramework.PlayerCursorInformation.slotID, targetID);
		print("targetItem != nil")
	end]]
	--containerFrame.items[targetID].locked = false;
	RPSCoreFramework:ContainerSwap(RPSCoreFramework.PlayerCursorInformation.slotID, targetID);
end


function RPSCoreFramework:PushContainerItem(slotID, item, update)
	containerFrame.items[slotID] = {isVirtual = item.isVirtual or false, itemID = item.itemID or nil, texture = GetItemIcon(item.itemID) or "Interface\\Icons\\INV_Misc_QuestionMark", count = item.count or 0, locked = item.locked or false};
	if (update) then
		RPSCoreFramework:ContainerFrameUpdate();
	end
end

