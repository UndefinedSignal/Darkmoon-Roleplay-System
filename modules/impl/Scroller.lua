function RPSCoreFramework:GenerateScrollMenu()
	FauxScrollFrame_Update(DarkmoonAurasScrollFrame,#RPSCoreFramework.Interface.Auras.Show,6,32);
	for jBtn=1, 6 do
		lineplusoffset = jBtn + FauxScrollFrame_GetOffset(DarkmoonAurasScrollFrame);
		RPSCoreFramework.Scroller.lineplusoffset[jBtn] = tonumber(lineplusoffset);
	end
	RPSCoreFramework:ScrollMenuUpdater();
end
function RPSCoreFramework:GhostClickUpdater()
	RPSCoreFramework.Interface.Auras.GhostClick = false;
end
function RPSCoreFramework:ScrollMenuUpdater() -- Выбивает если нет активной ауры
    if RPSCoreFramework.Interface.Auras.Initialized then
        for jBtn=1, #RPSCoreFramework.Scroller.lineplusoffset do
            local lineplusoffset = RPSCoreFramework.Scroller.lineplusoffset[jBtn]
            if lineplusoffset <= #RPSCoreFramework.Interface.Auras.Show then
                RPSCoreFramework.DB["RPS_AuraButton"..jBtn][1] = RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][1];

                _G["RPS_AuraButton"..jBtn.."Name"]:SetText(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][2])
                _G["RPS_AuraButton"..jBtn.."Description"]:SetText(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][3])
                _G["RPS_AuraButton"..jBtn.."Number"]:SetText(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][1])

                if RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][5] > 0 then
                    _G["RPS_AuraButton"..jBtn.."Price"]:Hide()
                    _G["RPS_AuraButton"..jBtn.."Completed"]:Hide()
                    _G["RPS_AuraButton"..jBtn.."Macros"]:Show()
                    _G["RPS_AuraButton"..jBtn].bannertexture:SetAtlas("GarrMission_RewardsBanner");

                    RPSCoreFramework.Interface.Auras.Message[jBtn][1] = "rps action aura toggle "..tonumber(RPSCoreFramework.Interface.Auras.Show[lineplusoffset])
                else
                    _G["RPS_AuraButton"..jBtn.."Completed"]:Hide()
                    _G["RPS_AuraButton"..jBtn.."Macros"]:Hide()
                    _G["RPS_AuraButton"..jBtn.."Price"]:Show()
                    _G["RPS_AuraButton"..jBtn].bannertexture:SetAtlas("GarrMission_RewardsBanner-Desaturate");
                    if tonumber(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][4]) > tonumber(GetMoney()) then
                        _G["RPS_AuraButton"..jBtn.."Price"]:SetText("|cFFFF0000"..GetCoinTextureString(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][4]).."|r")
                    else
                        _G["RPS_AuraButton"..jBtn.."Price"]:SetText(GetCoinTextureString(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][4]))
                    end
                    RPSCoreFramework.Interface.Auras.Message[jBtn][1] = "rps action aura learn "..tonumber(RPSCoreFramework.Interface.Auras.Show[lineplusoffset])
                end
                if RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][6] == 1 then
                    _G["RPS_AuraButton"..jBtn.."Completed"]:Show()
                    --_G["RPS_AuraButton"..jBtn]:LockHighlight()
                else
                    --_G["RPS_AuraButton"..jBtn]:UnlockHighlight()
                    _G["RPS_AuraButton"..jBtn.."Completed"]:Hide()
                end
                RPSCoreFramework.Interface.Auras.Message[jBtn][2] = tonumber(RPSCoreFramework.Interface.Auras.Show[lineplusoffset])
                _G["RPS_AuraButton"..jBtn.."FavouritesIndicator"]:Hide();

                if RPSCoreFramework:FavouritesSearch(RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][1]) then
                    _G["RPS_AuraButton"..jBtn.."FavouritesIndicator"]:Show();
                end
                RPSCoreFramework.DB["RPS_AuraButton"..jBtn.."Favourites"] = RPSCoreFramework.Interface.Auras[RPSCoreFramework.Interface.Auras.Show[lineplusoffset]][1];
                _G["RPS_AuraButton"..jBtn]:Show()
            else
                _G["RPS_AuraButton"..jBtn]:Hide()
            end
        end
	end
	if RPS_AuraButton1:IsShown() then
	    AurasNotFound:Hide();
	else
	    AurasNotFound:Show();
	end
