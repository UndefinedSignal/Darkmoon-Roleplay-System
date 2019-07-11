function RPSCoreFramework:UpdateTypingStatus(editbox)
	local chatType = editbox:GetAttribute("chatType")
	local text = editbox:GetText()
	local firstChar = text:sub(1, 1)
	if (editbox:IsShown() and text:len() > 0 and firstChar ~= "/" and firstChar ~= "." and firstChar ~= "!" and firstChar ~= "#" and (chatType == "SAY" or chatType == "YELL" or chatType == "EMOTE")) then
		if not self.isTypingMessage then
			self.isTypingMessage = true
			RPSCoreFramework:SendCoreMessage("typing on")
		end
	else
		if self.isTypingMessage then
			self.isTypingMessage = false
			RPSCoreFramework:SendCoreMessage("typing off")
		end
	end
end

function RPSCoreFramework:SendCoreMessage(msg)
	msg = "."..msg;
	C_ChatInfo.SendAddonMessage(RPSCoreFramework.Prefix, msg, "WHISPER", UnitName("player"));
end