-- RPSCoreFramework.Map = {}
-- RPSCoreFramework.DB.Pins = {}

function RPSCoreFramework:AddPinCoords(zoneid, icon, name, x, y)
	table.insert(RPSCoreFramework.DB.Pins, {zoneid, icon, name, x, y})
	return true
end

function RPSCoreFramework:InsertPinOnMap(icon_frame, zoneid, x, y)
	RPSCoreFramework.HDB.Pins:AddWorldMapIconMF(RPSCoreFramework, icon_frame, zoneid, nil, x, y, false)
	return true
end

function RPSCoreFramework:InsertPinOnMiniMap(icon_frame, zoneid, x, y)
	RPSCoreFramework.HDB.Pins:AddMinimapIconMF(RPSCoreFramework, icon_frame, zoneid, nil, x, y, false)
	return true
end

function RPSCoreFramework:FlushAllPinsOnMap()
	RPSCoreFramework.HDB.Pins:RemoveAllWorldMapIcons(RPSCoreFramework)
	return true
end

function RPSCoreFramework:FlushAllPinsOnMiniMap()
	RPSCoreFramework.HDB.Pins:RemoveAllMinimapIcons(RPSCoreFramework)
	return true
end

function RPSCoreFramework:TakePinIcon()
	local icon = ""
	--RPSCoreFramework.Map.Icons
	return icon
end

--function RPSCoreFramework:GeneratePinButtons()
--	RPSCoreFramework.Map.PinButtons
--end