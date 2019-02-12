-- RPSCoreFramework.Map = {}
-- RPSCoreFramework.DB.Pins = {}

function RPSCoreFramework:AddPinCoords(zoneid, icon, name, x, y)
	table.insert(RPSCoreFramework.DB.Pins, {zoneid, icon, name, x, y})
	return true
end

function RPSCoreFramework:InsertPinOnMap(icon_name, icon_path, zoneid, x, y)

	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POI"..RPSCoreFramework.POIIterator;

-- local p,f,x,y,w,h=WorldMapButton f=CrT or CreateFrame("Button","CrT",p) f:SetSize(16,16) f:SetNormalTexture("")
	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture(icon_path)
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..icon_name);
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end)

	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(RPSCoreFramework, IFrame, zoneid, x, y)
	return true
end

--RPSCoreFramework:InsertPinOnMap("Meme", "Interface\\MINIMAP\\TrapActive_Grey.blp", 974, 6333.3002929688, -4291.8999023438)


function RPSCoreFramework:InsertPinOnMiniMap(icon_name, icon_path, zoneid, x, y)

	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POITex"..RPSCoreFramework.POIIterator;

	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture(icon_path)
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffffcc00"..icon_name);
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide()
		      	end)

	RPSCoreFramework.HBD.Pins:AddMinimapIconWorld(RPSCoreFramework, IFrame, zoneid, x, y, false)
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
-- RPSCoreFramework:InsertPinOnMap("Interface\\MINIMAP\\TrapActive_Grey.blp", 301, 0.504987, 0.903770)
function RPSCoreFramework:TakePinIcon()
	--RPSCoreFramework.Map.Icons

	local icon = "Interface\\MINIMAP\\TrapActive_Grey.blp";

	return icon;
end

--function RPSCoreFramework:GeneratePinButtons()
--	RPSCoreFramework.Map.PinButtons
--end

function RPSCoreFramework:GetPlayerPosition()
	local x,y, instanceID = RPSCoreFramework.HBD:GetPlayerWorldPosition();
	print("X: "..x.." Y: "..y.. " instanceID: "..instanceID)
end



function RPSCoreFramework:GeneratePOIPlaces()
	for k, v in pairs(RPSCoreFramework.Map.PinButtons) do
		RPSCoreFramework:InsertPinOnMap(v[1], v[2], v[5], v[3], v[4]);
		RPSCoreFramework:InsertPinOnMiniMap(v[1], v[2], v[5], v[3], v[4]);
	end
	print("POI Generation")
	return true
end

function RPSCoreFramework:POIPreGenerate()
	RPSCoreFramework:FlushAllPinsOnMap();
	if GetCurrentMapZone() ~= 0 then
		RPSCoreFramework:GeneratePOIPlaces();
		return true;
	end
	return false;
end


--[[Retrieve the zone information the player is currently in.
{"Tavern", "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\inn", 0.504987, 0.903770, 301},
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






