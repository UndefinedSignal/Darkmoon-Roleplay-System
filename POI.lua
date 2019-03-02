function RPSCoreFramework:AddPinCoords(zoneid, icon, name, x, y)
	table.insert(RPSCoreFramework.DB.Pins, {zoneid, icon, name, x, y})
end


--GUID, MapId, x, y,  type, Name,  Description
function RPSCoreFramework:InsertPinOnMap(guid, mapid, x, y, type, name, descr)
--	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POI-"..guid;
-- local p,f,x,y,w,h=WorldMapButton f=CrT or CreateFrame("Button","CrT",p) f:SetSize(16,16) f:SetNormalTexture("")
	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture("Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\".."type") -- TODO TYPE
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name);
				    GameTooltip:AddLine("|cffFF8040"..descr);
				    GameTooltip:Show();
				    end)
	IFrame:SetScript("OnLeave", function()
				    GameTooltip:Hide();
		      	end)

	RPSCoreFramework.HBD.Pins:AddWorldMapIconWorld(RPSCoreFramework, IFrame, mapid, x, y)
end

--RPSCoreFramework:InsertPinOnMap("Meme", "Interface\\MINIMAP\\TrapActive_Grey.blp", 974, 6333.3002929688, -4291.8999023438)


function RPSCoreFramework:InsertPinOnMiniMap(guid, mapid, x, y, type, name, descr)
--	RPSCoreFramework.POIIterator = RPSCoreFramework.POIIterator + 1;
	local name = "POITex-"..guid;

	local p = WorldMapButton
	local IFrame = CreateFrame("Button", name, p)
	if WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:IsShown() then
		IFrame:SetSize(24,24);
	else
		IFrame:SetSize(18,18);
	end

	local ntex = IFrame:CreateTexture()
	ntex:SetTexture("Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\".."type") -- TODO TYPE
	ntex:SetVertexColor(0.5, 0.5, 0.5) -- https://wow.gamepedia.com/Power_colors
	ntex:SetAllPoints()
	IFrame:SetNormalTexture(ntex)

	IFrame:SetScript("OnEnter", function()
		        	GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
				    GameTooltip:AddLine("|cffFFC125"..name);
				    GameTooltip:AddLine("|cffFF8040"..descr);
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
	if #RPSCorePOIPins > 0 then
		for i = 1, #RPSCorePOIPins do
			RPSCoreFramework:InsertPinOnMap(RPSCorePOIPins[i][1], RPSCorePOIPins[i][2], RPSCorePOIPins[i][5], RPSCorePOIPins[i][3], RPSCorePOIPins[i][4], RPSCorePOIPins[i][5], RPSCorePOIPins[i][6], RPSCorePOIPins[i][7]);
			RPSCoreFramework:InsertPinOnMiniMap(RPSCorePOIPins[i][1], RPSCorePOIPins[i][2], RPSCorePOIPins[i][5], RPSCorePOIPins[i][3], RPSCorePOIPins[i][4], RPSCorePOIPins[i][5], RPSCorePOIPins[i][6], RPSCorePOIPins[i][7]);
		end
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