function RPSCoreFramework:PreGenerateShowAuras()
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #RPSCoreFramework.Interface.Auras do
		table.insert(RPSCoreFramework.Interface.Auras.Show, i);
	end
end

function RPSCoreFramework:AurasSearch(input, key)
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #input do
		if string.find(input[i][1],key) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		elseif string.find(input[i][2],key) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
	end
end