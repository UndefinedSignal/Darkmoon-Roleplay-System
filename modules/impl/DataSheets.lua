RPSCoreFramework = LibStub("AceAddon-3.0"):NewAddon(CreateFrame("Frame"), "RPSCoreFramework", "AceHook-3.0", "AceTimer-3.0");
RPSCoreFramework.HBD = LibStub("HereBeDragons-2.0.1");
RPSCoreFramework.HBD.Pins = LibStub("HereBeDragons-Pins-2.0");
RPSCoreFramework.LualZW = LibStub("LualZW");
RPSCoreFramework.Version = 2.31;
RPSCoreFramework.Literature = {};
RPSCoreFramework.Scroller = {};
RPSCoreFramework.Display = {};
RPSCoreFramework.Interface = {};
--RPSCoreFramework.DB = {};
RPSCoreFramework.Map = {};
RPSCoreFramework.Map.POICount = 0;
RPSCoreFramework.Map.POICounter = 0;
RPSCoreFramework.Map.POICountLow = 0;
RPSCoreFramework.Map.POICountMid = 0;
RPSCoreFramework.Map.UpdatePins = {};
RPSCoreFramework.Map.POIWorkflow = true;
RPSCoreFramework.Map.POIUpdateQueque = false;
RPSCoreFramework.SalaryTimer = nil;
RPSCoreFramework.PollTimer = {};
RPSCoreFramework.PollTimer.Timer = nil;
RPSCoreFramework.PollTimer.Counter = nil;

RPSCoreFramework.PrintGarbageCollector = false;
RPSCoreFramework.GBCounter = nil;
RPSCoreFramework.CanScroll = true;

RPSCoreFramework.Container = {};
RPSCoreFramework.Container.title = nil;
RPSCoreFramework.Container.size = nil;
RPSCoreFramework.Container.type = nil;
RPSCoreFramework.Container.ClickedBag = nil;
RPSCoreFramework.Container.ClickedSlot = nil;
RPSCoreFramework.ContainerDataFlow = true;
RPSCoreFramework.PlayerCursorInformation = nil;
RPSCoreFramework.DraggingContainerFrame = nil;

RPSCoreFramework.MinstrelStatus = 2;

RPSCoreFramework.DistanceText = nil;
RPSCoreFramework.WorldMapScrollChild = WorldMapFrame.ScrollContainer.Child

RPSCoreFramework.POIDesc = {};

RPSCoreFramework.Quiz = {};
RPSCoreFramework.Quiz.PollToast = false;
RPSCoreFramework.Quiz.Question = nil;
RPSCoreFramework.Quiz.Answers = {};

RPSCoreFramework.SalaryByRank = {
	["1"] = 0,
	["2"] = 0,
	["3"] = 0,
	["4"] = 0,
	["5"] = 0,
	["6"] = 0,
	["7"] = 0,
	["8"] = 0,
	["9"] = 0,
	["10"] = 0
};

if RPSCorePOIPins == nil then
	RPSCorePOIPins = {};
end
if RPSCoreShowPOIPins == nil then
	RPSCoreShowPOIPins = true;
end
if RPSCoreFavourites == nil then
	RPSCoreFavourites = {}
end

RPSCoreFramework.AdvancedRaces = {
	"voidelf",
	"highmountaintauren",
	"bloodelf",
	"draenei",
	"lightforgendraenei",
	"pandaren",
	"nightelf",
	"nightborne"
};

RPSCoreFramework.AdvancedClasses = { 2, 6, 7, 9, 10, 11, 12};
RPSCoreFramework.AdvancedClassesCharsheetRequired = {6, 12};

RPSCoreFramework.Timers = {};
RPSCoreFramework.Timers.ContainerStatus = nil;

RPSCoreFramework.itemsQuality = {}
RPSCoreFramework.itemsQuality["Голова +1"] = 1;
RPSCoreFramework.itemsQuality["Голова +2"] = 2;
RPSCoreFramework.itemsQuality["Голова +3"] = 3;
RPSCoreFramework.itemsQuality["Голова +4"] = 4;
RPSCoreFramework.itemsQuality["Плечи +1"] = 1;
RPSCoreFramework.itemsQuality["Плечи +2"] = 2;
RPSCoreFramework.itemsQuality["Плечи +3"] = 3;
RPSCoreFramework.itemsQuality["Плечи +4"] = 4;
RPSCoreFramework.itemsQuality["Ступни +1"] = 1;
RPSCoreFramework.itemsQuality["Ступни +2"] = 2;
RPSCoreFramework.itemsQuality["Ступни +3"] = 3;
RPSCoreFramework.itemsQuality["Ступни +4"] = 4;
RPSCoreFramework.itemsQuality["Кисти рук +1"] = 1;
RPSCoreFramework.itemsQuality["Кисти рук +2"] = 2;
RPSCoreFramework.itemsQuality["Кисти рук +3"] = 3;
RPSCoreFramework.itemsQuality["Кисти рук +4"] = 4;
RPSCoreFramework.itemsQuality["Грудь +1"] = 0;
RPSCoreFramework.itemsQuality["Грудь +2"] = 1;
RPSCoreFramework.itemsQuality["Грудь +3"] = 2;
RPSCoreFramework.itemsQuality["Грудь +4"] = 3;
RPSCoreFramework.itemsQuality["Грудь +5"] = 4;
RPSCoreFramework.itemsQuality["Ноги +1"] = 0;
RPSCoreFramework.itemsQuality["Ноги +2"] = 1;
RPSCoreFramework.itemsQuality["Ноги +3"] = 2;
RPSCoreFramework.itemsQuality["Ноги +4"] = 3;
RPSCoreFramework.itemsQuality["Ноги +5"] = 4;
RPSCoreFramework.itemsQuality["Пояс +1"] = 2;
RPSCoreFramework.itemsQuality["Пояс +2"] = 3;
RPSCoreFramework.itemsQuality["Пояс +3"] = 4;
RPSCoreFramework.itemsQuality["Запястья +1"] = 2;
RPSCoreFramework.itemsQuality["Запястья +2"] = 3;
RPSCoreFramework.itemsQuality["Запястья +3"] = 4;
RPSCoreFramework.itemsQuality["Плащ +1"] = 2;
RPSCoreFramework.itemsQuality["Плащ +2"] = 3;
RPSCoreFramework.itemsQuality["Плащ +3"] = 4;
RPSCoreFramework.itemsQuality["Рубашка +1"] = 2;
RPSCoreFramework.itemsQuality["Рубашка +2"] = 3;
RPSCoreFramework.itemsQuality["Рубашка +3"] = 4;
RPSCoreFramework.itemsQuality["Шея +1"] = 2;
RPSCoreFramework.itemsQuality["Шея +2"] = 3;
RPSCoreFramework.itemsQuality["Шея +3"] = 4;
RPSCoreFramework.itemsQuality["Палец +1"] = 2;
RPSCoreFramework.itemsQuality["Палец +2"] = 3;
RPSCoreFramework.itemsQuality["Палец +3"] = 4;
RPSCoreFramework.itemsQuality["Аксессуар +1"] = 2;
RPSCoreFramework.itemsQuality["Аксессуар +2"] = 3;
RPSCoreFramework.itemsQuality["Аксессуар +3"] = 4;
RPSCoreFramework.itemsQuality["Левая рука +2"] = 0;
RPSCoreFramework.itemsQuality["Левая рука +3"] = 1;
RPSCoreFramework.itemsQuality["Левая рука +4"] = 2;
RPSCoreFramework.itemsQuality["Левая рука +5"] = 3;
RPSCoreFramework.itemsQuality["Левая рука +6"] = 4;
RPSCoreFramework.itemsQuality["Правая рука +2"] = 0;
RPSCoreFramework.itemsQuality["Правая рука +3"] = 1;
RPSCoreFramework.itemsQuality["Правая рука +4"] = 2;
RPSCoreFramework.itemsQuality["Правая рука +5"] = 3;
RPSCoreFramework.itemsQuality["Правая рука +6"] = 4;

RPSCoreFramework.Prefix = "DRPS";
C_ChatInfo.RegisterAddonMessagePrefix(RPSCoreFramework.Prefix)
RPSCoreFramework.POIIterator = 0;
RPSCoreFramework.FreeStats = 0;
RPSCoreFramework.FreeStatsCached = 0;
RPSCoreFramework.TargetAura = 1000012;
RPSCoreFramework.LootedAura = 1000040;
RPSCoreFramework.WoundsAura = 1000039;
RPSCoreFramework.PillageWoundsAura = 1000035;
RPSCoreFramework.NoviceAura = 1000036;
RPSCoreFramework.TimerID = false;
RPSCoreFramework.ShowMain = false;
RPSCoreFramework.RequestUnlearn = 50000;
RPSCoreFramework.RequestRescale = 500000;
RPSCoreFramework.GetLastClickedSlot = "chest";
RPSCoreFramework.StatsLevel = 40;
RPSCoreFramework.MyScale = 0;
RPSCoreFramework.ChoosedScale = 0;
RPSCoreFramework.FrameUpdate = true;

RPSCoreFramework.Poll = {};
RPSCoreFramework.Poll.Question = nil;
RPSCoreFramework.Poll.ScheduleTimer = nil;
RPSCoreFramework.Poll.Answers = {};
	--[[	{ 1, "Путин" }
			{ 2, "Жирик" }]]


RPSCoreFramework.Interface.HighlightedButtons = {};
RPSCoreFramework.Interface.HighlightedTabButtons = {};
RPSCoreFramework.Interface.HidingFrames = {};

