RPSCoreFramework = LibStub("AceAddon-3.0"):NewAddon(CreateFrame("Frame"), "RPSCoreFramework", "AceHook-3.0", "AceTimer-3.0")
RPSCoreFramework.HDB = LibStub("HereBeDragons-1.0")
RPSCoreFramework.HDB.Pins = LibStub("HereBeDragons-Pins-1.0")
RPSCoreFramework.Literature = {};
RPSCoreFramework.Scroller = {};
RPSCoreFramework.Display = {};
RPSCoreFramework.Interface = {};
RPSCoreFramework.DB = {};
RPSCoreFramework.DB.Pins = {}
RPSCoreFramework.Map = {}
RPSCoreFramework.Map.Icons = {}
RPSCoreFramework.Map.PinButtons = {}

RPSCoreFramework.DifficultRaces = {
	"Void Elf",
	"Highmountain Tauren",
	"Blood Elf",
	"Draenei",
	"Lightforgen Draenei",
	"Pandaren",
	"Night Elf"
}

RPSCoreFramework.DifficultClases = {
	"Daemon hunter",
	"Death knight"
}

RPSCoreFramework.Prefix = "DRPS"
RegisterAddonMessagePrefix(RPSCoreFramework.Prefix)

RPSCoreFramework.FreeStats = 0;
RPSCoreFramework.FreeStatsCached = 0;
RPSCoreFramework.TargetAura = 1000012;
RPSCoreFramework.TimerID = false;
RPSCoreFramework.ShowMain = false;
RPSCoreFramework.RequestUnlearn = 50000;
RPSCoreFramework.RequestRescale = 500000;
RPSCoreFramework.GetLastClickedSlot = "chest";
RPSCoreFramework.StatsLevel = 40;
RPSCoreFramework.MyScale = 0 -- Takes it from the server if -1 we lock the slider and disable it.
RPSCoreFramework.ChoosedScale = 0

RPSCoreFramework.Interface.HighlightedButtons = {};
RPSCoreFramework.Interface.HighlightedTabButtons = {};
RPSCoreFramework.Interface.HidingFrames = {};
RPSCoreFramework.Interface.MenuButtons = {};
RPSCoreFramework.Interface.SubMenuButtons = {};

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
	head = ".disp head ",
	shoulder = ".disp shoulder ",
	back = ".disp back ",
	chest = ".disp chest ",
	shirt = ".disp shirt ",
	tabard = ".disp tabard ",
	wrist = ".disp wrist ",
	hands = ".disp hands ",
	waist = ".disp waist ",
	legs = ".disp legs ",
	feet = ".disp feet ",
	mainhand = ".disp mainhand ",
	offhand = ".disp offhand "
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


