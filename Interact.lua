function RPSCoreFramework:IsInteractCast()
	local name, _, _, _, _, _, _, _, _, _ = UnitCastingInfo("player");
	if (name == "Помочь" or name == "Добить") then
		return true;
	else
		return false;
	end;
end

function RPSCoreFramework:AuraCheckTimer()
	self:UpdateInteractionFrame();
end

function RPSCoreFramework:IsFallen()
	local counter = 1;
	local aura = UnitAura("Target", counter)
	while aura do
		aura, _, _, _, _, _, _, _, _, _, spellId = UnitAura("Target", counter);
		counter = counter + 1;
		if (spellId == RPSCoreFramework.TargetAura) then
			return true;
		end
	end
	return false;
end

function RPSCoreFramework:UpdatePlayerModel()
	RPS_InteractFrameSelfModel:SetUnit("Player")
	RPS_InteractFrameTargetModel:SetUnit("Target")
end


function RPSCoreFramework:ItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then return end
	local _, _, _, _, _, sType, _, _ = GetItemInfo(link);
	
	if (sType == "Доспехи" or sType == "Armor") then		
		local name = self:GetName()
		for i = 1, self:NumLines() do
			local left = _G[name .. "TextLeft" .. i]
			local right = _G[name .. "TextRight" .. i]
			if (left:GetText() ~= nil) then
				if (string.find(left:GetText(), ITEM_MOD_STRENGTH_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_STRENGTH_SHORT, "к стойкости"));
				elseif (string.find(left:GetText(), ITEM_MOD_AGILITY_SHORT)) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_AGILITY_SHORT, "к сноровке"));
				elseif (string.find(left:GetText(), ITEM_MOD_INTELLECT_SHORT )) then
					_G[name .. "TextLeft" .. i]:SetText(string.gsub(left:GetText(), ITEM_MOD_INTELLECT_SHORT, "к воле"));
				end
			end

			if (right:GetText() ~= nil) then
				if (string.find(right:GetText(), "Декоративный предмет") or string.find(right:GetText(), "Cosmetic")) then
					_G[name .. "TextRight" .. i]:SetText("Предмет");
				end
			end

		end
	end
end