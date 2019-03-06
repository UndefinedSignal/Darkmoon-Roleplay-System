local POIPath = "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\";

--GUID, MapId, x, y, type, color, Name, Description
function RPSCoreFramework:InsertPinOnMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POI-"..guid, WorldMapButton);

	RPSPOIGameTooltip:ClearLines();
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(18,18);
		RPSPOIGameTooltip:SetFrameStrata("TOOLTIP");
		IFrame:SetFrameStrata("TOOLTIP");
	else
		IFrame:SetSize(24,24);
		RPSPOIGameTooltip:SetFrameStrata("DIALOG");
		IFrame:SetFrameStrata("DIALOG");
	end


	local ntex = IFrame:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);

	ntex:SetVertexColor(r, g, b, 0.9); -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints();
	IFrame:SetNormalTexture(ntex);
	IFrame:SetHighlightTexture("Interface\\BUTTONS\\IconBorder-GlowRing")

	IFrame:SetScript("OnEnter", function()
		        	RPSPOIGameTooltip:SetOwner(WorldMapDetailFrame, "ANCHOR_CURSOR");
				    RPSPOIGameTooltip:AddLine("|cffFFC125"..name.."|r");

					if (string.len(description) > 0) then
						RPSPOIGameTooltip:AddLine("|cffFF8040"..description.."|r");
					end
				    RPSPOIGameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    RPSPOIGameTooltip:Hide();
		      	end)

	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(RPSCoreFramework, IFrame, tonumber(mapid), tonumber(x), tonumber(y));
end

function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, y, x, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POITex-"..guid, WorldMapButton);
	IFrame:SetSize(18,18);

	local ntex = IFrame:CreateTexture();
	ntex:SetTexture(POIPath..ptype);
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r, g, b, 0.9); -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints();
	IFrame:SetNormalTexture(ntex);

	IFrame:SetScript("OnEnter", function()
		        	RPSPOIGameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    RPSPOIGameTooltip:AddLine("|cffFFC125"..name.."|r");
				    if (string.len(description) > 0) then
						RPSPOIGameTooltip:AddLine("|cffFF8040"..description.."|r");
					end
				    RPSPOIGameTooltip:Show();
				    end);
	IFrame:SetScript("OnLeave", function()
				    RPSPOIGameTooltip:Hide();
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

    if GetCurrentMapZone() ~= 0 and RPSCoreFramework.Map.POIWorkflow and RPSCoreShowPOIPins then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]);
        end
    end
	if RPSCoreFramework.Map.POIWorkflow then
        for k, v in pairs(RPSCorePOIPins) do
            RPSCoreFramework:InsertPinOnMiniMap(v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]); -- Always must be a Pins on mini-map
        end
    end
end