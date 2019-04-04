local containerFrame;

local ALLOWED_SIZES = {1,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34}

function RPSCoreFramework:SetUpcontainerFrame()
	if (not containerFrame) then
		containerFrame = CreateFrame("Frame", "RPS_ContainerFrame", UIParent, "RPS_ContainerFrameTemplate");
		containerFrame.items = {};
		RPSCoreFramework:ContainerFrameGenerateFrame(containerFrame, 12, nil, "Keyring");	
	end
	containerFrame:SetPoint("CENTER", nil, "CENTER", 0, 0 );
	containerFrame:Show();
end

function RPSCoreFramework:ContainerFrameGenerateFrame(frame, size, icon, specialTexture)
	frame.size = size;
	local name = frame:GetName();
	local bgTextureTop = _G[name .. "BackgroundTop"];
	local bgTextureMiddle = _G[name .. "BackgroundMiddle1"];
	local bgTextureBottom = _G[name .. "BackgroundBottom"];
	local columns = NUM_CONTAINER_COLUMNS;
	local rows = ceil(size / columns);

	local bagTextureSuffix = specialTexture or "";
	if specialTexture == "Bank" or specialTexture == "Keyring" then
		bagTextureSuffix = "-" .. specialTexture;
	end
	bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
	for i = 1, MAX_BG_TEXTURES do
		_G[name .. "BackgroundMiddle" .. i]:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
		_G[name .. "BackgroundMiddle" .. i]:Hide();
	end
	bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components" .. bagTextureSuffix);
	_G[name .. "MoneyFrame"]:Hide();

	if size == 1 then
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

		_G[frame:GetName() .. "Name"]:SetText("ЮНИТ ЛЕНТЯЙ");
		_G[frame:GetName() .. "Name"]:SetJustifyH("LEFT");
	end

	SetPortraitToTexture(name.."Portrait", "Interface\\Buttons\\Button-Backpack-Up");

	for j = 1, size, 1 do
		local index = size - j + 1;
		local itemButton = _G[name .. "Item" .. j];
		itemButton:SetID(j);
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
	
	
	RPSCoreFramework:PushContainerItem(6, {itemId = 2, itemGuid = 1, count = 2, texture = "Interface\\Icons\\achievement_guildperk_bountifulbags", quaility = 2, locked = false})
	
	RPSCoreFramework:ContainerFrameUpdate(frame);
end

function RPSCoreFramework:ContainerFrameOnShow(self)
	PlaySound(862);
	--RPSCoreFramework:ContainerFrameUpdate(self)
end

function RPSCoreFramework:ContainerFrameOnLoad()
	print("on load");
end

function RPSCoreFramework:ContainerFrameUpdate(frame)
	local frameName = frame:GetName();
	print("update items");
	
	for j = 1, frame.size, 1 do
		local itemButton = _G[frameName .. "Item" .. j];
		local itemGuid, texture, count, locked = RPSCoreFramework:GetContainerItem(j);

		SetItemButtonTexture(itemButton, texture);
		SetItemButtonCount(itemButton, count);
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);
		itemButton.slotID = j;

		if (itemGuid) then
			--GHI_ContainerFrame_UpdateCooldown(itemGuid, itemButton);
			itemButton.hasItem = 1;
		else
			_G[frameName .. "Item" .. j .. "Cooldown"]:Hide();
			itemButton.hasItem = nil;
		end
	end
	
end

function RPSCoreFramework:ContainerFrameOnHide()
	print("on hide");
end

function RPSCoreFramework:ContainerFrameItemButtonOnLoad(self)
	self:RegisterForDrag("LeftButton", "RightButton");
	self:RegisterForClicks("AnyUp");
end

function RPSCoreFramework:ContainerFrameItemButtonOnClick(self, button)
	if button == "LeftButton" then
		print("click left");
	elseif button == "RightButton" then
		print("click right");
	end
end

function RPSCoreFramework:GetContainerItem(slotID)
	local item = containerFrame.items[slotID];
	if (item) then
		return item.itemGuid, item.texture, item.count, item.locked, item.quality;
	end
	--return nil, "Interface\\Icons\\INV_Misc_QuestionMark", 5, 1;	
end

function RPSCoreFramework:PushContainerItem(slotID, item, update)
	print("locked: "..tostring(item.locked));
	containerFrame.items[slotID] = {itemId = item.id or nil, itemGuid = item.itemGuid or nil, texture = item.texture or "Interface\\Icons\\INV_Misc_QuestionMark", count = item.count or 0, locked = item.locked or false, quality = item.quality or 0};
	if (update) then
		RPSCoreFramework:ContainerFrameUpdate(containerFrame);
	end
end


