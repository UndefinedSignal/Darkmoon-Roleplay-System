local POIPath = "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\";
local POIHL = "Interface\\BUTTONS\\IconBorder-GlowRing";
local MapPinPool = {};
local MiniMapPinPool = {};

function RPSCoreFramework:GetMapPOIPin(guid, color, ptype, name, description)
	local pin = MapPinPool["POIM"..guid];
	if (pin ~= nil) then
		return pin;
	end
		
	pin = CreateFrame("Button", "POIM"..guid, WorldMapButton, "RPS_POIButton");
	pin.used = true;
	pin.dataName = name;
	pin.debugGuid = guid;
	pin.dataDescription = description;
	pin:SetSize(14,14);
	RPSPOIGameTooltip:SetFrameStrata("TOOLTIP");
	pin:SetFrameStrata("TOOLTIP");
	local ntex = pin:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r, g, b, 0.9);
	ntex:SetAllPoints();
	pin:SetNormalTexture(ntex);
	pin:SetHighlightTexture(POIHL);
	MapPinPool["POIM"..guid] = pin;
	return pin;
end

function RPSCoreFramework:GetMiniMapPOIPin(guid, color, ptype, name, description)
	local pin = MiniMapPinPool["POIMM"..guid];
	if (pin ~= nil) then
		return pin;
	end

	local pin = CreateFrame("Button", "POIMM"..guid, WorldMapButton, "RPS_POIButton");
	pin.dataName = name;
	pin.debugGuid = guid;
	pin.dataDescription = description;
	pin:SetSize(14,14);
	local ntex = pin:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r, g, b, 0.9);
	ntex:SetAllPoints();
	pin:SetNormalTexture(ntex);
	pin:SetHighlightTexture(POIHL);
	MiniMapPinPool["POIMM"..guid] = pin;
	return pin;
end

--[[
		local mapID, level, mapFile = RPSCoreFramework.HBD.Migrate:GetLegacyMapInfo(uiMapID)
		if not mapFile then
			return next, emptyTbl
		end
		local iter, data, state = handler:GetNodes(mapFile, minimap, level)
		local t = { mapFile = mapFile, level = level, iter = iter, data = data }
		return LegacyNodeIterator, t, state

HBDPins:AddMinimapIconMap("HandyNotes" .. pluginName, icon, uiMapID2 or uiMapID, x, y, true)
--- Add a icon to the minimap (UiMapID zone coordinate version)
-- The pin will only be shown on the map specified, or optionally its parent map if specified
-- @param ref Reference to your addon to track the icon under (ie. your "self" or string identifier)
-- @param icon Icon Frame
-- @param uiMapID uiMapID of the map to place the icon on
-- @param x X position in local/point coordinates (0-1), relative to the zone
-- @param y Y position in local/point coordinates (0-1), relative to the zone
-- @param showInParentZone flag if the icon should be shown in its parent zone - ie. an icon in a microdungeon in the outdoor zone itself (default false)
-- @param floatOnEdge flag if the icon should float on the edge of the minimap when going out of range, or hide immediately (default false)
]]

-- RPSCoreFramework:InsertPinOnMapAdv(7001, 0, -236.99, -9653.34, "city", "FF0000", "Memes123", "meemz")
function RPSCoreFramework:InsertPinOnMapAdv(guid, mapid, y, x, ptype, color, name, description)
	local IFrames = RPSCoreFramework:GetMiniMapPOIPin(guid, color, ptype, name, description);
	RPSCoreFramework.HBD.Pins:AddMinimapIconMap(self, IFrames, mapid, x, y, true);
end

-- RPSCoreFramework:InsertPinOnMiniMap(2357, 245, 1368.787720, -290.922150, "conflict", "FF0000", "Опасная зона", "Оче опасна")
-- RPSCoreFramework:InsertPinOnMap(2357, 732, 1368.787720, -290.922150, "conflict", "FF0000", "Опасная зона", "Оче опасна")
function RPSCoreFramework:InsertPinOnMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = RPSCoreFramework:GetMapPOIPin(guid, color, ptype, name, description);
	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(self, IFrame, tonumber(mapid), tonumber(x), tonumber(y));
end

function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrames = RPSCoreFramework:GetMiniMapPOIPin(guid, color, ptype, name, description);
	RPSCoreFramework.HBD.Pins:AddMinimapIconWorld(self, IFrames, tonumber(mapid), tonumber(x), tonumber(y));
end

-- 41.173183 ZoneY: 46.05968
-- ref, icon, uiMapID, x, y, showFlag, frameLevelType 
-- RPSCoreFramework:InsertPinOnMap(6020, 95, -6764.55, 7357.34, "city", "FF0000", "Мемное", "TopMemes")

function RPSCoreFramework:FlushAllPinsOnMap()
	RPSCoreFramework.HBD.Pins:RemoveAllWorldMapIcons(self);
end

function RPSCoreFramework:FlushAllPinsOnMiniMap()
	RPSCoreFramework.HBD.Pins:RemoveAllMinimapIcons(self);
end


function RPSCoreFramework:GeneratePOIPlaces()
    RPSCoreFramework:FlushAllPinsOnMap();
    RPSCoreFramework:FlushAllPinsOnMiniMap();

    if (RPSCoreFramework.Map.POIWorkflow) then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMiniMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
        end
    end
    if (RPSCoreFramework.Map.POIWorkflow and RPSCoreShowPOIPins) then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
            
        end
    end
end