function RPSCoreFramework:IsInteractCast()
	local name, _, _, _, _, _, _, _, _, _ = UnitCastingInfo("player");
	if (name == "Помочь" or name == "Добить" or name == "Ограбить") then
		return true;
	else
		return false;
	end;
end

function RPSCoreFramework:UpdateInteractButtons()
	if ((self:HasAura(RPSCoreFramework.NoviceAura) or self:HasAura(RPSCoreFramework.PillageWoundsAura))) then
		RPS_InteractFramePillage:Hide();
		RPS_InteractFrameKill:Hide();
	else
		RPS_InteractFramePillage:Show();
		RPS_InteractFrameKill:Show();
	end;
end

function RPSCoreFramework:AuraCheckTimer()
	self:UpdateInteractionFrame();
end

function RPSCoreFramework:HasAura(id, target)
	if (target == nil) then
		target = "player";
	end;

	local counter = 1;
	local aura = UnitAura(target, counter)
	while aura do
		aura, _, _, _, _, _, _, _, _, spellId = UnitAura(target, counter);
		counter = counter + 1;
		if (spellId == id) then
			return true;
		end
	end
	return false;
end

function RPSCoreFramework:IsFallen()
	local counter = 1;
	local aura = UnitAura("Target", counter);
	while aura do
		aura, _, _, _, _, _, _, _, _, spellId = UnitAura("Target", counter);
		counter = counter + 1;
		if (spellId == RPSCoreFramework.TargetAura) then
			return true;
		end
	end
	return false;
end

function RPSCoreFramework:UpdatePlayerModel()
	RPS_InteractFrameSelfModel:SetUnit("Player");
	RPS_InteractFrameTargetModel:SetUnit("Target");
end