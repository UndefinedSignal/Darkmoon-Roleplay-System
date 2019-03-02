function RPSCoreFramework:PreGenerateShowAuras()
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #RPSCoreFramework.Interface.Auras do
		table.insert(RPSCoreFramework.Interface.Auras.Show, i);
	end
end

function RPSCoreFramework:AurasSearch(input, key)
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #input do
		if string.find(strlower(input[i][2]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		elseif string.find(strlower(input[i][3]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
	end
end

function RPSCoreFramework:GetExistingPOIGUID(guid)
	for i=1, #RPSCorePOIPins do
		if string.find(RPSCorePOIPins[i][1], guid) ~= nil then
			return i; -- Position of existig guid
		end
	end
	return false;
end
