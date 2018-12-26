-- RPSCoreFramework.Map = {}
-- RPSCoreFramework.DB.Pins = {}

function RPSCoreFramework:AddPinCoords(zoneid, icon, name, x, y)
	table.insert(RPSCoreFramework.DB.Pins, {zoneid, icon, name, x, y})
	return true
end

function RPSCoreFramework:InsertPinOnMap(icon_path, zoneid, x, y)

	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POI"..RPSCoreFramework.POIIterator;

-- local p,f,x,y,w,h=WorldMapButton f=CrT or CreateFrame("Button","CrT",p) f:SetSize(16,16) f:SetNormalTexture("")
	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	IFrame:SetSize(13,13)

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture(icon_path)
	--ntex:SetVertexColor(1, 0, 0)
	--ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cFFFFFFFFЛОВУШКА!|r");
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end)

	RPSCoreFramework.HBD.Pins:AddWorldMapIconMF(RPSCoreFramework, IFrame, zoneid, nil, x, y, false)
	return true
end

function RPSCoreFramework:InsertPinOnMiniMap(icon_path, zoneid, x, y)

	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POITex"..RPSCoreFramework.POIIterator;

	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	IFrame:SetSize(13,13)

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture(icon_path)
	--ntex:SetVertexColor(1, 0, 0)
	--ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cFFFFFFFFЛОВУШКА!|r");
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide()
		      	end)

	RPSCoreFramework.HBD.Pins:AddMinimapIconMF(RPSCoreFramework, IFrame, zoneid, nil, x, y, false)
	return true
end

function RPSCoreFramework:FlushAllPinsOnMap()
	RPSCoreFramework.HBD.Pins:RemoveAllWorldMapIcons(RPSCoreFramework)
	return true
end

function RPSCoreFramework:FlushAllPinsOnMiniMap()
	RPSCoreFramework.HBD.Pins:RemoveAllMinimapIcons(RPSCoreFramework)
	return true
end

-- RPSCoreFramework:InsertPinOnMap("Interface\\MINIMAP\\TrapActive_Grey.blp", 720, 0.48706679450996, 0.174886696061)

function RPSCoreFramework:TakePinIcon()
	--RPSCoreFramework.Map.Icons

	local icon = "Interface\\MINIMAP\\TrapActive_Grey.blp"

	return icon
end

--function RPSCoreFramework:GeneratePinButtons()
--	RPSCoreFramework.Map.PinButtons
--end

function RPSCoreFramework:GetPlayerPosition()
	local x,y, mapid, _, _ = RPSCoreFramework.HBD:GetPlayerZonePosition()
	print("X: "..x.." Y: "..y.. " MapID: "..mapid)
end

--[[Retrieve the zone information the player is currently in.

This functions is independent of the world map and does not rely on the world map to retrieve the players current position.

Return values
	x
X zone coordinate of the player
	y
Y zone coordinate of the player
	currentPlayerZoneMapID
The MapID of the zone
	currentPlayerLevel
The map level the player is on
	currentMapFile
The map file of the current zone (can be a micro dungeon map)
	currentMapIsMicroDungeon
True if the player is currently in a micro dungeon]]


-- IDкарты, имя, x, y, комментарий с названием карты


