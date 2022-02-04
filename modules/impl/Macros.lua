RPSCoreFramework.MaxMacroPerAccount = 120;
RPSCoreFramework.MaxMacroPerCharacter = 18;

function RPSCoreFramework:RequestMacroCreation(name, icon, body, perCharacter)
	PlaySound(624, "SFX");
    local _, num = GetNumMacros();
    if (num >= RPSCoreFramework.MaxMacroPerCharacter) then
        print("У вас слишком много макросов");
        return false;
    end

    StaticPopup_Show("MakeMacros", nil, nil, {name, icon, body, perCharacter});

	return true;
end