local POIPath = "Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\";

--GUID, MapId, x, y, type, color, Name, Description
function RPSCoreFramework:InsertPinOnMap(guid, mapid, x, y, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POI-"..guid, WorldMapButton)
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
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name.."|r");
				    GameTooltip:AddLine("|cffFF8040"..description.."|r");
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end)

	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(RPSCoreFramework, IFrame, mapid, x, y)
end

function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, x, y, ptype, color, name, description)
	local IFrame = CreateFrame("Button", "POITex-"..guid, WorldMapButton)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture(POIPath..ptype)
	local r, g, b = RPSCoreFramework:hex2rgb("#"..color);
	ntex:SetVertexColor(r/255, g/255, b/255); -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name.."|r");
				    GameTooltip:AddLine("|cffFF8040"..description.."|r");
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide()
		      	end)

	RPSCoreFramework.HBD.Pins:AddMinimapIconWorld(RPSCoreFramework, IFrame, mapid, x, y, false)
end

function RPSCoreFramework:FlushAllPinsOnMap()
	RPSCoreFramework.HBD.Pins:RemoveAllWorldMapIcons(RPSCoreFramework)
end

function RPSCoreFramework:FlushAllPinsOnMiniMap()
	RPSCoreFramework.HBD.Pins:RemoveAllMinimapIcons(RPSCoreFramework)
end

function RPSCoreFramework:GeneratePOIPlaces()
	for i = 1, #RPSCorePOIPins do
		RPSCoreFramework:InsertPinOnMap(RPSCorePOIPins[i][1], RPSCorePOIPins[i][2], RPSCorePOIPins[i][5], RPSCorePOIPins[i][3], RPSCorePOIPins[i][4], RPSCorePOIPins[i][5], RPSCorePOIPins[i][6], RPSCorePOIPins[i][7]);
		RPSCoreFramework:InsertPinOnMiniMap(RPSCorePOIPins[i][1], RPSCorePOIPins[i][2], RPSCorePOIPins[i][5], RPSCorePOIPins[i][3], RPSCorePOIPins[i][4], RPSCorePOIPins[i][5], RPSCorePOIPins[i][6], RPSCorePOIPins[i][7]);
	end
end

function RPSCoreFramework:POIPreGenerate()
	RPSCoreFramework:FlushAllPinsOnMap();
	if GetCurrentMapZone() ~= 0 then
		RPSCoreFramework:GeneratePOIPlaces();
		return true;
	end
	return false;
end


--[[
function RPSCoreFramework:GetPlayerPosition()
	local x,y, instanceID = RPSCoreFramework.HBD:GetPlayerWorldPosition();
	print("X: "..x.." Y: "..y.. " instanceID: "..instanceID)
end
]]