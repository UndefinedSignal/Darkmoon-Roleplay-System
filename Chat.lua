function RPSCoreFramework:UpdateTypingStatus(editbox)
	local chatType = editbox:GetAttribute("chatType")
	local text = editbox:GetText()
	local firstChar = text:sub(1, 1)
	if (editbox:IsShown() and text:len() > 0 and firstChar ~= "/" and firstChar ~= "." and firstChar ~= "!" and firstChar ~= "#" and (chatType == "SAY" or chatType == "YELL" or chatType == "EMOTE")) then
		if not self.isTypingMessage then
			self.isTypingMessage = true
			RPSCoreFramework:SendCoreMessage(".typing on")
		end
	else
		if self.isTypingMessage then
			self.isTypingMessage = false
			RPSCoreFramework:SendCoreMessage(".typing off")
		end
	end
end

function sysMsg(self, event, msg, author, ...)
	if (string.find(msg, "RPS.StatMe")) then
		RPSCoreFramework:UpdateInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.Scale")) then
		RPSCoreFramework:UpdateScaleInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.AuraKnown")) then
		RPSCoreFramework:UpdateAuraKnownInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.AuraActive")) then
		RPSCoreFramework:UpdateAuraActiveInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.Display")) then
		RPSCoreFramework:UpdateDisplayMacrosInfo(msg);
		return true;
	elseif (string.find(msg, "RPS.AuraRefresh")) then
		RPSCoreFramework:RefreshActiveAuras(msg);
		return true;
	end
end

local AddonMessageHandler = CreateFrame("Frame");
AddonMessageHandler:RegisterEvent("CHAT_MSG_ADDON");
AddonMessageHandler:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender)
	if (prefix == "RPS.POI") then
		RPSCoreFramework:UpdatePOIPins(msg)
	elseif (prefix ==  "RPS.StatMe") then
		RPSCoreFramework:UpdateInfo(msg);
	elseif (prefix == "RPS.Scale") then
		RPSCoreFramework:UpdateScaleInfo(msg);
	elseif (prefix == "RPS.AuraKnown") then
		RPSCoreFramework:UpdateAuraKnownInfo(msg);
	elseif (prefix == "RPS.AuraActive") then
		RPSCoreFramework:UpdateAuraActiveInfo(msg);
	elseif (prefix == "RPS.Display") then
		RPSCoreFramework:UpdateDisplayMacrosInfo(msg);
	elseif (prefix == "RPS.AuraRefresh") then
		RPSCoreFramework:RefreshActiveAuras(msg);
	end
end)

function RPSCoreFramework:SendCoreMessage(msg)
	SendAddonMessage(RPSCoreFramework.Prefix, msg, "WHISPER", UnitName("player"));
end;

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", sysMsg);