local containerFrame = nil;

local ALLOWED_SIZES = {1,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34}

function RPSCoreFramework:SetUpcontainerFrame(title, type, size)
	if (not containerFrame) then
		containerFrame = CreateFrame("Frame", "RPS_ContainerFrame", UIParent, "RPS_ContainerFrameTemplate");
		containerFrame.items = {};
	end
	RPSCoreFramework:ContainerFrameGenerateFrame(containerFrame, size, title);	
	containerFrame:SetPoint("CENTER", nil, "CENTER", 0, 0 );
	containerFrame:Show();
end

function RPSCoreFramework:ContainerFrameGenerateFrame(frame, size, title, icon, specialTexture)
	frame.size = size;
	local name = frame:GetName();
	local containerName = title or "Контейнер";
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
	
	
	RPSCoreFramework:PushContainerItem(6, {isVirtual = true, itemID = 112095, count = 13, quaility = 2, locked = false})
	
	RPSCoreFramework:ContainerFrameUpdate();
end

function RPSCoreFramework:ContainerFrameOnShow(self)
	PlaySound(862);
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
		ClearCursor();
		RPSCoreFramework:UlockContainerItem(self)
		RPSCoreFramework.PlayerCursorInformation = nil;
		RPSCoreFramework:ContainerFrameUpdate();
	end
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

	if RPSCoreFramework:CursorIsNotValid() then
		print("Invalid cursor information. Container frame would be rebuild.")
		RPSCoreFramework:ContainerFrameUpdate()
	end
end

function RPSCoreFramework:CursorIsNotValid()
	if RPSCoreFramework:GetCursorItem() and PlayerCursorInformation ~= nil then
		if (PlayerCursorInformation.itemID == containerFrame.items[PlayerCursorInformation.slotID].itemID) then
			ClearCursor();
			PlayerCursorInformation = nil;
			return true;
		end
	end
	return false;
end

function RPSCoreFramework:ContainerFrameItemButtonOnLoad(self)
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("AnyUp");
end

function RPSCoreFramework:ContainerFrameOnLoad()
	-- Nothing
end


function RPSCoreFramework:ContainerFrameItemButtonOnClick(self, button)
	if button == "LeftButton" then
		local infoType = GetCursorInfo()
		if (RPSCoreFramework:GetCursorItem()) then
			RPSCoreFramework:PlaceContainerItem(self)
		else
			RPSCoreFramework:PickupContainerItem(self)
		end
--	elseif button == "RightButton" then
--		print("click right");
	end
end

function RPSCoreFramework:PickupContainerItem(self)
	local id = self:GetID()
	local item = containerFrame.items[id]
	local parent = self:GetParent();

	if item == nil or item.locked then return; end

	local temp = {};
	temp.isVirtual = item.isVirtual;
	temp.itemID = item.itemID;
	temp.count = item.count;
	temp.slotID = id;

	item.locked = true;
	RPSCoreFramework.PlayerCursorInformation = temp;
	PickupItem(item.itemID)
	RPSCoreFramework:ContainerFrameUpdate();

	RPSCoreFramework.Timers.ContainerStatus = RPSCoreFramework:ScheduleRepeatingTimer("ItemLockdownUpdate", 1)
end

function RPSCoreFramework:PlaceContainerItem(self)
	if RPSCoreFramework:GetCursorItem() then
		local id = self:GetID()
		local item = containerFrame.items[id]
		local parent = self:GetParent();
		if (item ~= nil and RPSCoreFramework.PlayerCursorInformation) then
			if RPSCoreFramework.PlayerCursorInformation.isVirtual then
				RPSCoreFramework:SwapContainerItems(self) -- self = a slotbutton that was clicked
			else
				-- 
				ClearCursor();
				RPSCoreFramework.PlayerCursorInformation = nil;
				return;
			end
		elseif (RPSCoreFramework.PlayerCursorInformation) then
			RPSCoreFramework:PushContainerItem(id, {isVirtual = true, itemID = RPSCoreFramework.PlayerCursorInformation.itemID, count = RPSCoreFramework.PlayerCursorInformation.count, locked = false})
			RPSCoreFramework:ContainerPut(slot, itemID)
			containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID] = nil;
			containerFrame.items[id].locked = false;
		end
	end
	ClearCursor();
	RPSCoreFramework.PlayerCursorInformation = nil;
	RPSCoreFramework:ContainerFrameUpdate();