-- Имя, Название кнопки, Название фрейма, Открывает подменю?, Индекс кнопок подменю, Отступ перед кнопкой, Функция

RPSCoreFramework.Interface.MenuButtons = {
	{"Информация", "RPS_DarkmoonInfo", "DarkmoonInfoFrame", false, 0, false},
	{"Правила", "RPS_RuleInfo", "DarkmoonRulesFrame", false, 0, false},
	{"Система боя", "RPS_BattleSystemInfo", "DarkmoonFightSystemFrame", false, 0, false},
	{"Характеристики", "RPS_StatsInfo", nil, true, 1, true},
	{"Персонаж", "RPS_ScaleInfo", "DarkmoonCharacterFrame", false, 0, false},
	{"Ауры", "RPS_AurasInfo", "DarkmoonAurasFrame", false, 0, false},
	{"Display", "RPS_DisplayInfo", "DarkmoonDisplayInfoFrame", false, 0, false},
	{"Менестрель", "RPS_Minstrel", "DarkmoonMinstrelFrame", false, 0, false},
	{"Сменить пароль", "RPS_DropMyPassword", "DarkmoonPasswordChangeFrame", false, 0, true},
	{"Парикмахерская", "RPS_FakeFrame", "DarkmoonPasswordChangeFrame", false, 0, false, true, "RPSCoreFramework:SendCoreMessage(\"rps act barber\"); PlaySound(624, \"SFX\");"}
}
RPSCoreFramework.Interface.SubMenuButtons = {
	{1, "Боевые", "RPS_BattleStats", "DarkmoonBattleStatsFrame"}
}

RPSCoreFramework.StatsDiff = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}
RPSCoreFramework.Stats = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}
RPSCoreFramework.ItemsStats = {
	Strength = 0,
	Agility = 0,
	Intellect = 0,
	CriticalChance = 0,
	Spirit = 0,
	Endurance = 0,
	Dexterity = 0,
	Will = 0
}

RPSCoreFramework.SlotnameListPresets = {
	head = "disp head ",
	shoulder = "disp shoulder ",
	back = "disp back ",
	chest = "disp chest ",
	shirt = "disp shirt ",
	tabard = "disp tabard ",
	wrist = "disp wrist ",
	hands = "disp hands ",
	waist = "disp waist ",
	legs = "disp legs ",
	feet = "disp feet ",
	mainhand = "disp mainhand ",
	offhand = "disp offhand "
}

RPSCoreFramework.SlotnameListNames = {
	shoulder = "наплечников",
	back = "плаща",
	chest = "тела",
	shirt = "рубашки",
	tabard = "гербовой накидки",
	wrist = "наручей",
	hands = "перчаток",
	waist = "пояса",
	legs = "штанов",
	feet = "обуви",
	mainhand = "оружия в правой руке",
	offhand = "оружия в левой руке"
}

RPSCoreFramework.CharacterBackground = {
	DEATHKNIGHT = "Interface\\DRESSUPFRAME\\DressingRoomDeathKnight.BLP",
	DEMONHUNTER = "Interface\\DRESSUPFRAME\\DressingRoomDemonHunter.BLP",
	DRUID = "Interface\\DRESSUPFRAME\\DressingRoomDruid.BLP",
	HUNTER = "Interface\\DRESSUPFRAME\\DressingRoomHunter.BLP",
	MAGE = "Interface\\DRESSUPFRAME\\DressingRoomMage.BLP",
	MONK = "Interface\\DRESSUPFRAME\\DressingRoomMonk.BLP",
	PALADIN = "Interface\\DRESSUPFRAME\\DressingRoomPaladin.BLP",
	PRIEST = "Interface\\DRESSUPFRAME\\DressingRoomPriest.BLP",
	ROGUE = "Interface\\DRESSUPFRAME\\DressingRoomRogue.BLP",
	SHAMAN = "Interface\\DRESSUPFRAME\\DressingRoomShaman.BLP",
	WARLOCK = "Interface\\DRESSUPFRAME\\DressingRoomWarlock.BLP",
	WARRIOR = "Interface\\DRESSUPFRAME\\DressingRoomWarrior.BLP"
}

RPSCoreFramework.DropDownDisplayMenu = {
	    { text = "Display", isTitle = true, notCheckable = true},
	    { text = "Изменить", notCheckable = true, func = function() RPSCoreFramework:ShowDisplayInfo(RPSCoreFramework.GetLastClickedSlot); end },
	    { text = "Сбросить", notCheckable = true, func = function() RPSCoreFramework:RemoveDisplay(RPSCoreFramework.GetLastClickedSlot); end }
}


RPSCoreFramework.Scroller.lineplusoffset = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0 
}

RPSCoreFramework.Display.Scroll = {
	{".disp hea ", -1, 0},
	{".disp neck ", -1, 0},
	{".disp shoul ", -1, 0},
	{".disp shi ", -1, 0},
	{".disp che ", -1, 0},
	{".disp wai ", -1, 0},
	{".disp leg ", -1, 0},
	{".disp fee ", -1, 0},
	{".disp wri ", -1, 0},
	{".disp hand ", -1, 0},
	{".disp finger1 ", -1, 0},
	{".disp finger2 ", -1, 0},
	{".disp trinket1 ", -1, 0},
	{".disp trinket2 ", -1, 0},
	{".disp back ", -1, 0},
	{".disp main ", -1, 0},
	{".disp offh ", -1, 0},
	{".disp ranged ", -1, 0},
	{".disp tabard ", -1, 0}	
}

RPSCoreFramework.Minstrel = {
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn1"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_Blue.blp", ".minstrel gobject add", "|cffffffff.minstrel gobject add <id>|r - размещение ГО с указанным номером на месте персонажа."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn2"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_Green.blp", ".minstrel gobject target", "|cffffffff.minstrel gobject target|r - берет ближайшее ГО в цель и выводит информацию об объекте, включая guid, которые можно использовать для перемещения, поворота и удаления."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn3"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_Purple.blp", ".minstrel gobject delete", "|cffffffff.minstrel gobject delete <guid>|r - удаление ГО с указанным уникальным номером."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn4"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_Red.blp", ".minstrel gobject info", "|cffffffff.minstrel gobject info <guid>|r - получение информации о ГО с указанным уникальным номером."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn5"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_White.blp", ".minstrel gobject move", "|cffffffff.minstrel gobject move <guid>|r - перемещение ГО с указанным уникальным номером на месте, где расположен персонаж."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn6"] = {"Interface\\ICONS\\Ability_Iyyokuk_Bomb_Yellow.blp", ".minstrel gobject turn", "|cffffffff.minstrel gobject turn <guid>|r - разворот ГО с указанным уникальным номером в сторону обзора персонажа."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn7"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Blue.blp", ".minstrel npc add", "|cffffffff.minstrel npc add <id>|r - размещение NPC с указанным номером на месте персонажа."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn8"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Green.blp", ".minstrel npc delete", "|cffffffff.minstrel npc delete|r - удаление выделенного NPC."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn9"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Purple.blp", ".minstrel npc say", "|cffffffff.minstrel npc say <фраза>|r - сказать фразу от имени выделенного NPC. Стоит учесть, что фраза не должна быть длиннее 230 символов, иначе дальнейшая часть может быть обрезана."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn10"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Red.blp", ".minstrel npc yell", "|cffffffff.minstrel npc yell <фраза>|r - выкрикнуть фразу от имени выделенного NPC. Стоит учесть, что фраза не должна быть длиннее 230 символов, иначе дальнейшая часть может быть обрезана."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn11"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_White.blp", ".minstrel npc textemote", "|cffffffff.minstrel npc textemote <фраза>|r - вывести в чат эмоцию. В отличие от say и yell имя NPC не выводит автоматически, так что это следует сделать вручную. Стоит учесть, что фраза не должна быть длиннее 230 символов, иначе дальнейшая часть может быть обрезана."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn12"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Yellow.blp", ".minstrel npc info", "|cffffffff.minstrel npc info|r - выводит в чат информацию о выделенном NPC."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn13"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_Blue.blp", ".minstrel npc playemote", "|cffffffff.minstrel npc playemote <номер>|r - выделенный NPC начинает циклично проигрывать эмоцию с указанным номером. Номера эмоций NPC совпадают с номерами эмоций персонажей."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn14"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_Purple.blp", ".minstrel npc spawndist", "|cffffffff.minstrel npc spawndist <значение>|r - выделенный NPC начинает периодически бродить в указанном радиусе вокруг изначальной точки размещений. Проще говоря, ходит туда-сюда. Рекомендуется ставить значение в диапазоне 3-5."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn15"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_White.blp", ".minstrel npc come", "|cffffffff.minstrel npc come|r - выделенный NPC следует на место, где находится ваш персонаж. ВНИМАНИЕ: команда действует на всех NPC, а не только на NPC менестреля. Это создано для того, чтобы можно было освобождать сцены от ненужных NPC. Злоупотребление ей недопустимо."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn16"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_White.blp", ".minstrel npc set emote <emoteid>", "|cffffffff.minstrel npc set emote <emoteid>|r - устанавливает эмоцию под номером <emoteid> выделенному NPC."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn17"] = {"Interface\\ICONS\\Ability_Iyyokuk_Staff_White.blp", ".minstrel gameobject set scale <guid> <scale(0.1-5)>", "|cffffffff.minstrel gameobject set scale <guid> <scale(0.1-5)>|r - изменяет размер Объекта под номером <guid> на значение <scale(0.1-5)>."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn18"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_Red.blp", ".minstrel npc set scale <scale(0.1-5)>", "|cffffffff.minstrel npc set scale <scale(0.1-5)>|r - изменяет размер выделенному NPC на значение <scale(0.1-5)>."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn19"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_Purple.blp", ".minstrel reset all", "|cffffffff.minstrel reset all|r - удалить все собственные NPC и Объекты."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn20"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_Green.blp", ".minstrel reset creature", "|cffffffff.minstrel reset creature|r - удалить всех собственных NPC."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn21"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_Yellow.blp", ".minstrel reset object", "|cffffffff.minstrel reset object|r - удалить все собственные Объекты."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn22"] = {"Interface\\ICONS\\Ability_Iyyokuk_Sword_Blue.blp", ".minstrel morph", "|cffffffff.minstrel morph <id>|r - установить на себя морф под номером <id>."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn23"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_Red.blp", ".minstrel lookup creature", "|cffffffff.minstrel lookup creature <название>|r - поиск NPC по заданному названию."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn24"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_Yellow.blp", ".minstrel lookup object", "|cffffffff.minstrel lookup object <название>|r - поиск Объектов по заданному названию (только .m2)."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn25"] = {"Interface\\ICONS\\Ability_Iyyokuk_Mantid_Green.blp", ".minstrel possess", "|cffffffff.minstrel possess|r - Взять под контроль выделенного NPC менестреля."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn26"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Red.blp", ".minstrel unposess", "|cffffffff.minstrel unposess|r - Прекратить контролировать NPC."},
	["DarkmoonMinstrelFrameBackgroundSlider1Childbtn27"] = {"Interface\\ICONS\\Ability_Iyyokuk_Drum_Purple.blp", ".minstrel gameobject activate", "|cffffffff.minstrel gameobject activate <guid>|r - Активирует объект по его уникальному номеру, такой как дверь либо кнопка."}
}

