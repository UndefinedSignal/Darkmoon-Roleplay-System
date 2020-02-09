function RPSCoreFramework:PreGenerateShowAuras()
	RPSCoreFramework.Interface.Auras.Show = {}
    if DarkmoonAurasFrameFavCheckBox:GetChecked() then
        for i=1, #RPSCoreFavourites do
            table.insert(RPSCoreFramework.Interface.Auras.Show, RPSCoreFavourites[i]);
        end
    else
		for i=1, #RPSCoreFramework.Interface.Auras do
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		end
    end
end

function RPSCoreFramework:AurasSearch(input, key)
	RPSCoreFramework.Interface.Auras.Show = {}
	for i=1, #input do
		if string.find(strlower(input[i][2]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		elseif string.find(strlower(input[i][3]),strlower(key)) ~= nil then
			table.insert(RPSCoreFramework.Interface.Auras.Show, i);
		elseif string.find(strlower(input[i][1]), strlower(key)) ~= nil then
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


function RPSCoreFramework:AddGuildSalaryTab()
	local TabName="Зарплата";
	 
	local TabID=GuildInfoFrame.numTabs+1;
	local Tab=CreateFrame("Button","$parentTab"..TabID,GuildInfoFrame,"GuildInfoSalaryTemplate",TabID);
	PanelTemplates_SetNumTabs(GuildInfoFrame,TabID);
	Tab:SetPoint("LEFT","$parentTab"..(TabID-1),"RIGHT",0,0);
	Tab:SetText(TabName);
	PanelTemplates_TabResize(GuildInfoFrameTab4, 0);

	local d,p,a,x,y = GuildInfoFrameTab1:GetPoint();
	GuildInfoFrameTab1:SetPoint(d,p,a,x-16,y);

	local Panel=CreateFrame("Frame",nil,GuildInfoFrame);
	Panel:SetAllPoints(GuildInfoFrame);
end

function RPSCoreFramework:GuildSalaryFrameLink()
	GuildInfoFrameTab1:Show();

	if(GuildInfoFrameTab3:IsShown()) then
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..3,"RIGHT",0,0);
	elseif(GuildInfoFrameTab2:IsShown()) then
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..2,"RIGHT",0,0);
	else
		GuildInfoFrameTab4:SetPoint("LEFT","$parentTab"..1,"RIGHT",0,0);
	end
end
