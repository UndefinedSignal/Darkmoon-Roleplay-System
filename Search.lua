function RPSCoreFramework:Search(input, key)
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #input do
		if string.find(RPSCoreFramework.Interface.Auras[i][1],key) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		elseif string.find(RPSCoreFramework.Interface.Auras[i][2],key) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
	end 
end

function RPSCoreFramework:PreGenerateShowAuras()
	for i=1, #RPSCoreFramework.Interface.Auras do
		table.insert(RPSCoreFramework.Interface.Auras.Show, i);
	end
end
-- RPSCoreFramework:Search(RPSCoreFramework.Interface.Auras, "Аура")