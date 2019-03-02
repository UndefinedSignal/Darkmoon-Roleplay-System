function RPSCoreFramework:AddPinCoords(zoneid, icon, name, x, y)
	table.insert(RPSCoreFramework.DB.Pins, {zoneid, icon, name, x, y})
	return true
end


--GUID, MapId, x, y,  type, Name,  Description
function RPSCoreFramework:InsertPinOnMap(guid, mapid, x, y, ptype, name, description)

--	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
-- local p,f,x,y,w,h=WorldMapButton f=CrT or CreateFrame("Button","CrT",p) f:SetSize(16,16) f:SetNormalTexture("")
	local p = WorldMapButton
	local IFrame = CreateFrame("Button", "POI-"..guid, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture("Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\"..ptype)
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
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

--RPSCoreFramework:InsertPinOnMap("Meme", "Interface\\MINIMAP\\TrapActive_Grey.blp", 974, 6333.3002929688, -4291.8999023438)


function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, x, y, ptype, name, description)

--	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local p = WorldMapButton
	local IFrame = CreateFrame("Button", "POITex-"..guid, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture("Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\"..ptype)
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
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