end

function RPSCoreFramework:ProcessAurasOnEnter(name)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:AddLine("|cFFFFFFFF"..RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][2].."|r")
    GameTooltip:AddLine("|cFFABD473"..RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][3].."|r\n\n")
    if (tonumber(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][4]) > tonumber(GetMoney()) and RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][5] == 0) then
        GameTooltip:AddLine("Цена покупки: |cFFFF0000"..GetCoinTextureString(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][4]).."|r")
        GameTooltip:AddLine("Не хватает денег.")
    elseif (tonumber(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][4]) < tonumber(GetMoney()) and RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][5] == 0) then
        GameTooltip:AddLine("Цена покупки: "..GetCoinTextureString(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][4]))
        GameTooltip:AddLine("Клик: Приобрести")
    end
    if RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][5] > 0 then
        GameTooltip:AddLine("Клик: Использовать")
    end
    GameTooltip:Show()
end

function RPSCoreFramework:ProcessAurasOnLeave()
	GameTooltip:Hide()
end

function RPSCoreFramework:ProcessAurasMacrosOnClick(name)
    if (GetNumMacros() <= 120) then
        CreateMacro(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][2], "INV_DARKMOON_EYE", ".rps action aura toggle "..RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][1], 1);
        PickupMacro(RPSCoreFramework.Interface.Auras[RPSCoreFramework.DB[name][1]][2]);
    else
        Utils.message.displayMessage(loc("QE_MACRO_MAX"), 4);
    end
end

function RPSCoreFramework:ProcessFavourites(arg1)
    if not RPSCoreFramework:FavouritesSearch(RPSCoreFramework.DB[arg1]) then
        table.insert(RPSCoreFavourites, RPSCoreFramework.DB[arg1]);
        return
    end
    table.remove(RPSCoreFavourites, RPSCoreFramework:FavouritesSearch(tonumber(RPSCoreFramework.DB[arg1])));
    RPSCoreFramework:GenerateScrollMenu();
end


function RPSCoreFramework:LearnMyAuras(button, arg1)
	RPSCoreFramework:SendCoreMessage(RPSCoreFramework.Interface.Auras.Message[arg1][1]);
	_G[button:GetName().."Price"]:Hide();
    _G[button:GetName().."Macros"]:Show();
	RPSCoreFramework.Interface.Auras[tonumber(RPSCoreFramework.Interface.Auras.Message[arg1][2])][5] = 1;
	RPSCoreFramework.Interface.Auras.Message[arg1][1] = "rps action aura toggle ".. RPSCoreFramework.Interface.Auras.Message[arg1][2];
	RPSCoreFramework.CanScroll = true;
end
function RPSCoreFramework:MaxToggledAuras(button, arg1)
	RPSCoreFramework.Interface.ActiveAuraCounter = 1;
	for i = 1, #RPSCoreFramework.Interface.Auras do
		RPSCoreFramework.Interface.Auras[i][6] = 0;
	end
	RPSCoreFramework.Interface.Auras[tonumber(RPSCoreFramework.Interface.Auras.Message[arg1][2])][6] = 1;
	RPSCoreFramework:SendCoreMessage(RPSCoreFramework.Interface.Auras.Message[arg1][1]);
	RPSCoreFramework:HideEffectAuraButtons();
	RPSCoreFramework.CanScroll = true;
	_G[button:GetName().."Completed"]:Show();
	_G["ActiveAura"]:SetText(RPSCoreFramework.Interface.ActiveAuraCounter.."/3", 0.5, 0.5);
end