RPSCoreFramework.DB = {
    ["RPS_AuraButton1Favourites"] = 0,
    ["RPS_AuraButton2Favourites"] = 0,
    ["RPS_AuraButton3Favourites"] = 0,
    ["RPS_AuraButton4Favourites"] = 0,
    ["RPS_AuraButton5Favourites"] = 0,
    ["RPS_AuraButton6Favourites"] = 0,

    ["RPS_AuraButton1"] = { 0, 0 },
    ["RPS_AuraButton2"] = { 0, 0 },
    ["RPS_AuraButton3"] = { 0, 0 },
    ["RPS_AuraButton4"] = { 0, 0 },
    ["RPS_AuraButton5"] = { 0, 0 },
    ["RPS_AuraButton6"] = { 0, 0 },

    ["lineplusoffset"] = 0,

    				-- LMB, RMB
    ["CharStatsSpellID"] = { 
		["Strength"] = {1000001, 1000024},
		["Agility"] = {1000002, 1000025},
		["Intellect"] = {1000003, 1000026},
		["CriticalChance"] = {1000033, 1000033},
		["Spirit"] = {1000004, 1000027},
		["Endurance"] = {1000028, 1000028},
		["Dexterity"] = {1000029, 1000029},
		["Will"] = {1000030, 1000030}
    }
}

RPSCoreFramework.DB.Frames = {
    ["RPS_AuraButton1"] = nil,
    ["RPS_AuraButton2"] = nil,
    ["RPS_AuraButton3"] = nil,
    ["RPS_AuraButton4"] = nil,
    ["RPS_AuraButton5"] = nil,
    ["RPS_AuraButton6"] = nil
}


