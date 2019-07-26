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

function RPSCoreFramework:InsertPinOnMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = RPSCoreFramework:GetMapPOIPin(guid, color, ptype, name, description);
	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(self, IFrame, tonumber(mapid), tonumber(x), tonumber(y));
end

function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrames = RPSCoreFramework:GetMiniMapPOIPin(guid, color, ptype, name, description);
	RPSCoreFramework.HBD.Pins:AddMinimapIconWorld(self, IFrames, tonumber(mapid), tonumber(x), tonumber(y), false);
end

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