RPSCoreFramework.Interface.Auras = {
	{"Походный рюкзак", "Практично и стильно", 2000, 0, 0},
	{"Колчан со стрелами", "Самый обычный", 2000, 0, 0},
	{"Пандаренский колчан со стрелами", "Стрелы очень длинные", 10000, 0, 0},
	{"Рюкзак с четырьмя копьями", "Копья длинные и красные", 50000, 0, 0},
	{"Мешок семян", "За спину. Большой", 5000, 0, 0},
	{"Котомка", "Маленькая сумочка за спину", 5000, 0, 0},
	{"Сумка-котомка", "За спину", 8000, 0, 0},
	{"Шипастый щит", "За спину. Очень большой", 50000, 0, 0},
	{"Мешок с мешками", "За спину. Для тех, кто на спине тащит весь походный лагерь", 20000, 0, 0},
	{"Бочка", "За спину. Очень большая", 20000, 0, 0},
	{"Крылья глайдера", "За спину. Большие. Вызывают анимацию полета", 50000, 0, 0},
	{"Шахтерский бур", "В руках. Как оружие", 10000, 0, 0},
	{"Череп", "Маска на голову. Отлично подойдет для троллей и серийных убийц", 7000, 0, 0},
	{"Огонь у левого глаза", "Светло-голубой, магический", 50000, 0, 0},
	{"Мирно спать", "Эмоция. С эффектом Zzz", 2000, 0, 0},
	{"Притвориться зомби", "Эмоция. Персонажа перекашивает на бок", 5000, 0, 0},
	{"Поднять правую руку вверх", "Эмоция. Название говорит само за себя", 5000, 0, 0},
	{"Левую руку в кулак", "Эмоция. Персонаж сжимает левую руку в кулак перед собой", 5000, 0, 0},
	{"Гордая стойка", "Эмоция. Проигрывается с повтором", 5000, 0, 0},
	{"Безысходность", "Эмоция. Над персонажем появляется тучка, а его лицо источает депрессию", 5000, 0, 0},
	{"Играть на арфе", "Эмоция. Игра на арфе. С музыкой", 10000, 0, 0},
	{"Оказывать первую помощь", "Эмоция. Персонаж садится на колени и лечит, с крестиками в воздухе", 2000, 0, 0},
	{"Присесть и пилить", "Эмоция. Персонаж присаживается и пилит пилой", 2000, 0, 0},
	{"Сальто назад", "Эмоция. Персонаж делает сальто назад. Единожды", 5000, 0, 0},
	{"Катиться клубком", "Эмоция. Персонаж катится клубком вперед. Безвременно", 5000, 0, 0},
	{"Красивый удар мечом", "Эмоция. Как в фильмах. Техника Тайрекса", 10000, 0, 0},
	{"Залп стрел", "Эмоция. Расстреливает кучу стрел по округе. Эпично", 10000, 0, 0},
	{"Стойка с ружьем", "Эмоция. Персонаж круто держит пушку в руках от бедра и может ходить так", 5000, 0, 0},
	{"Огнемет", "Эмоция. Оружие у персонажа начинает стрелять огнем перед ним", 20000, 0, 0},
	{"Атака волной бездны", "Эмоция. Персонаж наносит удар оружием, от которого исходит бездна", 10000, 0, 0},
	{"Круг света", "Аура. Персонажа начинает окружать круг света.", 20000, 0, 0},
	{"Крылья света", "Аура. За спиной у персонажа появляются крылья света", 20000, 0, 0},
	{"Щит бездны", "Аура. Персонажа окружает впечатляющий безднощит", 80000, 0, 0},
	{"Магия бездны", "Эмоция. Персонаж сотворяет заклинание бездны, сопровождаемое темными сгустками", 10000, 0, 0},
	{"Медитация бездны", "Эмоция. Персонаж преклоняет колени, и его охватывают потоки бездны", 10000, 0, 0},
	{"Сотворение шара бездны", "Эмоция. Персонаж сотворяет шар бездны перед собой", 10000, 0, 0},
	{"Арканный щит перед собой", "Эмоция. Появляется арканный щит перед персонажем", 10000, 0, 0},
	{"Арканный туман", "Аура. Персонажа окружает арканный туман", 20000, 0, 0},
	{"Метель", "Аура. Вокруг персонажа появляется метель", 20000, 0, 0},
	{"Усиление огнем", "Аура. Персонажа охватывает пульсирующий эффект пламени", 10000, 0, 0},
	{"Огонь на ладони", "Эмоция. Персонаж держит руки перед собой, будто что-то сотворяет. В руках огонек", 10000, 0, 0},
	{"Мощная магия огня", "Эмоция. Персонаж сотворяет магию огня, впечатлительно", 20000, 0, 0},
	{"Огнеарканный щит для группы", "Аура и эмоция. Группу защищает мощный огненный щит", 100000, 0, 0},
	{"Штормовой круг", "Аура. Персонажа охватывает штормовой круг", 20000, 0, 0},
	{"Вихрь духов-защитников", "Аура. Персонажа охватывает вихрь духов-защитников", 10000, 0, 0},
	{"Тачка", "Предмет. Перед персонажем появляется тачка", 1000, 0, 0},
	{"Лейка", "Предмет. В руке у персонажа появляется лейка", 1000, 0, 0},
	{"Корзина с фруктами", "Предмет. В руках у персонажа появляется корзина с фруктами", 1000, 0, 0},
	{"Кусты камуфляжные", "Предмет. В руках у персонажа появляются кусты для камуфляжа", 2000, 0, 0},
	{"Ящик с медикаментами", "Предмет. В руках персонаж держит ящик с медикаментами", 1000, 0, 0},
	{"Две корзины", "Предмет. В руках персонаж несет две корзины", 1000, 0, 0},
	{"Шесть вязанок сена", "Предмет. Персонаж несет на себе шесть вязанок сена", 4000, 0, 0},
	{"Подзорная труба", "Предмет. В руках у персонажа подзорная труба", 2000, 0, 0},
	{"Доска", "Предмет. В руках персонаж несет доску", 1000, 0, 0},
	{"Бомбы", "Предмет. В руках у персонажа две бомбы", 2000, 0, 0},
	{"Ящик", "Предмет. Персонаж перед собой несет ящик", 1000, 0, 0},
	{"Облик тьмы", "Аура. Облик тьмы как у жрецов", 10000, 0, 0},
	{"Колдунство скверны", "Эффект. В руках у персонажа появляется пламя скверны", 5000, 0, 0},
	{"Теневой дым", "Аура. Персонаж становится прозрачнее, и его окружает дым", 10000, 0, 0},
	{"Арканный барьер", "Аура. Арканный барьер для всей группы", 100000, 0, 0},
	{"Магма на ладонях", "Эффект. Руки персонажа покрываются магмой", 20000, 0, 0},
	{"Вихрь пламени", "Аура. Персонажа окружает вихрь пламени", 20000, 0, 0},
	{"Аркана на ладонях", "Аура. Аркана обволакивает ладони персонажа", 10000, 0, 0},
	{"Уснуть на стуле", "Анимация. Спит сидя с Zzz", 5000, 0, 0},
	{"Цветы в руках", "Предмет. В обоих руках по цветку", 1000, 0, 0},
	{"Алый цветок", "Предмет. В руках у персонажа алый цветок", 1000, 0, 0},
	{"Перо", "Предмет. В руках у персонажа перо", 1000, 0, 0},
	{"Мешок с бомбами", "На спину. Большой мешок с бомбами", 10000, 0, 0},
	{"Произнесение заклинания природы", "Эмоция. Персонаж применяет заклинание природы", 5000, 0, 0},
	{"Произнесение заклинания льда", "Эмоция. Персонаж применяет заклинание льда", 5000, 0, 0},
	{"Ритуальный костюм", "Одежда. Ритуальный череп на голове и черепа на спине", 10000, 0, 0},
	{"Ледяная глыба", "Эффект. Персонаж превращается в ледяную глыбу", 10000, 0, 0},
	{"Дым бездны", "Аура. Персонажа охватывает дым бездны", 20000, 0, 0},
	{"Пламя скверны", "Аура. Персонажа охватывает пламя скверны", 20000, 0, 0},
	{"Демонический круг", "Эффект. Под ногами персонажа появляется демонический круг", 20000, 0, 0},
	{"Ловушка Иллидари", "Эффект. Появляется ловушка Иллидари", 50000, 0, 0},
	{"Зонтик", "Предмет. Персонаж в руке держит зонтик", 5000, 0, 0},
	{"Мешок на палочке", "Предмет. Персонаж держит мешок на палочке", 1000, 0, 0},
	{"Охапка сена", "Предмет. Персонаж держит одну охапку сена на плече", 1000, 0, 0},
	{"Полено", "Предмет. Персонаж держит полено в руке", 1000, 0, 0},
	{"Игра на лютне", "Эмоция. Персонаж играет на лютне. Чуть кривовато", 5000, 0, 0},
	{"Подзорная труба на колене", "Эмоция. Становится на колено и смотрит в подзорную трубу", 5000, 0, 0},
	{"Декорация дома", "Одежда. Надевает на себя картонный дом", 5000, 0, 0},
	{"Декорация дерева", "Одежда. Надевает на себя картонное дерево", 5000, 0, 0},
	{"Мяч", "Предмет. Мяч в руку", 2000, 0, 0},
	{"Мешок на плечо", "Предмет. Положить мешок на плечо", 1000, 0, 0},
	{"Барабанные палочки", "Предмет. Барабанные палочки в руки", 2000, 0, 0},
	{"Рюкзак шнотцев", "На спину. Рюкзак со всякими полезными мелочами впридачу", 5000, 0, 0},
	{"Колчан со стрелами 2", "На спину. Посередине, красивенький, пять стрел торчат", 2000, 0, 0},
	{"Лютня на спину", "На спину. Лютня на спине", 2000, 0, 0},
	{"Штандарт пылающего клинка", "На спину. Штандарт пылающего клинка как у самураев", 5000, 0, 0},
	{"Свиток на спину", "На спину. Большой и маленький свитки на спину", 10000, 0, 0},
	{"Пыль под ногами", "Аура. Под ногами появляется интенсивно изменяющаяся пыль", 10000, 0, 0},
	{"Гигантские скверно-крылья", "На спину. На спине отрастают гигантские крылья, как у метаморфозы", 50000, 0, 0},
	{"Скверно-крылья", "На спину. На спине появляются крылья, как у метаморфозы. В самый раз", 20000, 0, 0},
	{"Пал на землю от стрел", "Анимация. Лечь как убитый, при этом с кучей пронзенных стрел", 1000, 0, 0},
	{"Неистовство стихий", "Аура. Персонаж-шаман эпично окружает себя разными стихиями", 50000, 0, 0},
	{"Магия крови на правой руке", "Аура. На правой руке появляется эффект магии крови", 10000, 0, 0},
	{"Арканно-туманный щит", "Аура. Персонажа окружает арканно-туманный щит", 10000, 0, 0},
	{"Раскол от скверны", "Аура. Под ногами появляется раскол от скверны", 10000, 0, 0},
	{"Медитация монахов", "Эмоция. Монашеская медитация", 5000, 0, 0},
	{"Удар Тэньзо", "Эмоция. Эпично летит с ногой вперед.", 10000, 0, 0},
	{"Ветряная вертушка", "Эмоция. Эпично крутится, вздымая пыль. Монашеское", 20000, 0, 0},
	{"Крутить вокруг себя булыжники", "Эмоция. Магия земли. Крутит вокруг себя булыжники", 10000, 0, 0},
	{"Барьер летающих булыжников", "Аура. Вокруг персонажа летают булыжники. Магия земли", 10000, 0, 0},
	{"Аура ветра", "Аура. Магия воздуха. Эпично", 10000, 0, 0},
	{"Произнесение заклинания воздуха", "Эмоция. Персонаж произносит электрико-воздушное заклинание", 10000, 0, 0},
	{"Ледяной поток", "Эмоция. Эпичный большой ледяной поток перед заклинателем", 20000, 0, 0},
	{"Свет Элуны", "Аура. Свет Элуны", 10000, 0, 0},
	{"Нейтрализующий щит", "Ауры. Персонажа окружает щит сквернобездны", 20000, 0, 0},
	{"Групповой световой щит", "Аура. Поле боя окружает большущий щит света. Крайне эпично", 100000, 0, 0},
	{"Магия барда", "Эмоция. Сотворяет некое звуко колдовство", 5000, 0, 0},
	{"Квадратный фонарик", "Предмет. Фестивальный пандаренский фонарик в руках", 2000, 0, 0},
	{"Бочка с ядохимикатами", "На спину. Бочка с ядохимикатами", 10000, 0, 0},
	{"Венок на голову", "Предмет. Веночек на голову", 5000, 0, 0},
	{"Камуфляж", "Анимация. Персонаж передвигается как в незаметности", 2000, 0, 0},
	{"Льдистый путь", "Эффект. Способность ходить по воде", 10000, 0, 0},
	{"Быть связанным ловчей веревкой", "Эффект. Персонаж сидит, связанный", 100, 0, 0},
	{"Горение", "Эффект. Персонаж горит, будто его подожгли, с анимацией получения урона", 100, 0, 0},
	{"Теневые оковы", "Эффект. Персонаж оказывается скован теневыми оковами и не может передвигаться", 100, 0, 0},
	{"Оплетающие корни", "Эффект. Персонажа оплели корни, и он не может двигаться", 100, 0, 0},
	{"Восклицательный знак", "Аура. Над головой появляется восклицательный знак, словно имеется задание", 5000, 0, 0},
	{"Огромный колчан ", "На спину. Как пандаренский колчан, только выше расположен. Подходит людям", 10000, 0, 0},
	{"Улучшенное скверноколдунство", "Анимация. Обе руки горят пламенем, улучшенная анимация произнесения заклинания", 10000, 0, 0},
	{"Аура кошмара", "Аура. По всему персонажу идут линии", 10000, 0, 0},
	{"Целиться из дробовика", "Анимация. Персонаж с особо злостным лицом, держа дробовик в одной руке, целится", 5000, 0, 0},
	{"Целиться из лука", "Анимация. Персонаж стоит на колене и целится из лука", 5000, 0, 0},
	{"Ведро с рыбой", "Предмет. В руках ведро с рыбой", 1000, 0, 0},
	{"Картина в руках", "Предмет. Персонаж держит картину в руках", 1000, 0, 0},
	{"Картина в руках 2", "Предмет. Персонаж держит другую картину в руках, со стражником", 1000, 0, 0},
	{"Пепе", "На голову. На голове появляется птичка пепе", 50000, 0, 0},
	{"Арканный щит", "Аура. Мага окружает арканный щит", 10000, 0, 0},
	{"Большой арканный щит", "Аура. Мага окружает большой арканный щит. В процессе колдует", 10000, 0, 0},
	{"Аура света", "Аура. Под ногами у персонажа регулярно появляются символы света", 10000, 0, 0},
	{"Держать факел в руке", "Анимация. Анимация держания факела или копья в руке. Факел не прилагается", 2000, 0, 0},
	{"Петь", "Анимация. Персонаж поет, а над ним аура музыки", 5000, 0, 0},
	{"Благословление Элуны", "Аура. Персонаж становится полупрозрачным и около него падают мелкие звезды", 10000, 0, 0},
	{"Благословление Анше", "Аура. Персонаж становится полупрозрачным и испытывает благословление Анше", 10000, 0, 0},
	{"Древо жизни", "Превращение. Персонаж превращается в древо жизни", 10000, 0, 0},
	{"Портал Изэры", "Аура. Друидское. Персонажа окружает аура Изэры", 10000, 0, 0},
	{"Великий барьер", "Групповая аура. Персонажа окружает на все поля боя барьер фиолетового цвета", 100000, 0, 0},
	{"Бирюзовый призрак", "Аура. Персонаж становится прозрачным и бирюзовым", 10000, 0, 0},
	{"Камуфляж темной магии", "Аура. Персонаж крадется как в незаметности, краснеет и излучает дымку холода", 10000, 0, 0},
	{"Суперкамуфляж", "Аура. Персонаж становится практически незаметным", 15000, 0, 0},
	{"Свечение Элуны", "Аура. Персонаж становится источником сильного света", 10000, 0, 0}
}

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