RPSCoreFramework.Interface.Auras = {
	{1,"Походный рюкзак", "На спину. Практично и стильно", 2000, 0, 0},
	{2,"Колчан со стрелами", "На спину. Самый обычный", 2000, 0, 0},
	{3,"Пандаренский колчан со стрелами", "На спину. Стрелы очень длинные", 10000, 0, 0},
	{4,"Рюкзак с четырьмя копьями", "На спину. Копья длинные и красные", 40000, 0, 0},
	{5,"Мешок семян", "На спину. Большой", 3000, 0, 0},
	{6,"Котомка", "На спину. Маленькая сумочка за спину", 3000, 0, 0},
	{7,"Сумка-котомка", "На спину. Простенькая сумка", 6000, 0, 0},
	{8,"Шипастый щит", "На спину. Очень большой", 40000, 0, 0},
	{9,"Мешок с припасами", "На спину. Для тех, кто на спине тащит весь походный лагерь", 3000, 0, 0},
	{10,"Бочка", "На спину. Очень большая", 20000, 0, 0},
	{11,"Крылья глайдера", "На спину. Большие. Вызывают анимацию полета", 50000, 0, 0},
	{12,"Шахтерский бур", "Предмет. Крутящийся бур в руках как оружие", 10000, 0, 0},
	{13,"Череп", "Предмет. Маска на голову. Отлично подойдет для троллей и серийных убийц", 7000, 0, 0},
	{14,"Огонь у левого глаза", "Аура. Светло-голубой, магический", 40000, 0, 0},
	{15,"Мирно спать", "Эмоция. С эффектом Zzz", 1000, 0, 0},
	{16,"Притвориться зомби", "Эмоция. Персонажа перекашивает на бок", 3000, 0, 0},
	{17,"Поднять правую руку вверх", "Эмоция. Название говорит само за себя", 3000, 0, 0},
	{18,"Левую руку в кулак", "Эмоция. Персонаж сжимает левую руку в кулак перед собой", 3000, 0, 0},
	{19,"Гордая стойка", "Эмоция. Проигрывается с повтором", 3000, 0, 0},
	{20,"Безысходность", "Эмоция. Над персонажем появляется тучка, а его лицо источает депрессию", 3000, 0, 0},
	{21,"Играть на арфе", "Эмоция. Игра на арфе. С музыкой", 5000, 0, 0},
	{22,"Оказывать первую помощь", "Эмоция. Персонаж садится на колени и лечит, с крестиками в воздухе", 500, 0, 0},
	{23,"Присесть и пилить", "Эмоция. Персонаж присаживается и пилит пилой", 1000, 0, 0},
	{24,"Сальто назад", "Эмоция. Персонаж делает сальто назад. Единожды", 5000, 0, 0},
	{25,"Катиться клубком", "Эмоция. Персонаж катится клубком вперед. Безвременно", 5000, 0, 0},
	{26,"Красивый удар мечом", "Эмоция. Как в фильмах. Техника Тайрекса", 10000, 0, 0},
	{27,"Залп стрел", "Эмоция. Расстреливает кучу стрел по округе. Эпично", 10000, 0, 0},
	{28,"Стойка с ружьем", "Эмоция. Персонаж круто держит пушку в руках от бедра и может ходить так", 3000, 0, 0},
	{29,"Огнемет", "Эмоция. Оружие у персонажа начинает стрелять огнем перед ним", 20000, 0, 0},
	{30,"Атака волной бездны", "Эмоция. Персонаж наносит удар оружием, от которого исходит бездна", 10000, 0, 0},
	{31,"Круг света", "Аура. Персонажа начинает окружать круг света.", 20000, 0, 0},
	{32,"Крылья света", "Аура. За спиной у персонажа появляются крылья света", 20000, 0, 0},
	{33,"Щит бездны", "Аура. Персонажа окружает впечатляющий безднощит", 80000, 0, 0},
	{34,"Магия бездны", "Эмоция. Персонаж сотворяет заклинание бездны, сопровождаемое темными сгустками", 10000, 0, 0},
	{35,"Медитация бездны", "Эмоция. Персонаж преклоняет колени, и его охватывают потоки бездны", 10000, 0, 0},
	{36,"Сотворение шара бездны", "Эмоция. Персонаж сотворяет шар бездны перед собой", 10000, 0, 0},
	{37,"Арканный щит перед собой", "Эмоция. Появляется арканный щит перед персонажем", 10000, 0, 0},
	{38,"Арканный туман", "Аура. Персонажа окружает арканный туман", 20000, 0, 0},
	{39,"Метель", "Аура. Вокруг персонажа появляется метель", 20000, 0, 0},
	{40,"Усиление огнем", "Аура. Персонажа охватывает пульсирующий эффект пламени", 10000, 0, 0},
	{41,"Огонь на ладони", "Эмоция. Персонаж держит руки перед собой, будто что-то сотворяет. В руках огонек", 10000, 0, 0},
	{42,"Мощная магия огня", "Эмоция. Персонаж сотворяет магию огня, впечатлительно", 20000, 0, 0},
	{43,"Огнеарканный щит для группы", "Аура и эмоция. Группу защищает мощный огненный щит", 100000, 0, 0},
	{44,"Штормовой круг", "Аура. Персонажа охватывает штормовой круг", 20000, 0, 0},
	{45,"Вихрь духов-защитников", "Аура. Персонажа охватывает вихрь духов-защитников", 10000, 0, 0},
	{46,"Тачка", "Предмет. Перед персонажем появляется тачка", 500, 0, 0},
	{47,"Лейка", "Предмет. В руке у персонажа появляется лейка", 500, 0, 0},
	{48,"Корзина с фруктами", "Предмет. В руках у персонажа появляется корзина с фруктами", 500, 0, 0},
	{49,"Кусты камуфляжные", "Предмет. В руках у персонажа появляются кусты для камуфляжа", 2000, 0, 0},
	{50,"Ящик с медикаментами", "Предмет. В руках персонаж держит ящик с медикаментами", 500, 0, 0},
	{51,"Две корзины", "Предмет. В руках персонаж несет две корзины", 500, 0, 0},
	{52,"Шесть вязанок сена", "Предмет. Персонаж несет на себе шесть вязанок сена", 2000, 0, 0},
	{53,"Подзорная труба", "Предмет. В руках у персонажа подзорная труба", 500, 0, 0},
	{54,"Доска", "Предмет. В руках персонаж несет доску", 500, 0, 0},
	{55,"Бомбы", "Предмет. В руках у персонажа две бомбы", 2000, 0, 0},
	{56,"Ящик", "Предмет. Персонаж перед собой несет ящик", 500, 0, 0},
	{57,"Облик тьмы", "Аура. Облик тьмы как у жрецов", 10000, 0, 0},
	{58,"Колдунство скверны", "Эффект. В руках у персонажа появляется пламя скверны", 5000, 0, 0},
	{59,"Теневой дым", "Аура. Персонаж становится прозрачнее, и его окружает дым", 10000, 0, 0},
	{60,"Арканный барьер", "Аура. Арканный барьер для всей группы", 100000, 0, 0},
	{61,"Магма на ладонях", "Эффект. Руки персонажа покрываются магмой", 20000, 0, 0},
	{62,"Вихрь пламени", "Аура. Персонажа окружает вихрь пламени", 20000, 0, 0},
	{63,"Аркана на ладонях", "Аура. Аркана обволакивает ладони персонажа", 10000, 0, 0},
	{64,"Уснуть на стуле", "Анимация. Спит сидя с Zzz", 3000, 0, 0},
	{65,"Цветы в руках", "Предмет. В обоих руках по цветку", 1000, 0, 0},
	{66,"Алый цветок", "Предмет. В руках у персонажа алый цветок", 1000, 0, 0},
	{67,"Перо", "Предмет. В руках у персонажа перо", 1000, 0, 0},
	{68,"Мешок с бомбами", "На спину. Большой мешок с бомбами", 10000, 0, 0},
	{69,"Произнесение заклинания природы", "Эмоция. Персонаж применяет заклинание природы", 5000, 0, 0},
	{70,"Произнесение заклинания льда", "Эмоция. Персонаж применяет заклинание льда", 5000, 0, 0},
	{71,"Ритуальный костюм", "Одежда. Ритуальный череп на голове и черепа на спине", 10000, 0, 0},
	{72,"Ледяная глыба", "Эффект. Персонаж превращается в ледяную глыбу", 10000, 0, 0},
	{73,"Дым бездны", "Аура. Персонажа охватывает дым бездны", 20000, 0, 0},
	{74,"Пламя скверны", "Аура. Персонажа охватывает пламя скверны", 20000, 0, 0},
	{75,"Демонический круг", "Эффект. Под ногами персонажа появляется демонический круг", 20000, 0, 0},
	{76,"Ловушка Иллидари", "Эффект. Появляется ловушка Иллидари", 50000, 0, 0},
	{77,"Зонтик", "Предмет. Персонаж в руке держит зонтик", 5000, 0, 0},
	{78,"Мешок на палочке", "Предмет. Персонаж держит мешок на палочке", 500, 0, 0},
	{79,"Охапка сена", "Предмет. Персонаж держит одну охапку сена на плече", 500, 0, 0},
	{80,"Полено", "Предмет. Персонаж держит полено в руке", 500, 0, 0},
	{81,"Игра на лютне", "Эмоция. Персонаж играет на лютне. Чуть кривовато", 2000, 0, 0},
	{82,"Подзорная труба на колене", "Эмоция. Становится на колено и смотрит в подзорную трубу", 5000, 0, 0},
	{83,"Декорация дома", "Одежда. Надевает на себя картонный дом", 5000, 0, 0},
	{84,"Декорация дерева", "Одежда. Надевает на себя картонное дерево", 5000, 0, 0},
	{85,"Мяч", "Предмет. Мяч в руку", 2000, 0, 0},
	{86,"Мешок на плечо", "Предмет. Положить мешок на плечо", 500, 0, 0},
	{87,"Барабанные палочки", "Предмет. Барабанные палочки в руки", 2000, 0, 0},
	{88,"Рюкзак шнотцев", "На спину. Рюкзак со всякими полезными мелочами впридачу", 5000, 0, 0},
	{89,"Ящик железной орды", "В руки. Персонаж несёт ящик железной орды", 2000, 0, 0},
	{90,"Лютня на спину", "На спину. Лютня на спине", 2000, 0, 0},
	{91,"Штандарт пылающего клинка", "На спину. Штандарт пылающего клинка как у самураев", 5000, 0, 0},
	{92,"Свиток на спину", "На спину. Большой и маленький свитки на спину", 10000, 0, 0},
	{93,"Пыль под ногами", "Аура. Под ногами появляется интенсивно изменяющаяся пыль", 10000, 0, 0},
	{94,"Гигантские скверно-крылья", "На спину. На спине отрастают гигантские крылья, как у метаморфозы", 50000, 0, 0},
	{95,"Скверно-крылья", "На спину. На спине появляются крылья, как у метаморфозы. В самый раз", 20000, 0, 0},
	{96,"Пал на землю от стрел", "Анимация. Лечь как убитый, при этом с кучей пронзенных стрел", 1000, 0, 0},
	{97,"Неистовство стихий", "Аура. Персонаж-шаман эпично окружает себя разными стихиями", 50000, 0, 0},
	{98,"Магия крови на правой руке", "Аура. На правой руке появляется эффект магии крови", 10000, 0, 0},
	{99,"Арканно-туманный щит", "Аура. Персонажа окружает арканно-туманный щит", 10000, 0, 0},
	{100,"Раскол от скверны", "Аура. Под ногами появляется раскол от скверны", 10000, 0, 0},
	{101,"Медитация монахов", "Эмоция. Монашеская медитация", 5000, 0, 0},
	{102,"Удар Тэньзо", "Эмоция. Эпично летит с ногой вперед.", 10000, 0, 0},
	{103,"Ветряная вертушка", "Эмоция. Эпично крутится, вздымая пыль. Монашеское", 20000, 0, 0},
	{104,"Крутить вокруг себя булыжники", "Эмоция. Магия земли. Крутит вокруг себя булыжники", 10000, 0, 0},
	{105,"Барьер летающих булыжников", "Аура. Вокруг персонажа летают булыжники. Магия земли", 10000, 0, 0},
	{106,"Аура ветра", "Аура. Магия воздуха. Эпично", 10000, 0, 0},
	{107,"Произнесение заклинания воздуха", "Эмоция. Персонаж произносит электрико-воздушное заклинание", 10000, 0, 0},
	{108,"Ледяной поток", "Эмоция. Эпичный большой ледяной поток перед заклинателем", 20000, 0, 0},
	{109,"Свет Элуны", "Аура. Свет Элуны", 10000, 0, 0},
	{110,"Нейтрализующий щит", "Ауры. Персонажа окружает щит сквернобездны", 20000, 0, 0},
	{111,"Групповой световой щит", "Аура. Поле боя окружает большущий щит света. Крайне эпично", 100000, 0, 0},
	{112,"Магия барда", "Эмоция. Сотворяет некое звуко колдовство", 5000, 0, 0},
	{113,"Квадратный фонарик", "Предмет. Фестивальный пандаренский фонарик в руках", 1000, 0, 0},
	{114,"Бочка с ядохимикатами", "На спину. Бочка с ядохимикатами", 10000, 0, 0},
	{115,"Венок на голову", "Предмет. Веночек на голову", 5000, 0, 0},
	{116,"Призрак", "Аура. Персонаж сереет и становится прозрачным", 2000, 0, 0},
	{117,"Льдистый путь", "Эффект. Способность ходить по воде", 10000, 0, 0},
	{118,"Быть связанным ловчей веревкой", "Эффект. Персонаж сидит, связанный", 100, 0, 0},
	{119,"Горение", "Эффект. Персонаж горит, будто его подожгли, с анимацией получения урона", 100, 0, 0},
	{120,"Теневые оковы", "Эффект. Персонаж оказывается скован теневыми оковами и не может передвигаться", 100, 0, 0},
	{121,"Оплетающие корни", "Эффект. Персонажа оплели корни, и он не может двигаться", 100, 0, 0},
	{122,"Восклицательный знак", "Аура. Над головой появляется восклицательный знак, словно имеется задание", 5000, 0, 0},
	{123,"Огромный колчан ", "На спину. Как пандаренский колчан, только выше расположен. Подходит людям", 10000, 0, 0},
	{124,"Улучшенное скверноколдунство", "Анимация. Обе руки горят пламенем, улучшенная анимация произнесения заклинания", 10000, 0, 0},
	{125,"Аура кошмара", "Аура. По всему персонажу идут линии", 10000, 0, 0},
	{126,"Целиться из дробовика", "Анимация. Персонаж с особо злостным лицом, держа дробовик в одной руке, целится", 5000, 0, 0},
	{127,"Целиться из лука", "Анимация. Персонаж стоит на колене и целится из лука", 5000, 0, 0},
	{128,"Ведро с рыбой", "Предмет. В руках ведро с рыбой", 500, 0, 0},
	{129,"Картина в руках", "Предмет. Персонаж держит картину в руках", 500, 0, 0},
	{130,"Картина в руках 2", "Предмет. Персонаж держит другую картину в руках, со стражником", 500, 0, 0},
	{131,"Пепе", "На голову. На голове появляется птичка пепе", 50000, 0, 0},
	{132,"Арканный щит", "Аура. Мага окружает арканный щит", 10000, 0, 0},
	{133,"Большой арканный щит", "Аура. Мага окружает большой арканный щит. В процессе колдует", 10000, 0, 0},
	{134,"Аура света", "Аура. Под ногами у персонажа регулярно появляются символы света", 10000, 0, 0},
	{135,"Держать факел в руке", "Анимация. Анимация держания факела или копья в руке. Ходит криво. Факел не прилагается", 2000, 0, 0},
	{136,"Петь", "Анимация. Персонаж поет, а над ним аура музыки", 5000, 0, 0},
	{137,"Благословление Элуны", "Аура. Персонаж становится полупрозрачным и около него падают мелкие звезды", 10000, 0, 0},
	{138,"Благословление Анше", "Аура. Персонаж становится полупрозрачным и испытывает благословление Анше", 10000, 0, 0},
	{139,"Древо жизни", "Превращение. Персонаж превращается в древо жизни", 10000, 0, 0},
	{140,"Портал Изеры", "Аура. Друидское. Персонажа окружает аура Изеры", 10000, 0, 0},
	{141,"Великий барьер", "Групповая аура. Персонажа окружает на все поля боя барьер фиолетового цвета", 100000, 0, 0},
	{142,"Бирюзовый призрак", "Аура. Персонаж становится прозрачным и бирюзовым", 10000, 0, 0},
	{143,"Камуфляж темной магии", "Аура. Персонаж крадется как в незаметности, краснеет и излучает дымку холода", 10000, 0, 0},
	{144,"Суперкамуфляж", "Аура. Персонаж становится практически незаметным", 15000, 0, 0},
	{145,"Свечение Элуны", "Аура. Персонаж становится источником сильного света", 10000, 0, 0},
	{146,"Произнесение заклинания Света", "Анимация. Персонаж сотворяет заклинание Света", 7500, 0, 0},
	{147,"Произнесение заклинание Света 2", "Анимация. Персонаж сотворяет заклинание Света, вторая анимация", 7500, 0, 0},
	{148,"Артефактная стойка", "Анимация. Персонаж принимает крутую стойку держания артефакта", 5000, 0, 0},
	{149,"Прославление", "Эффект. Персонаж по-особому левитирует, а у него за спиной вырастают крылья Света", 20000, 0, 0},
	{150,"Аура призрака", "Аура. Блекло-голубой классический призрак", 10000, 0, 0},
	{151,"Знамя Орды", "На спину. На спине появляется знамя Орды", 10000, 0, 0},
	{152,"Щит скверны", "Аура. Перед персонажем появляется руны (щит) скверны", 10000, 0, 0},
	{153,"Руна скверны", "Аура. Над персонажем проявляется большая руна скверны", 10000, 0, 0},
	{154,"Есть сырое мясо", "Анимация. Персонаж ест сидя сырое мясо", 500, 0, 0},
	{155,"Есть печеньку", "Анимация. Персонаж ест сидя большую печеньку", 500, 0, 0},
	{156,"Тотем Речной Гривы", "На спину. Тотем речной гривы на спине", 5000, 0, 0},
	{157,"Тотем Небесного Рога", "На спину. Тотем небесного рога на спине", 5000, 0, 0},
	{158,"Желтое знамя Альянса", "На спину. Оранжевое знамя Альянса на спину", 5000, 0, 0},
	{159,"Пылающие крылья", "На спину. На спине появляются пылающие крылья", 20000, 0, 0},
	{160,"Знамя Черного Клинка", "На спину. На спине появляется знамя черного клинка", 5000, 0, 0},
	{161,"Красться", "Аура. Персонаж крадется как в незаметности", 10000, 0, 0},
	{162,"Желтое знамя Орды", "На спину. Оранжевое знамя Орды на спину", 5000, 0, 0},
	{163,"Левитирующие цепи", "Аура. Вокруг персонажа появляются цепи как у лича", 10000, 0, 0},
	{164,"Благословление Авианны", "Аура. Вокруг персонажа витают полосы света, а сам он леветирует", 10000, 0, 0},
	{165,"Улучшенный облик тьмы", "Аура. Персонажа окутывает тьма", 30000, 0, 0},
	{166,"Темнейшая тьма", "Аура. Персонажа окутывает плотный занавес тьмы и исходит безднодымка", 20000, 0, 0},
	{167,"Дренорская тыква", "Предмет. Переносить дренорскую тыкву (сойдет и как обычная)", 500, 0, 0},
	{168,"Фестивальный фонарик", "Предмет. В правой рыке факел. На спине большой фестивальный фонарик", 500, 0, 0},
	{169,"Боченок", "Предмет. Персонаж держит пивной(?) боченок на плече", 500, 0, 0},
	{170,"Каменный блок", "Предмет. Персонаж держит в руке каменный блок", 500, 0, 0},
	{171,"Мешочек", "Предмет. Персонаж держит маленький мешочек в руке", 500, 0, 0},
	{172,"Слитки", "Предмет. Персонаж держит на плече дощечку, на которой слитки", 500, 0, 0},
	{173,"Древесина перед собой", "Предмет. Держит три бревна перед собой", 500, 0, 0},
	{174,"Ящик 2", "Предмет. Несет ящик со стальными ребрами перед собой", 500, 0, 0},
	{175,"Держать крысу.", "Предмет. Держит крысу в правой руке", 500, 0, 0},
	{176,"Бокал вина", "Предмет. Держит бокал с вином в правой руке", 500, 0, 0},
	{177,"Держать факел в руке 2", "Предмет. Держит факел в левой руке и ходит нормально. Но нельзя поднимать оружие", 500, 0, 0},
	{178,"Бу!", "Анимация. Держит две руки перед собой будто собирается пугать", 1000, 0, 0},
	{179,"Мухи Ярпеда", "Аура. Вокруг персонажа летают мухи", 100, 0, 0},
	{180,"Любовь", "Аура. Над персонажем витает сердечко", 2000, 0, 0},
	{181,"Парашют", "Анимация. На персонаже раскрытый парашют. Без замедления падения", 2000, 0, 0},
	{182,"Парашют на спину", "На спину. Парашют на спине (клевый рюкзак)", 5000, 0, 0},
	{183,"Великое заклинание природы", "Аура. Персонаж произносит заклинание, а вокруг него огромный зеленый природный круг, много листьев и света.", 20000, 0, 0},
	{184,"Пузырьки пьяницы", "Аура. Персонаж испускает маленькие пузырики.", 4000, 0, 0},
	{185,"Свет", "Аура. Персонаж источает слабое свечение словно фонарик.", 5000, 0, 0},
	{186,"Танцевальные палочки", "Зелёные танцевальные палочки. Оставляют за собой зелёный след при движении руки.", 5000, 0, 0},
	{187,"Столп света", "Аура. Персонажа окутывает большой столп света с небес", 20000, 0, 0},
	{188,"Пламя на руках", "Аура. Руки персонажа окутаны пламенем", 5000, 0, 0},
	{189,"Пиратский флаг", "На спину. Пиратский флаг за спину. Арррр!", 5000, 0, 0},
	{190,"Фиолетовое мерцание", "Аура. Персонаж становится темно-полупрозрачным и начинает переливаться фиолетовым мерцанием", 10000, 0, 0},
	{191,"Демоническая телепортация", "Аура. Персонажа охватывает зеленый телепортационный/ритуальный круг, а сам он по особому левитирует", 10000, 0, 0},
	{192,"Длань Элуны", "Аура. Над персонажем горит знак Элуны", 4000, 0, 0},
	{193,"Жажда крови", "Аура. Персонаж чуть увеличивается в размерах, и его охватывает ауры всплесков крови", 20000, 0, 0},
	{194,"Отравление", "Аура. Персонаж зеленеет", 1000, 0, 0},
	{195,"Защита древних королей", "Аура. На 8 секунд персонажа охватывает светло-энергетический барьер", 10000, 0, 0},
	{196,"Молнии в руке", "Аура. Персонаж становится в боевую стойку, в его правой руке искрится шаровая молния. Техника тысячи попугаев", 10000, 0, 0},
	{197,"Массовая аура природы", "Групповая аура. Вокруг персонажа образуется большой круг природы, а также идет целительный дождь", 50000, 0, 0},
	{198,"Молнии на персонаже", "Аура. Персонажа окружают красивые молниевые всплески", 10000, 0, 0},
	{199,"Паучьи яйца", "На спину. На спине персонажа паучьи яйца", 5000, 0, 0},
	{200,"Знамя Шадо-пан", "На спину. На спине появляется знамя Шадо-пан", 10000, 0, 0},
	{201,"Знамя Серебряного Авангарда", "На спину. На спине появляется знамя Серебрянного Авангарда", 10000, 0, 0},
	{202,"Лихорадка", "Аура. От персонажа исходят желтые всплески", 500, 0, 0},
	{203,"Полет", "Анимация. Анимация полета", 2000, 0, 0},
	{204,"Символ Наару", "Аура. Перед лбом символ Наару", 5000, 0, 0},
	{205,"Арканный вихрь", "Аура. Руки персонажа оркутаны значительными арканными всплесками", 10000, 0, 0},
	{206,"Демонический Пепе", "Аура. На голове персонажа час сидит демонический Пепе", 50000, 0, 0},
	{207,"Огненный разлом", "Аура. Создание огненного портала перед персонажем, а также его поддержание.", 30000, 0, 0},
	{208,"Разлом бездны", "Аура. Создание портала бездны перед персонажем, а также его поддержание.", 30000, 0, 0},
	{209,"Аура скверны", "Аура. Создание портала скверны перед персонажем, а также его поддержание.", 30000, 0, 0},
	{210,"Огнеарканный круг", "Аура. Вокруг персонажа появляются огнеарканные руны.", 10000, 0, 0},
	{211,"Арканный круг", "Аура. Вокруг персонажа появляются арканные руны.", 10000, 0, 0},
	{212,"Ураган", "Аура. Персонажа окружает эффектный ураган.", 30000, 0, 0},
	{213,"Пузыри", "Аура. Из рта персонажа исходят разноцветные пузыри", 5000, 0, 0},
	{214,"Военная упряжь крутогорья", "На спину. На спине появляется большой крутогорский тотем", 10000, 0, 0},
	{215,"Булыжник в руках", "Предмет. Персонаж держит в руках большой булыжник", 5000, 0, 0},
	{216,"Световой барьер", "Аура. Персонажа окружает довольно большой световой барьер, не двигается.", 20000, 0, 0},
	{217,"Барьер скверны", "Аура. Персонажа окружает довольно большой барьер скверны.", 20000, 0, 0},
	{218,"Сеть на ногах", "Аура. Сеть с энергетическим свечением на ногах персонажа", 1000, 0, 0},
	{219,"Ветер на ногах", "Аура. Ветер окутывает ноги, а вокруг персонажа крутятся серые полосы", 10000, 0, 0},
	{220,"Каменный щит", "Аура. Вокруг персонажа витает два камня", 4000, 0, 0},
	{221,"Бочка за спину", "На спину. У персонажа бочка за спиной.", 1000, 0, 0},
	{222,"Фиолетовый огонь", "Аура. Левая рука горит фиолетовым цветом", 4000, 0, 0},
	{223,"Чума", "Аура. Персонаж позеленел, от него отдает зеленым дымком", 1000, 0, 0},
	{224,"Кровотечение", "Аура. Персонаж обильно кровоточит", 1000, 0, 0},
	{225,"Легкая заморозка", "Аура. Персонаж попадает в глыбу льда, но не полностью", 1000, 0, 0},
	{226,"Персонаж в корзине", "Аура. Персонажа окутывает большая корзина, а на голове появляется крышка от нее", 5000, 0, 0},
	{227,"Чумное облако", "Аура. Персонажа окутывает чумное облако, как у мясника", 5000, 0, 0},
	{228,"Фиолетовые цепи", "Аура. Голову и руки персонажа окутывают цепи, анимация оглушения", 1000, 0, 0},
	{229,"Берсерк", "Аура. Руки окутывает ярость, а над головой появляется значок берсеркера", 10000, 0, 0},
	{230,"Темная энергия", "Аура. К персонажу тянется темная энергия", 10000, 0, 0},
	{231,"Зеленый целеуказатель", "Аура. Над головой персонажа появляется зеленая стрелка, указывающая на него", 3000, 0, 0},
	{232,"Полымя", "Аура. Персонаж горит в очень сильном пламени, больше чем персонаж", 5000, 0, 0},
	{233,"Аура холода", "Аура. Вокруг персонажа падают снежинки", 1000, 0, 0},
	{234,"Лучи тьмы", "Аура. Вокруг персонажа из-под земли исходят фиолетовые лучи", 10000, 0, 0},
	{235,"Застыл", "Аура. Анимация персонажа полностью застывает", 5000, 0, 0},
	{236,"Горит", "Аура. Персонаж горит с дымом", 1000, 0, 0},
	{237,"Огненный щит", "Аура. Персонажа окружает огненный щит", 10000, 0, 0},
	{238,"Молнии", "Аура. Персонаж охвачен молниями", 10000, 0, 0},
	{239,"Оглушение", "Анимация. Анимация оглушения с витяющими штучками над головой", 1000, 0, 0},
	{240,"Переохлаждение", "Аура. Персонаж синеет, падают снежинки", 1000, 0, 0},
	{241,"Горение от скверны", "Аура. Персонажа охватывает испуг, он полыхает скверной", 1000, 0, 0},
	{242,"Крылья Света", "Аура. Крылья Света за спиной персонажа (плащ журавля)", 20000, 0, 0},
	{243,"Плащ Быка", "Аура. Аура Плаща Быка за спиной", 50000, 0, 0},
	{244,"Крылья Нефритовой Змеи", "Аура. Крылья Нефритовой Змеи за спиной", 50000, 0, 0},
	{245,"Произнесение магии", "Аура. Круг под ногами и свечение в руках. Можно использовать любые анимации", 1000, 0, 0},
	{246,"Портал друидов", "Аура. Свечение природы и два куста по бокам ", 10000, 0, 0},
	{247,"Цепь с шаром", "Аура. Цепь с шаром на ноге", 1000, 0, 0},
	{248,"Облик бездны", "Аура. Персонаж входит в облик бездны и парит над землёй", 15000, 0, 0},
	{249,"Держать весла", "Аура. Персонаж держит вёсла, сидя на коробке", 1000, 0, 0},
	{250,"Держать весла", "Аура. Персонаж сидя держит вёсла", 1000, 0, 0},
	{251,"Держать котенка", "Аура. Персонаж держит котика и гладит его", 5000, 0, 0},
	{252,"Зазубренные костяные крылья", "Аура. Костяные крылья за спиной персонажа", 50000, 0, 0},
	{253,"Золотой слиток", "Аура. Персонаж несет огромный золотой слиток!", 3000, 0, 0},
	{254,"Золотая миска", "Аура. Персонаж держит в руках золотую миску с драгоценностями", 3000, 0, 0},
	{255,"Большие крылья", "Аура. Большие крылья охотников на демонов за спиной персонажа", 50000, 0, 0},
	{256,"Персональный барьер", "Аура. На персонажа накладывается щит в форме прозрачного, фиолетового шара", 10000, 0, 0},
	{257,"Зеленое свечение рук", "Аура. Руки персонажа начинают гореть зеленым огнем", 5000, 0, 0},
	{258,"Фиолетовое свечение рук", "Аура. Руки персонажа начинают гореть фиолетовым огнем, дополняемой темной аурой", 10000, 0, 0},
	{259,"Тектоническая аура ", "Аура. Тектоническая аура действует на оружие у основания", 10000, 0, 0},
	{260,"Голубоватая дымка", "Аура. Персонаж окружен голубоватой дымкой", 5000, 0, 0},
	{261,"Зеленое свечение рук 2", "Аура. Руки персонажи начинают гореть зеленым огнем с трассирующими лучами", 10000, 0, 0},
	{262,"Арканная тюрьма", "Аура. Персонажа окружают арканные цепи", 1000, 0, 0},
	{263,"Нефтяная пленка", "Аура. Персонаж покрывается нефтяной пленкой и чернеет", 1000, 0, 0},
	{264,"Аура призрака", "Аура. Персонаж начинает выглядеть как призрак", 10000, 0, 0},
	{265,"Электрическая аура", "Аура. Персонаж окружен вспышками электромолний", 10000, 0, 0},
	{266,"Волны тьмы", "Аура. От персонажа вверх в воздух вздываются пафосные волны тьмы", 10000, 0, 0},
	{267,"Огненный щит Алекстразы", "Аура. Персонаж окружен огненным щитом", 15000, 0, 0},
	{268,"Синяя дымка", "Аура. От персонажа исходит синяя дымка ", 5000, 0, 0},
	{269,"Хождение по воде", "Аура. Хождение по воде шамана", 5000, 0, 0},
	{270,"Арканический круг", "Анимация. Персонаж произносит заклинание, окруженным эпическим арканическим кругом", 20000, 0, 0},
	{271,"Баллоны акваланга", "На спину. Баллоны акваланга на спине", 5000, 0, 0},
	{272,"Столп света с молниями", "Аура. Персонаж окружен столпом света с молниями", 20000, 0, 0},
	{273,"Щит темного пламени", "Аура. Персонаж окружен щитом темного пламени", 15000, 0, 0},
	{274,"Открыть портал", "Аура. Над персонажем открывается портал", 10000, 0, 0},
	{275,"Вихрь воздуха у ног", "Аура. У ног версонажа циркулярный вихрь воздуха. Эпично", 10000, 0, 0},
	{276,"Оружие на плечо", "Аура. Оружие на плечо", 2000, 0, 0},
	{277,"Аура пожаротушителя", "Анимация. Персонаж тушит, у него в руках шланг, из которого бьет струя, на спине баллоны", 5000, 0, 0},
	{278,"Мытье", "Анимация. Персонаж что-то моет перед собой", 1000, 0, 0},
	{279,"Красное излучение", "Анимация. Вокруг персонажа красное магическое излучение", 10000, 0, 0},
	{280,"Два хлеба", "Предмет. Персонаж держит перед собой лист, на котором два хлеба", 1000, 0, 0},
	{281,"Сфера тайного хранилища", "Аура. В руке у персонажа появляется арканная сфера", 5000, 0, 0},
	{282,"Застыть", "Аура. Застыть и превратиться в камень", 5000, 0, 0},
	{283,"Водный щит", "Аура. Вокруг персонажа летает водный шар", 5000, 0, 0},
	{284,"Левитация", "Аура. Персонаж парит над землей", 5500, 0, 0},
	{285,"Элемент воздуха", "Аура. Вокруг персонажа кружится элемент воздуха", 5000, 0, 0},
	{286,"Элемент пламени", "Аура. Вокруг персонажа кружится элемент пламени", 5000, 0, 0},
	{287,"Элемент льда", "Аура. Вокруг персонажа кружится элемент льда", 5000, 0, 0},
	{288,"Элемент земли", "Аура. Вокруг персонажа кружится элемент земли", 5000, 0, 0},
	{289,"Пьяная походка", "Анимация. Персонаж качается на месте и при ходьбе .", 1000, 0, 0},
	{290,"Серый мешок за спиной", "На спину. Персонаж держит серый мешок.", 1000, 0, 0},
	{291,"Ящик в руках", "Предмет. Персонаж держит ящик в руках.", 1000, 0, 0},
	{292,"Боченок на плече", "Предмет. Персонаж держит боченок на плече.", 1000, 0, 0},
	{293,"Карты хартстон в руках", "Предмет. Персонаж держит карты хартстон в руках.", 2000, 0, 0},
	{294,"Сидеть и раслабленно выпивать ", "Анимация. Персонаж сидит и расслабленно держит кружку в руках", 1000, 0, 0},
	{295,"Опереться на садовую косу ", "Анимация. Персонаж опирается на садовую косу. Только для человеческих женщин", 2000, 0, 0},
	{296,"Держать книжку в левой руке", "Предмет. Персонаж красиво держит книжку в левой руке", 5000, 0, 0},
	{297,"Держать клетку с крабом внутри", "Предмет. Персонаж тащит большую клетку с крабов внутри", 2000, 0, 0},
	{298,"Якорь в руку", "Предмет. Персонаж держит красивый якорь в руке", 5000, 0, 0},
	{299,"Читать книжку", "Предмет. Персонаж держит книжку в двух руках и внимательно читает ее", 5000, 0, 0},
	{300,"Держит руку на поясе", "Анимация. Персонаж держит руку на поясе. Не сбивается при перемещении", 1000, 0, 0},
	{301,"Ковер средних размеров на плече", "Предмет. Персонаж тащит немаленький ковер на плече", 1000, 0, 0},
	{302,"Нести лестницу на плече", "Предмет. Персонаж тащит деревянную лестницу на плече", 1000, 0, 0},
	{303,"Охапка сена на плече", "Предмет. Персонаж обоими руками держит охапку сена на плече", 1000, 0, 0},
	{304,"Тащить длинное бревно", "Предмет. Персонаж обоими руками держит бревно на плече", 1000, 0, 0},
	{305,"Официант", "Анимация. Стоит как официант, держа поднос с настойками", 2000, 0, 0},
	{306,"Тащить длинный ковер", "Предмет. Тащить длинный ковер на плече", 1000, 0, 0},
	{307,"Перенос бревнышек", "Предмет. Персонаж несет перед собой небольшие бревна обоими руками", 1000, 0, 0},
	{308,"Записывать на пергаменте", "Анимация. Персонаж пером делает записи по пергаменту", 2000, 0, 0},
	{309,"Пергамент и колокольчик", "Предмет. Пергамент и колокольчик в руках", 5000, 0, 0},
	{310,"Спать сидя", "Анимация. Персонаж спит сидя.", 1000, 0, 0},
	{311,"Тащить игрушки", "Предмет. Персонаж тащит две игрушки в руках", 2000, 0, 0},
	{312,"Официант 2", "Анимация. Стоит как официант, держа поднос с вином и пирожным", 2000, 0, 0},
	{313,"Кот в руке", "Анимация. Персонаж держит кота в руке. Человеческие женщины только", 5000, 0, 0},
	{314,"Пепе-подводник", "Аура. На голове персонажа сидит пепе с маской подводника", 50000, 0, 0},
	{315,"Проклятие Друствара", "Аура. Персонаж окутан таинственной друстварской дымкой", 5000, 0, 0},
	{316,"Усиление ведьм", "Аура. Персонаж левитирует, окутанный всплесками темной энергии", 30000, 0, 0},
	{317,"Произнесение заклинания ведьм", "Анимация. Персонаж произносит заклинание с эффектами магии ведьм Друствара", 10000, 0, 0},
	{318,"Произнесение заклинания ведьм 2", "Анимация. Персонаж произносит заклинание с эффектами магии ведьм Друствара", 15000, 0, 0},
	{319,"Произнесение заклинания ведьм 3", "Анимация. Персонаж произносит заклинание с эффектами магии ведьм Друствара", 15000, 0, 0},
	{320,"Страж леса", "Аура. Персонаж становится серым, а вокруг его летают маленькие лесные огоньки", 10000, 0, 0},
	{321,"Шлем в руке", "Предмет. Персонаж держит шлем в руке с пафосным видом", 2000, 0, 0},
	{322,"Писать в книге", "Предмет. Персонаж наносит записи в книге пером", 1000, 0, 0},
	{323,"Ящик со свитками", "Предмет. Персонаж держит в руках ящик со свитками", 1000, 0, 0},
	{324,"Сокол на руке", "Анимация. К персонажу на руку прилетает сокол и сидит на ней", 10000, 0, 0},
	{325,"Цветы в руках", "Предмет. Персонаж держит перед собой букет двумя руками", 1000, 0, 0},
	{326,"Солидный сундук", "Предмет. Персонаж несет в двух руках солидный сундук", 2000, 0, 0},
	{327,"Смотреть в подзорную трубу", "Предмет. Персонаж смотрит в подзорную трубу. Работает на людях-мужчинах", 5000, 0, 0},
	{328,"Опереться о стол", "Аура. Персонаж опирается о стол. Можно сидя", 1000, 0, 0},
	{329,"Заклинание жрецов моря", "Анимация. Персонаж произносит заклинание жрецов моря", 5000, 0, 0},
	{330,"Штормовая преграда", "Аура. Щит жрецов моря", 5000, 0, 0},
	{331,"Заклинание азерита", "Анимация. Персонаж произносит заклинание с эффектом азерита", 20000, 0, 0},
	{332,"Зов глубин с бездной", "Анимация. Персонаж произносит заклинение жрецов моря с эффектом бездны", 10000, 0, 0},
	{333,"Буря костей", "Аура. Вокруг персонажа крутятся кости, усиленные энергией воды", 20000, 0, 0},
	{334,"Аура потока воды", "Аура. С рук персонажа льются потоки воды", 5000, 0, 0},
	{335,"Мощное колдовство стихий и бездны", "Аура. Мощнейшее колдовство бездны, воды, воздуха и молнии", 100000, 0, 0},
	{336,"Шар бездны", "Анимация. Персонаж в руке колдует шар бездны", 15000, 0, 0},
	{337,"Утопление наг", "Анимация. На голове персонажа удушающий водный купол наг", 2000, 0, 0},
	{338,"Терродактиль на руке", "Анимация. К персонажу на руку прилетает терродактиль и сидит на ней", 10000, 0, 0},
	{339,"Четыре ящика", "Предмет. Персонаж несет четыре ящика друг на друге", 2000, 0, 0},
	{340,"Башмак на голове", "Предмет. На голове у персонажа держится башмак", 2000, 0, 0},
	{341,"Ящик Орды", "Предмет. Персонаж несет перед собой ящик с гравировкой Орды", 1000, 0, 0},
	{342,"Блюдо сыроедов", "Предмет. Персонаж держит перед собой лист, на котором два плода", 1000, 0, 0},
	{343,"Кузнец за работой", "Анимация. Работа кузнеца ", 1000, 0, 0},
	{344,"Тёмный щит-сфера", "Большой сферический щит с расползающимися от него во все стороны белыми энергиями", 70000, 0, 0},
	{345,"Медитация", "Персонаж парит над землей в позе для медитации", 5000, 0, 0},
	{346,"Мистический манашторм", "Персонажа окутывает магический вихрь", 50000, 0, 0},
	{347,"Фиолетовые частицы духа", "Персонажа окутывают фиолетовые частицы духа", 10000, 0, 0},
	{348,"Малая жреческая маска", "Предмет. На голове персонажа появляется маска вуду", 4000, 0, 0},
	{349,"Страж-ворон", "Персонаж синет, становится прозрачным, а над головой летают вороны", 10000, 0, 0},
	{350,"Восходящий луч света", "От персонажа к небу восходит луч света", 50000, 0, 0},
	{351,"Корзина", "Предмет. Персонаж держит в руке корзину", 1000, 0, 0},
	{352,"Раскаленный меч", "Предмет. Персонаж держит в руке раскаленный меч", 1500, 0, 0},
	{353,"Арканный каст", "Персонаж кастует арканное заклинание", 10000, 0, 0},
	{354,"Аура Ци", "Монашеская аура Ци", 10000, 0, 0},
	{355,"Паралич", "Эффект паралича", 500, 0, 0},
	{356,"Пошатывание монаха", "Эффект пошатывания монаха", 5000, 0, 0},
	{357,"Нефритовый вихрь", "Вокруг персонажа кружится освежающий нефритовый вихрь", 5000, 0, 0},
	{358,"Монашеское распыление магии", "Создает вокруг персонажа щит из энергий Ци", 5000, 0, 0},
	{359,"Исцеляющий туман", "Персонажа окутывает исцеляющий туман", 5000, 0, 0},
	{360,"Кокон Ци", "Персонаж помещается в кокон энергий Ци", 10000, 0, 0},
	{361,"Готовить мясо", "Персонаж выставляет перед собой мясо на палке", 1000, 0, 0},
	{362,"Преследование", "Два больших красных глаза над персонажем", 5000, 0, 0},
	{363,"Страж клинков", "Вокруг персонажа летают алые сюрикены", 10000, 0, 0},
	{364,"Туманный купол", "Персонажа окутывает исцеляющий купол Ци", 5000, 0, 0},
	{365,"Транспортировка тауренов", "Персонаж несёт на плечах двух раненных тауренов", 5000, 0, 0},
	{366,"Длани бездны", "Фиолетовые всплески бездны на руках персонажа", 5000, 0, 0},
	{367,"Оранжевый туман", "Персонажа окутывает оранжевый туман", 5000, 0, 0},
	{368,"Щит молний", "Вокруг персонажа кружит шаровая молния", 5000, 0, 0},
	{369,"Чернейшая тьма", "Персонаж становится полностью черным", 5000, 0, 0},
	{370,"Длани бездны 2", "Внушительные всплески энергии бездны на руках персонажа", 10000, 0, 0},
	{371,"Набор путешественника", "Предмет. Набор элитного путешественника", 10000, 0, 0},
	{372,"Дымок с огнем", "Персонаж дымится и у него горят руки", 15000, 0, 0},
	{373,"Аметистовое проклятие", "Персонаж окрашивается в пурпурные оттенки и от него исходят темные всплески энергий", 7500, 0, 0},
	{374,"Обнуление", "Персонаж синеет, а в руках мерцают молнии", 7500, 0, 0},
	{375,"Человек-бирюза", "Персонаж становится бирюзовым, а в руках мерцают молнии", 7500, 0, 0},
	{376,"Антимагический щит", "Зелёный антимагический щит", 5000, 0, 0},
	{377,"Оглушение", "Над головой персонажа крутится маленький вихрь", 1000, 0, 0},
	{378,"Заряженное тьмой оружие", "Оружие заряжается тьмой", 7500, 0, 0},
	{379,"Альфа-лучи", "Персонаж светится лучами", 5000, 0, 0},
	{380,"Обвешаться динамитом", "Персонаж обвешивается динамитом", 5000, 0, 0},
	{381,"Нести коробку", "Персонаж несет коробку", 2000, 0, 0},
	{382,"Обесцветиться", "Персонаж становится черно-белым", 5000, 0, 0},
	{383,"Водоросли", "Персонаж покрывается водорослями", 2000, 0, 0},
	{384,"Крылья валькиры", "Большие, хлопающие крылья из света", 50000, 0, 0},
	{385,"Создать щупальца", "Персонаж создает перед собой три щупальца", 20000, 0, 0},
	{386,"Сложенные крылья валькиры", "Большие, сложенные крылья из света", 50000, 0, 0},
	{387,"Пиратская шляпа", "Предмет. На голове персонажа появляется пиратская шляпа", 5000, 0, 0},
	{388,"Питомец ПаКу", "Питомец ПаКу на плече у персонажа", 20000, 0, 0},
	{389,"Благословление Йотнара", "Персонаж оказывается в центре столпа света, анимация каста, в руках держит титаническую проекцию", 30000, 0, 0},
	{390,"Рунное поддержание", "Каст, под персонажем появляется разлом в форме руны", 15000, 0, 0},
	{391,"Держать дерево", "Персонаж держит дерево", 2000, 0, 0},
	{392,"Перенос сена", "Персонаж несет сено", 2000, 0, 0},
	{393,"Зеленый светильник", "Персонаж держит перед собой зеленый фонарь", 10000, 0, 0},
	{394,"Магическая гравировка", "Каст, персонаж выставляет вперед руку с молнией, а под ногами у него сверкают искры", 10000, 0, 0},
	{395,"Чаровство скверны", "Каст, персонаж выставляет вперед руку с энергиями скверны, а под ногами у него появляется кислотная руна", 10000, 0, 0},
	{396,"Пистоль", "Предмет. В левой руке появляется пистоль", 5000, 0, 0},
	{397,"Пистоль Кул-Тираса", "Предмет. Персонаж встает в боевую позу, а в левой руке появляется Култирасский пистоль", 5000, 0, 0},
	{398,"В плену теней", "Тени окутывают персонажа", 5000, 0, 0},
	{399,"Рунное поддержание", "Каст. Вокруг персонажа крутятся фиолетовые энергии, а под ногами расходятся фиолетовые завихрения", 15000, 0, 0},
	{400,"Избранный валарьяр", "Персонаж становится позолоченным, прозрачным, его руки светятся светом", 20000, 0, 0},
	{401,"Прозрачность", "Персонаж становится прозрычным и слегка фиолетовым", 10000, 0, 0},
	{402,"Всплески бездны", "Персонажа окутывают внушительные всплески энергий бездны", 30000, 0, 0},
	{403,"Облик духа", "Персонаж становится похожим на духа", 20000, 0, 0},
	{404,"Пагуба", "Персонажа окружает шар фиолетовых всплесков энергий", 15000, 0, 0},
	{405,"Явление смерти", "Две некротические руки появляются из под земли и хватают персонажа", 2000, 0, 0},
	{406,"Удушье смерти", "Удушение персонажа с эффектом некротических энергий", 2000, 0, 0},
	{407,"Появление из мира духов", "Красивое появление. Персонаж резко появляется с громким звуком", 10000, 0, 0},
	{408,"Арканное тление", "Красивое исчезновение. Персонаж постепенно растворяется в аркане", 15000, 0, 0},
	{409,"Алое тление", "Красивое исчезновение. Персонаж постепенно растворяется в алых тонах", 15000, 0, 0},
	{410,"Призрак с мечем в спине", "Персонаж становится призраком, а в спине у него торчит меч", 10000, 0, 0},
	{411,"Ворожба друстов", "Персонаж темнеет, а вокруг него проявляются магия друстов", 7500, 0, 0},
	{412,"Друстварский колдовской ритуал", "Столп друстварских энергий", 30000, 0, 0},
	{413,"Теневое тление", "Красивое исчезновение. Персонаж постепенно растворяется в фиолетовых тонах", 15000, 0, 0},
	{414,"Чародейский циклон", "Вокруг персонажа крутятся арканные формулы", 20000, 0, 0},
	{415,"Наполнение арканой", "Персонаж высталяет вперед оружие которое впитывает магию из окружения", 50000, 0, 0},
	{416,"Зачитывание заклинания", "Персонаж читает заклинание из книги и мерцает арканными энергиями", 30000, 0, 0},
	{417,"Скайбокс Ульдума", "Скайбок неба Ульдума", 750000, 0, 0},
	{418,"Небо НерЗула", "Скайбок неба НерЗула", 750000, 0, 0},
	{419,"Небо Ша", "Скайбокс неба Ша", 750000, 0, 0},
	{420,"Скайбокс Джайны, снег", "Скайбокс Джайны, падает снег", 750000, 0, 0},
	{421,"Чумное небо", "Скайбокс чумного неба с пеплом", 750000, 0, 0},
	{422,"Звездочет небо 3", "Скайбокс фиолетового неба с оскверненными бездной планетами", 750000, 0, 0},
	{423,"Зера небо", "Скайбокс звездного неба с зеленой планетой", 750000, 0, 0},
	{424,"Небо над ледником", "Скайбокс неба над ледником", 750000, 0, 0},
	{425,"Даларан скверна", "Скайбокс неба с плывущими энергиями скверны", 750000, 0, 0},
	{426,"Анторус небо", "Скайбокс неба Анторуса", 750000, 0, 0},
	{427,"Шторм небо", "Скайбокс неба затянутого тучами, идет дождик", 750000, 0, 0},
	{428,"Кровавая луна", "Скайбокс неба с кровавой луной", 750000, 0, 0},
	{429,"Обесцвечивание", "Персонаж обесцвечивается и становится прозрачным", 15000, 0, 0},
	{430,"Алый столп", "От персонажа исходит столп алого света", 15000, 0, 0},
	{431,"Парашют", "Персонаж виснет на парашюте", 5000, 0, 0},
	{432,"Закапывание", "Вокруг персонажа появляется облако пыли", 10000, 0, 0},
	{433,"Накидка тигра", "За спиной персонажа появляется символ тигра", 10000, 0, 0},
	{434,"Парашют", "Персонаж планирует на парашюте", 7500, 0, 0},
	{435,"Массовое исцеление", "Массовое исцеление в большой области вокруг персонажа", 15000, 0, 0},
	{436,"Крюк", "Предмет. Большой крюк в правой руке", 5000, 0, 0},
	{437,"Острошквал", "Две шарообразные молнии за спиной персонажа", 15000, 0, 0},
	{438,"Репликация!", "Визуальный эффект репликации Элисанды", 30000, 0, 0},
	{439,"Резонанс", "Под ногами персонажа появляется нефритовая дымка", 7500, 0, 0},
	{440,"Энергетическая башня", "Создание энергетической башни на месте персонажа", 50000, 0, 0}
}

RPSCoreFramework.Interface.Auras.Show = {}

RPSCoreFramework.Interface.ActiveAuraCounter = 0

RPSCoreFramework.Interface.Auras.Message = {
	{" ", 0},
	{" ", 0},
	{" ", 0},
	{" ", 0},
	{" ", 0},
	{" ", 0}
}

RPSCoreFramework.Interface.Auras.Initialized = false
RPSCoreFramework.Interface.Auras.GhostClick = false
RPSCoreFramework.Interface.Auras.AllowUpdate = true

DarkmoonWIPFrame.content.flash1Rotation:SetDuration(8);
DarkmoonWIPFrame.content.flash2Rotation:SetDuration(8);
--DarkmoonWIPFrame.content.GearRotation:SetDuration(8);
