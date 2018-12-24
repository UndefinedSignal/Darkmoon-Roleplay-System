function RPSCoreFramework:CreateDispMacro()
    if GetNumMacros() <= 120 then
        StaticPopup_Show("MakeMacros")
    end
    PlaySound(624, "SFX")
end

