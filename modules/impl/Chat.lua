
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

function RPSCoreFramework:UpdateChatEdit(editbox)
	editbox:SetMaxLetters(0);
	editbox:SetMaxBytes(0);
	if (editbox.SetVisibleTextByteLimit) then
		editbox:SetVisibleTextByteLimit(0)
	end
end

function RPSCoreFramework:SendCoreMessage(msg)
	msg = "."..msg;
	C_ChatInfo.SendAddonMessage(RPSCoreFramework.Prefix, msg, "WHISPER", UnitName("player"));
end

local table_getn = _G.table.getn;
local table_insert = _G.table.insert;
local tostring_ = _G.tostring;
local tonumber_ = _G.tonumber;

local function paddString(str, paddingChar, minLength, paddRight)
    str = tostring_(str or "");
    paddingChar = tostring_(paddingChar or " ");
    minLength = tonumber_(minLength or 0);
    while(str:len() < minLength) do
        if(paddRight) then
            str = str..paddingChar;
        else
            str = paddingChar..str;
        end
    end
    return str;
end

local function SplitIntoChunks(longMsg)
	local splitMessageLinks = {};
	
	--Replace links with long strings of zeroes.
	longMsg, results = longMsg:gsub( "(|H[^|]+|h[^|]+|h)", function(theLink)
			table_insert(splitMessageLinks, theLink);
			return "\001\002"..paddString(#splitMessageLinks, "0", theLink:len()-4).."\003\004";
	end);
	
	--WoW replaces tabs with 4 spaces, lets replace 4 spaces with '$tab' so that our splitting of words doesn't remove the tab spaces.
	if longMsg:find(RPSCoreFramework.TabSpaces) then
		while longMsg:find(RPSCoreFramework.TabSpaces) do
			longMsg = longMsg:gsub(RPSCoreFramework.TabSpaces, "$tab");
		end
	end
	
	local words = {}
	for v in longMsg:gmatch("[^ ]+") do
		--Check if 'word' is longer then 254 characters. (wtf?) anyway split long string at the 254 char mark.
		if v:len() > RPSCoreFramework.ChatMaxLetters then
			local shortPart, remainingPart = nil, v;
			local i=1;
			while remainingPart and remainingPart:len() > 0 do
				shortPart, remainingPart = GetShorterString(remainingPart);
				if shortPart and shortPart ~= "" then
					table_insert(words, shortPart)
				end
				
				if i>10 then break; end
				i=i+1;
			end
		else
			table_insert(words, v)
		end
	end

	local temp = "";
	local chunks = {}
	for i=1, table_getn(words) do 
		if temp:len() + words[i]:len() <= (RPSCoreFramework.ChatMaxLetters - 6) then
			if temp:len() > 0 then
				temp = temp.." "..words[i];
			else
				temp = words[i];
			end
			
		else
			temp = temp:gsub("\001\002%d+\003\004", function(link)
				local index = tonumber_(link:match("(%d+)"));
				return splitMessageLinks[index] or link;
			end);
			
			if temp:find("$tab") then
				while temp:find("$tab") do
					temp = temp:gsub("$tab", RPSCoreFramework.TabSpaces);
				end
			end
			
			table_insert(chunks, temp);
			temp = words[i];
		end
	end

	if temp:len() > 0 then
		temp = temp:gsub("\001\002%d+\003\004", function(link)
			local index = tonumber_(link:match("(%d+)"));
			return splitMessageLinks[index] or link;
		end);
		
		if temp:find("$tab") then
			while temp:find("$tab") do
				temp = temp:gsub("$tab", RPSCoreFramework.TabSpaces);
			end
		end
			
		table_insert(chunks, temp);
	end
	
	return chunks;
end

-- UTF-8 Reference:
-- 0xxxxxxx - 1 byte UTF-8 codepoint (ASCII character)
-- 110yyyxx - First byte of a 2 byte UTF-8 codepoint
-- 1110yyyy - First byte of a 3 byte UTF-8 codepoint
-- 11110zzz - First byte of a 4 byte UTF-8 codepoint
-- 10xxxxxx - Inner byte of a multi-byte UTF-8 codepoint
 
local function chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end
 
-- This function can return a substring of a UTF-8 string, properly handling
-- UTF-8 codepoints.  Rather than taking a start index and optionally an end
-- index, it takes the string, the starting character, and the number of
-- characters to select from the string.
 
local function utf8sub(str, startByte, numBytes)
  local currentIndex = startByte
  local returnedBytes = 0;
 
  while numBytes > 0 and currentIndex <= #str do
    local char = string.byte(str, currentIndex)
    currentIndex = currentIndex + chsize(char)
    numBytes = numBytes - chsize(char)
	returnedBytes = returnedBytes + chsize(char)
  end
  return str:sub(startByte, currentIndex - 1), returnedBytes
end

local function GetShorterString(longMsg)
	local shortText, sizeBytes = utf8sub(longMsg, 1, RPSCoreFramework.ChatMaxLetters - 1)
	local remainingPart = longMsg:sub(sizeBytes + 1, longMsg:len())
	return shortText, remainingPart;
end

function RPSCoreFramework:SendLongChatMessage(...)
	local msg, chatType, language, channel = ...;

	if (string.len(msg) > RPSCoreFramework.ChatMaxLetters) then
		local chunks = SplitIntoChunks(msg);
		for i=1, table_getn(chunks) do
			_G.ChatThrottle.SendChatMessage("ALERT", "UCM", chunks[i], chatType ,language ,channel);
		end
		return;
	end
	RPSCoreFramework.hooks.SendChatMessage(msg, chatType ,language ,channel);
end
