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

function RPSCoreFramework:SendCoreMessage(msg)
	SendAddonMessage("DRPS", msg, "WHISPER", UnitName("player"));
end;


ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", sysMsg)