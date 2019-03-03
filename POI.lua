local POIPath = "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\";

--GUID, MapId, x, y, type, color, Name, Description
function RPSCoreFramework:InsertPinOnMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POI-"..guid, WorldMapButton);
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r/255, g/255, b/255); -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints();
	IFrame:SetNormalTexture(ntex);

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name.."|r");
				    GameTooltip:AddLine("|cffFF8040"..description.."|r");
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end)
	IFrame:SetFrameStrata("DIALOG");

	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(RPSCoreFramework, IFrame, tonumber(mapid), tonumber(x), tonumber(y));
end

function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POITex-"..guid, WorldMapButton);
	IFrame:SetSize(18,18);

	local ntex = IFrame:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r/255, g/255, b/255); -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints();
	IFrame:SetNormalTexture(ntex);

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name.."|r");
				    GameTooltip:AddLine("|cffFF8040"..description.."|r");
				    GameTooltip:Show();
				    end);
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end);

	RPSCoreFramework.HBD.Pins:AddMinimapIconWorld(RPSCoreFramework, IFrame, tonumber(mapid), tonumber(x), tonumber(y), false);
end

function RPSCoreFramework:FlushAllPinsOnMap()
	RPSCoreFramework.HBD.Pins:RemoveAllWorldMapIcons(RPSCoreFramework);
end

function RPSCoreFramework:FlushAllPinsOnMiniMap()
	RPSCoreFramework.HBD.Pins:RemoveAllMinimapIcons(RPSCoreFramework);
end

function RPSCoreFramework:GeneratePOIPlaces()
    RPSCoreFramework:FlushAllPinsOnMap();
    RPSCoreFramework:FlushAllPinsOnMiniMap();
    if GetCurrentMapZone() ~= 0 and AllowPOIUpdate and RPSCoreShowPOIPins then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
            RPSCoreFramework:InsertPinOnMiniMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
        end
        return true;
    elseif AllowPOIUpdate then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMiniMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]); -- Always must be a Pins on mini-map
        end
    end
    return false;
end