function RPSCoreFramework:ToggleOrBuyAuraMessage(button, arg1)
	if RPSCoreFramework.Interface.Auras.GhostClick then
		return false
	end
	RPSCoreFramework.CanScroll = false;
	RPSCoreFramework.Interface.Auras.GhostClick = true;
	StaticPopupDialogs["LearnAura"] = {
		text = "Вы действительно желаете приобрести выбранную ауру?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:LearnMyAuras(button, arg1) end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			if self.ticker then
				self.ticker:Cancel();
			end
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft <= 0) then
					self.button1:SetText(YES)
					self.button1:Enable();
					self.ticker:Cancel();
					return;
				else
					self.button1:SetText(self.declineTimeLeft);
				end
			end);
		end,
		OnCancel = function() RPSCoreFramework.CanScroll = true end,
		timeout = 0,
		StartDelay = function() return 3; end,
		whileDead = true,
		hideOnEscape = true,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}
	StaticPopupDialogs["MaxToggledAuras"] = {
		text = "У вас уже активно 3 ауры. Активация ещё одной сбросит все предыдущие, вы уверены что хотите активировать эту ауру?",
		button1 = YES,
		button2 = NO,
		OnAccept = function() RPSCoreFramework:MaxToggledAuras(button, arg1) end,
		OnShow = function(self)
			self.declineTimeLeft = 3;
			self.button1:SetText(self.declineTimeLeft);
			self.button1:Disable();
			if self.ticker then
				self.ticker:Cancel();
			end
			self.ticker = C_Timer.NewTicker(1, function()
				self.declineTimeLeft = self.declineTimeLeft - 1;
				if (self.declineTimeLeft <= 0) then
					self.button1:SetText(YES)
					self.button1:Enable();
					self.ticker:Cancel();
					return;
				else
					self.button1:SetText(self.declineTimeLeft);
				end
			end);
		end,
		OnCancel = function() RPSCoreFramework.CanScroll = true end,
		timeout = 0,
		StartDelay = function() return 3; end,
		whileDead = true,
		hideOnEscape = true,
		exclusive = true,
		showAlert = 1,
		preferredIndex = 3, 
	}
	local id = RPSCoreFramework.Interface.Auras.Message[arg1][2]
	if RPSCoreFramework:KnownAura(id) then
		if ( RPSCoreFramework:UpdateActiveAurasCounter() and RPSCoreFramework:isAuraActive(id) ) then
			RPSCoreFramework:SendCoreMessage(RPSCoreFramework.Interface.Auras.Message[arg1][1]);
			RPSCoreFramework.Interface.ActiveAuraCounter = RPSCoreFramework.Interface.ActiveAuraCounter - 1;
			RPSCoreFramework.Interface.Auras[id][6] = 0;
			RPSCoreFramework.CanScroll = true;
			_G[button:GetName().."Completed"]:Hide();
		else
			if ( tonumber(RPSCoreFramework.Interface.ActiveAuraCounter) < 3 ) then
				RPSCoreFramework:SendCoreMessage(RPSCoreFramework.Interface.Auras.Message[arg1][1]);
				RPSCoreFramework.Interface.ActiveAuraCounter = RPSCoreFramework.Interface.ActiveAuraCounter + 1;
				RPSCoreFramework.Interface.Auras[id][6] = 1;
				RPSCoreFramework.CanScroll = true;
				_G[button:GetName().."Completed"]:Show();
			else
				StaticPopup_Show("MaxToggledAuras");
			end
		end
	else
		if (GetMoney() >= tonumber(RPSCoreFramework.Interface.Auras[id][4])) then
			StaticPopup_Show("LearnAura");
		end
	end
	_G["ActiveAura"]:SetText(RPSCoreFramework.Interface.ActiveAuraCounter.."/3", 0.5, 0.5);
	self:ScheduleTimer("GhostClickUpdater", 0.5);
	if (RPSCoreFramework.Interface.Auras.AllowUpdate) then
		self.ThreeTimesTimerCount = 0;
		RPSCoreFramework.Interface.Auras.AllowUpdate = false;
		self.ThreeTimesTimer = self:ScheduleRepeatingTimer("ThreeTimesUpdate", 7);
	end
end