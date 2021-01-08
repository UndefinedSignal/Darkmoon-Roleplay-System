function GameObjectPreview_OnShow(frame)
	print("Memes")
end

function RPSCoreFramework:SwitchHide()
	if(GameObjectPreview:IsShown())then
		GameObjectPreview:Hide();
	else
		GameObjectPreview:Show();
	end
end

function RPSCoreFramework:GobPreviewAction(guid,mode)
	local mguid = DMAUserVars["LastGOB-GUID"] or guid;
	local value = tonumber(GameObjectPreviewEditBox:GetText()) or 1;
	local memeaction = {
		["front"] = function(x) msg = "gob move prelative "..mguid.." "..value.." 0 0"; end,
		["back"] = function(x) msg = "gob move prelative "..mguid.." "..-value.." 0 0"; end,
		["right"] = function(x) msg = "gob move prelative "..mguid.." 0 "..value.." 0"; end,
		["left"] = function(x) msg = "gob move prelative "..mguid.." 0 "..-value.." 0"; end,
		["top"] = function(x) msg = "gob move prelative "..mguid.." 0 0 "..value; end,
		["down"] = function(x) msg = "gob move prelative "..mguid.." 0 0 "..-value; end,
		["rright"] = function(x) msg = "gob turn rel "..mguid.." "..value.." 0 0"; end,
		["rleft"] = function(x) msg = "gob turn rel "..mguid.." "..-value.." 0 0"; end,
		["cancel"] = function(x) print("cancel"); end,
		["accept"] = function(x) print(" "); end
	}
	memeaction[mode]();
	RPSCoreFramework:SendCoreMessage(msg);
end