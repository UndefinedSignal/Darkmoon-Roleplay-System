function RPSCoreFramework:PreGenerateShowAuras()
	RPSCoreFramework.Interface.Auras.Show = {}
    if DarkmoonAurasFrameFavCheckBox:GetChecked() then
        for i=1, #RPSCoreFavourites do
            table.insert(RPSCoreFramework.Interface.Auras.Show, RPSCoreFavourites[i]);
        end

        if RPSCoreFramework.Interface.Auras.Bought then
        	RPSCoreFramework.Interface.Auras.Bought = true;
            RPSCoreFramework:BoughtAurasSearch(RPSCoreFramework.Interface.Auras);
            RPSCoreFramework:GenerateScrollMenu();
            DarkmoonAurasFrame.Owned:LockHighlight();
        else
        	RPSCoreFramework.Interface.Auras.Bought = false;
            DarkmoonAurasFrame.Owned:UnlockHighlight();
        end
    else
		for i=1, #RPSCoreFramework.Interface.Auras do
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
    end
end

function RPSCoreFramework:AurasSearch(input, key)
	RPSCoreFramework.Interface.Auras.Show = {}
	
	if (_G["DarkmoonAurasFrameFavCheckBox"]:GetChecked()) then
		input = {};
		for i = 1, #RPSCoreFavourites do
			table.insert(input, RPSCoreFramework.Interface.Auras[RPSCoreFavourites[i]]);
		end
	end

	for i=1, #input do
		if string.find(strlower(input[i][2]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, input[i][1]);
		elseif string.find(strlower(input[i][3]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, input[i][1]);
		elseif string.find(strlower(input[i][1]), strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, input[i][1]);
		end
	end
end

function RPSCoreFramework:BoughtAurasSearch(input)
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #input do
		if input[i][5] > 0 then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
	end
end

function RPSCoreFramework:FavouritesSearch(number)
    for i = 1, #RPSCoreFavourites do
        if RPSCoreFavourites[i] == number then
            return i;
        end
    end
    return false
end

function RPSCoreFramework:POISearchTable(key)
	RPSCoreFramework.POISearch = {};
	local i = 1;
    for k, v in pairs(RPSCorePOIPins) do
    	if string.find(strlower(v[8]),strlower("^.+??????????.+("..UnitName("player")..")[%s\.,].+$")) ~= nil then
    		table.insert(RPSCoreFramework.POISearch, {v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]})
	    end
    end
end

function RPSCoreFramework:OwnPOIListShow()
	for i = 1, 16 do
		_G["POISearchContentChildbtn"..i]:Hide();
	end
	for i = 1, #RPSCoreFramework.POISearch do
		if i <= 16 then
			_G["POISearchContentChildbtn"..i.."ID"]:SetText("|cFFFF8040"..RPSCoreFramework.POISearch[i][1])
			_G["POISearchContentChildbtn"..i.."Title"]:SetText(RPSCoreFramework.POISearch[i][7]);
			_G["POISearchContentChildbtn"..i.."Description"]:SetText(RPSCoreFramework.POISearch[i][8]);
			_G["POISearchContentChildbtn"..i.."POITex"]:SetTexture("Interface\\AddOns\\RPSDarkmoon\\resources\\POI\\"..RPSCoreFramework.POISearch[i][5]);
			_G["POISearchContentChildbtn"..i].FuncTable = {RPSCoreFramework.POISearch[i][1], RPSCoreFramework.POISearch[i][2], RPSCoreFramework.POISearch[i][3], RPSCoreFramework.POISearch[i][4], RPSCoreFramework.POISearch[i][5], RPSCoreFramework.POISearch[i][6], RPSCoreFramework.POISearch[i][7], RPSCoreFramework.POISearch[i][8]}
			_G["POISearchContentChildbtn"..i]:Show();
		end
	end
end