end

function RPSCoreFramework:UlockContainerItem(arg1)
	local id = arg1:GetID()
	containerFrame.items[id].locked = false;
end

function RPSCoreFramework:GetContainerItem(slotID)
	local item = containerFrame.items[tonumber(slotID)];

	if (item) then
		return item.itemID, item.texture, item.count, item.locked;
	end
end

function RPSCoreFramework:PushContainerItem(slotID, item, update)
	containerFrame.items[slotID] = {isVirtual = item.isVirtual or false, itemID = item.itemID or nil, texture = GetItemIcon(item.itemID) or "Interface\\Icons\\INV_Misc_QuestionMark", count = item.count or 0, locked = item.locked or false};
	if (update) then
		RPSCoreFramework:ContainerFrameUpdate();
	end
end

--[[
function RPSCoreFramework:SetCursorItem()

end
]]--

function RPSCoreFramework:ItemLockdownUpdate()
	if (GetCursorInfo() == nil) then
		if (RPSCoreFramework.PlayerCursorInformation) then
			if (RPSCoreFramework.PlayerCursorInformation.isVirtual) then
				containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID].locked = false;
				RPSCoreFramework.PlayerCursorInformation = nil;
			end
		end
		RPSCoreFramework:ContainerFrameUpdate()
		self:CancelTimer(RPSCoreFramework.Timers.ContainerStatus)
	end
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

function RPSCoreFramework:SwapContainerItems(slot)
	local targetID = slot:GetID();
	local targetItem = containerFrame.items[targetID]
	if RPSCoreFramework.PlayerCursorInformation == nil then
		return;
	end

	RPSCoreFramework:PushContainerItem(targetID, {isVirtual = true, itemID = RPSCoreFramework.PlayerCursorInformation.itemID, count = RPSCoreFramework.PlayerCursorInformation.count, locked = false})
	RPSCoreFramework:PushContainerItem(RPSCoreFramework.PlayerCursorInformation.slotID, {isVirtual = true, itemID = targetItem.itemID, count = targetItem.count, locked = false})

	RPSCoreFramework:ContainerSwap(RPSCoreFramework.PlayerCursorInformation.slotID, targetID);

	containerFrame.items[targetID].locked = false;
	containerFrame.items[RPSCoreFramework.PlayerCursorInformation.slotID].locked = false;
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

function RPSCoreFramework:ShowContainerToolTip(self)
	ContainerGameTooltip:ClearLines();
	ContainerGameTooltip:SetOwner(self, "ANCHOR_LEFT");
	if self.guid ~= nil then
		local __, itemLink = GetItemInfo(self.guid)
		ContainerGameTooltip:SetHyperlink(itemLink)
	elseif (RPS_ContainerFramePortraitDescription == self) then
		ContainerGameTooltip:AddLine(RPS_ContainerFrameName:GetText());
	else
		return;
	end
	ContainerGameTooltip:Show();
end

function RPSCoreFramework:HideContainerToolTip()
	ContainerGameTooltip:ClearLines()
	ContainerGameTooltip:Hide();
end

function RPSCoreFramework:ContainerTake(slot, itemID)
	local msg = "container.take#"..slot;
	RPSCoreFramework:SendCoreMessage(msg)
end

function RPSCoreFramework:ContainerPut(slot, itemID)
	local msg = "container.put#"..slot.."#"..itemID;
	RPSCoreFramework:SendCoreMessage(msg)
end

function RPSCoreFramework:ContainerSwap(prevSlot, secSlot)
	local msg = "container.swap#"..prevSlot.."#"..secSlot;
	RPSCoreFramework:SendCoreMessage(msg)
end