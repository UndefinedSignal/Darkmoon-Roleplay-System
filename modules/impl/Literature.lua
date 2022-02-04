RPSCoreFramework.Literature.CharacterPowers = {
	{"Обычный персонаж", [[Персонаж ничем не выделяется среди простых горожан, ремесленников, воинов. Обычные персонажи могут претендовать только на создание обычных предметов.]]}, 
	{"Умелый персонаж", [[Персонаж начинает преуспевать в своем деле. В бою он может сразиться с бывалым воякой или умелым магом. Опытные персонажи могут претендовать на создание необычных предметов.]]},
	{"Выдающийся персонаж", [[Выдающиеся персонажи достигли высот, недоступных многим. По силам персонаж может претендовать на ветерана воины, начинающего представителя героического класса. К этому моменту выдающиеся персонажи могут стать частично известными в некоторых местах Азерота. Выдающиеся персонажи могут претендовать на создание редких предметов.]]},
	{"Значимый персонаж", [[С этого момента персонаж может творить значимые дела. Сил хватит, чтобы одолеть в одиночку несколько разбойников, а слава о нем может простираться на целые регионы. Такие персонажи могут играть весомые роли в великих событиях. Значимые ремесленники способны делать мифические предметы.]]},
	{"Героический персонаж", [[Абсолютные мастера своего дела. Герои в одиночку способны победить отряд пехотинцев. Многих из таких персонажей могут узнать в различных городах, и к ним будет особое отношение. О некоторых из них, которые впоследствии становятся великими, слагают легенды.]]}
};

RPSCoreFramework.Literature.CharacterForce = [[
<html><body>
<p align="left">На Darkmoon абсолютную силу персонажа характеризует уровень. Начальный уровень - 30, максимальный - 120. Он повышается автоматически за отыгрыш сервером, а также дополнительно за творчество (отчеты, анкеты, квенты) и прочее.</p><br/>

<h3 align="center">|cFF7f7f7f]]..RPSCoreFramework.Literature.CharacterPowers[1][1]..[[</h3><h3 align="center">30-49 уровень|r</h3>
<p align="left">]]..RPSCoreFramework.Literature.CharacterPowers[1][2]..[[</p><br/><h3 align="center">|cFF76923c]]..RPSCoreFramework.Literature.CharacterPowers[2][1]..[[</h3><h3 align="center">50-69 уровень|r</h3>
<p align="left">]]..RPSCoreFramework.Literature.CharacterPowers[2][2]..[[</p><br/><h3 align="center">|cFF1f497d]]..RPSCoreFramework.Literature.CharacterPowers[3][1]..[[</h3><h3 align="center">70-89 уровень|r</h3>
<p align="left">]]..RPSCoreFramework.Literature.CharacterPowers[3][2]..[[</p><br/><h3 align="center">|cFF5f497a]]..RPSCoreFramework.Literature.CharacterPowers[4][1]..[[</h3><h3 align="center">90-109 уровень|r</h3>
<p align="left">]]..RPSCoreFramework.Literature.CharacterPowers[4][2]..[[</p><br/><h3 align="center">|cFFe36c09]]..RPSCoreFramework.Literature.CharacterPowers[5][1]..[[</h3><h3 align="center">110+ уровень|r</h3>
<p align="left">]]..RPSCoreFramework.Literature.CharacterPowers[5][2]..[[</p><br/><p align="left">Что если ваш персонаж является, например, известным архимагом, но его уровень всего 55ый? В таком случае владельцу персонажа рекомендуется придумать персонажу причину, по которой он временно не соответствует заявленной планке. Например, после последнего тяжелого боя еще не пришёл в себя. Или был проклят. Или потерял память. </p><br/>

<p align="left">Таблица лишь приблизительно отображает степень величия и силы персонажа. Допустима ситуация, что великий герой остается практически безызвестным, и наоборот, обычный персонаж может прославиться экстравагантным поступком.</p><br/>
</body></html>]]

RPSCoreFramework.Literature.BattleSystem = [[
<html><body>
<p align="left">На Darkmoon используется костемеханическая система боя. Это значит, что стандартные способности персонажей не используются в бою между персонажами и имеют чисто косметический эффект. Стандартные характеристики здоровья, маны, силы, шанса критического удара и прочего. также не работают.</p>

<p align="left">Вместо них предусмотрено 8 характеристик: сила, ловкость, интеллект, критический шанс, стойкость, сноровка, воля, дух. Они не связаны со стандартными (механическими) параметрами и изначально равны 1. На старте персонаж имеет 5 очков здоровья.</p>

<p align="left">Бой между персонажами осуществляется использованием специальных заклинаний, которые появляются с момента создания персонажа. Найти способности для боя можно в книге заклинаний. Чтобы открыть ее, достаточно нажать P латинское.</p>

<br/><p align="center">|TInterface\AddOns\RPSDarkmoon\resources\attack:200:200|t</p><br/>

<p align="left">Способности представляют собой атаку, использующую одну из характеристик персонажа. Успешность атаки зависит от того, насколько развита соответствующая характеристика и насколько плохо защищен враг от подобной атаки.</p><br/>

<p align="left">Критический шанс позволяет нанести дополнительный урон:</p><br/>
<p align="center">|TInterface\AddOns\RPSDarkmoon\resources\critchance:64:198|t</p><br/>

<p align="left">Также имеется способность лечения себя и союзников:</p><br/>

<p align="center">|TInterface\AddOns\RPSDarkmoon\resources\heal:64:198|t</p><br/>

<p align="left">Шанс успешного лечения зависит от развития характеристики "дух" у персонажа.</p>

<p align="left">Защитные навыки понижают шанс успеха вражеской атаки противника:</p>

<br/><p align="center">|TInterface\AddOns\RPSDarkmoon\resources\def:200:200|t</p><br/>

<p align="left">Всё, что требуется от вас - это лишь выбрать цель, которую требуется атаковать или лечить, и нажать на одну из четырёх кнопок. Система автоматически подсчитывает успешность или провал действия, на основании удачи (броски костей) и характеристик персонажей:</p>

<br/><p align="center">|TInterface\AddOns\RPSDarkmoon\resources\chatattack:64:450|t</p><br/>

<p align="left">Текущее количество здоровья персонажа отображается рядом с сердечком, которое левее от мини-карты в панели дебафов:</p>

<br/><p align="center">|TInterface\AddOns\RPSDarkmoon\resources\health:168:256|t</p><br/>

<p align="left">Прокачивать характеристики можно в специальном меню. Оно открывается путем нажатия одноименной кнопки "Характеристики", расположенной в левом столбце.</p>

<br/><p align="center">|TInterface\AddOns\RPSDarkmoon\resources\characteristics:286:450|t</p><br/>

<p align="left">За каждый уровень дается по 2 очка, которыми можно повысить одну из характеристик, а каждые 10 - уровень здоровья повышается на 1. Примечание, величину характеристики нельзя поднять выше значения, равного "Уровень персонажа - 39".</p>

<br/><p align="left">Так как сражаться-то в итоге? Используете одну из трех способностей (атака силой/ловкостью/интеллектом) по противнику и нажимаете, как только она перезаряжается (3 секунды) до тех пор, пока у врага не кончится здоровье. После этого вы можете оставить его валяться раненым, помочь ему встать или добить, что не рекомендуется, ведь его персонаж умрет!</p>

<p align="left">Если вы хотите более красочного боя, вы всегда можете попробовать договориться с оппонентом на "пошаговый" бой, когда вначале одна из сторон отписывает свое действие, а после этого производит бросок кубика.</p>

<p align="left">Примечание. Смерть персонажа означает перманентную блокировку доступа к персонажу. Чтобы ее снять, надо воскресить персонажа ролевым способом и составить отчет на воскрешение. Только после одобрения отчета персонаж считается воскрешенным, и с него будет снят бан.</p>

<br/><p align="left">В дальнейшем усиливаете характеристику для приоритетной атаки, прокачиваете защиту. Также можете прокачивать дух, если ваш персонаж - лекарь. </p>


<p align="left">В массовых битвах очень важно координироваться с союзниками, находить тех противников, которые наименее защищены от вашей атаки или являются лекарями. Для лекарей важно не подставляться под удар и прятаться за препятствиями.</p>

<br/><h2 align="center">Дополнительные факты</h2><br/>

<p align="left">• Пока персонаж не достиг 40ого уровня, его броски равны 1-80.</p>
<p align="left">• Независимо от значения от характеристик, предметов и бонусов, максимально допустимый бросок составляет 80-100.</p>
<p align="left">• После того, как ваш персонаж был создан, он в течение 3 дней, проведенных в игре, не может грабить, избивать и добивать.</p>
<p align="left">• Ограбленного персонажа нельзя ограбить повторно в течение 3 часов.</p>
<p align="left">• Раненый персонаж не может грабить, добивать и избивать других персонажей в течение небольшого промежутка времени.</p>
<p align="left">• Величина бросков раненого персонажа снижена.</p><br/><br/></body></html>]]

RPSCoreFramework.Literature.CharRessurection = [[
<html><body>
<p align="left">Всегда существует вероятность, что персонаж умрет: погибнет в бою, будет отравлен, неудачно телепортируется и тому подобное. В этом случае персонаж блокируется, и за него нельзя играть до момента воскрешения.</p><br/>

<p align="left">В общем случае воскрешение осуществляется следующим образом: в случае наличия игроков, чьи персонажи могут воскресить погибшего, они обыгрывают соответствующий ритуал, который публикуется на сайт в качестве отчета. Если же таких нет, игрок волен отыграть самостоятельно, создав временного персонажа для отыгрыша воскрешения, или найти ведущего, который поможет ему обыграть ситуацию.</p><br/>

<p align="left">После того, как отчет одобрили, с персонажа снимается блокировка, и за него можно играть в дальнейшем. Согласно правилу 6.7., с воскресшего снимается 30% уровней свыше начального уровня при составлении отчета с высокой требовательностью. Допустим, если персонаж был 80ого уровня, его уровень понизится до 60ого. Уровень персонажа 51ого уровня позинится до 42 и так далее. При составлении отчета с низкой требовательностью с воскресшего снимается 50% уровней.</p>
<p align="left">Чем выше число воскрешений одного и того же персонажа, тем сложнее воскреситься и тем тяжелее могут быть последствия.</p>
<p align="left">Одобряющий отчет может добавить последствия воскрешения. Например после смерти от большого и злого кабана, у персонажа развилась кабанофобия. Или, что в течение нескольких дней, персонаж должен лежать на медицинской койке.</p><br/>

<p align="left">Существует 3 типа воскрешений – боевые воскрешения, воскрешения через целителей душ (за богатства) и классические воскрешения.</p><br/>

<h1 align="center">Воскрешение через целителя душ</h1><br/>

<p align="left">Воскрешение за золото или предметы. Особенностью является то, что для воскрешения через целителя душ достаточно отчета низкой значимости и при этом персонаж потеряет лишь 30% от накопленных свыше 30 уровней. Персонаж также забывает обстоятельства, при которых был убит, а также личность убийц. В остальном, персонаж не получает никаких дополнительных штрафов или побочных эффектов за этот тип воскрешения. Игрок может самостоятельно, создав персонажа-клона или персонажа-проекцию, или с помощью ведущего отыграть ситуацию как его персонаж попадает к целителю душ и расплачивается своими богатствами.</p><br/>

<p align="left">За свои услуги Целители Душ берут плату в размере:</p><br/>

<p align="left">Первое воскрешение: 1 уровень = 1.5 золотых.</p>
<p align="left">Второе воскрешение: 1 уровень = 2.5 золотых.</p>
<p align="left">Третье воскрешение: 1 уровень = 3 золотых.</p>
<p align="left">Целители душ не пойдут на последующие воскрешения.</p><br/>

<p align="left">После отыгрыша и выкладывания отчета на воскрешение, игрок высылает средства и/или предметы (1 серый предмет = 1 з, 1 белый предмет = 2 з, 1 зеленый предмет = 6 з, 1 синий предмет = 18 з, 1 фиолетовый предмет = 54 з) по почте на мастерского персонажа Мастер. После одобрения воскрешения, персонаж будет разблокирован после того, как мастер подтвердит факт получения богатств целителями душ.</p><br/>

<h1 align="center">Классическое воскрешение</h1><br/>

<p align="left">На данный момент полностью совпадает с описанием в разделе Введение.</p><br/>

<h1 align="center">Боевое воскрешение</h1><br/>

<p align="left">В процессе разработки.</p><br/><br/></body></html>]]

RPSCoreFramework.Literature.StatsDrop = [[
<html><body>
<p align="left">Чтобы сбросить текущие характеристики и распределить их заново, необходимо нажать на кнопку "Сброс".</p>
<p align="left">Далее подтвердить действие. Внимание, для сброса необходимо потратить 5 золотых монет. Кнопка "Да" становится нажимаемой через 5 секунд, чтобы уберечь от случайного нажатия.</p><br/>
<p align="center">|TInterface\AddOns\RPSDarkmoon\resources\Statsdrop:249:382|t</p>
</body></html>]]

RPSCoreFramework.Literature.DarkmoonInfo = [[<html><body><br/><p align="center">Приветствуем вас на ролевом сервере по World of Warcraft - Darkmoon!</p>
<br/><p align="left">Это обширный мир, в котором можно встретить множество приключений. Опасности будут вас ожидать за каждым углом и поворотом. Darkmoon может осуществить мечту многих игроков окунуться сполна в этот мир, наслаждаясь великими просторами Азерота, становясь героем, искателем приключений, или же просто жить, как самый простой обитатель этого сеттинга, работая, например, каким-нибудь кузнецом или же играть рубаку на службе у Орды. </p>
<br/><p align="left">Darkmoon может предоставить вам огромный спектр развития своего персонажа в мире Warcraft: желаете прославиться на века? Создайте начинающего свой путь воина, мага, чернокнижника и любого, кто вам понравится, развивайте его, получайте награды за свои деяния и становитесь частью истории! Чем же вас может заинтересовать ещё этот проект?</p>
<br/><p align="left">  - Уникальная система развития героя, а так же собственная боевая система.</p>
<p align="left">  - История, пишущаяся здесь, может поддаваться корректировки со стороны игроков, что могут влиять на неё и даже добавляя что-то новое!</p>
<br/><p align="left">На ролевом проекте Darkmoon Вам предоставлены все удобства для начинаний в игре. Начиная от простого и заканчивая сложным, команда проекта позаботилась о том, чтобы Ваша игра была комфортной и приятной.</p>
<br/><p align="left">На данный момент вы попали на Ярмарку Новолуния. Здесь вы можете продумать историю своего персонажа, выбрать наиболее желаемый внешний вид, а так же скооперироваться с другими игроками. Есть вопросы? Рекомендуем вам посетить наш канал в дискорде, ссылку вы найдёте на сайте проекта. Приятной игры!</p><br/><br/></body></html>]]


RPSCoreFramework.Literature.DarkmoonRules = [[<html><body><h3>|cFFe36c09- Куда я попал?|r</h3>
<p align="left">Darkmoon – некоммерческий ролевой проект на платформе World of Warcraft. На данный момент герои переживают 33 год с момента открытия Тёмного портала.</p><br/>

<h3>|cFFe36c09- Что значит ролевой проект?|r</h3>
<p align="left">Role-play – это, своего рода, обыгрывание ситуаций и сценариев за определенного персонажа, живущего в это мире.  Сценарии бывают разные – от повседневных (копать\строить\жить мирной жизнью), до героических, где против вас будут выступать орды демонов и прочих не самых доброжелательных тварей, жаждущих крови.</p><br/>

<h3>|cFFe36c09- Правила проекта?|r</h3>
<p align="left">Первое и самое главное правило сервера – это поддерживать атмосферу игры, стараться как можно меньше создавать конфликтных ситуаций, а если подобное все же случилось, то позвать мастера ( .gm in в чате, там будет отображен список ГМов) и разобрать вместе сложившуюся ситуацию. Если она усугубилась, то добро пожаловать в раздел жалоб и предложений.</p><br/>
<p align="left">Мы играем ради удовольствия и интереса к РП составляющей.</p><br/>
<p align="left">Второе правило – постараться понять образ своего персонажа и стараться отыгрывать его соответствующим образом. Например, добрый персонаж будет стремиться помогать другим, злой – может пройти мимо умирающего, глядя на него с презрением как на слабого. Жадный персонаж – жаден до денег, а верующий – может быть набожным и чтить каждый постулат своей Веры, выполняя все ради неё.</p><br/>
<p align="left">Третье правило – если вы чего-то не знаете из ЛОРовой (сюжетной) составляющей игры – лучше спросить. </p>
<p align="left">Подробнее о правилах проекта можно прочитать на нашем сайте:	https://rp-wow.ru/pages/rules.html </p><br/>

<h3>|cFFe36c09-Чего НЕ стоит делать на сервере?|r</h3>
<p align="left">1.	Не стоит флудить в чат бессмысленными сообщениями, не носящими смысловой нагрузки – можно получить mute от администрации.</p>
<p align="left">2.	Не стоит намеренно провоцировать игроков.</p>
<p align="left">3.	Не стоит спорить с мастером до окончания проводимого события.</p>
<p align="left">4.	Не стоит оскорблять иных игроков – мы приветствуем вежливое общение.</p>
<p align="left">5.	Не стоит излишне совершать механических действий (прыгать, атаковать без отписи иных игроков, входить в модельки персонажей).</p><br/>

<h3>|cFFe36c09- Я хочу играть нестандартную расу, что мне нужно делать?|r</h3>
<p align="left">Стоит написать анкету на выбранную расу и после одобрения отделом Рецензентов (проверяющих) вам выдадут облик и вы сможете начать играть.</p><br/><br/>
</body></html>]]

RPSCoreFramework.Literature.DarkmoonDispDesc = [[<html><body><p align="center">Отображает использованные Вами ID предметов для трансмогрификации вещей на персонаже. В дальнейшем вы можете скопировать отсюда все команды и использовать их для создания макроса или сообщить эти ID другим пользователям.</p></body></html>]]

RPSCoreFramework.Literature.DescriptionMinstrel = [[<html><body>
<p>Менестрель (сокр. МС) - статус, открывающий для владельца базовый функционал для ведения собственных сюжетов.</p>
<p>|cffffffff — Статус Менестреля можно получить, активировав Жетон Менестреля. Жетон, в свою очередь, можно получить двумя способами.|r</p>
<p>|cffffffff — Первый, это купить его у Жадного Торговца.|r</p>
<p>|cffffffff — Второй это оставить заявку на сайте в разделе получения роли Менестреля. Стоит сказать, что к кандидатам на получение статуса Менестреля через заявку предъявляются требования, такие как, наличие компании, для которой менестрель собирается организовывать сюжет.|r</p>
</body></html>]]

RPSCoreFramework.Literature.AdvancedClassMessage = "Игра за выбранный класс требует наличия опыта.";
RPSCoreFramework.Literature.AdvancedRaceMessage = "Игра за выбранную расу требует наличия опыта.";
RPSCoreFramework.Literature.AdvancedRaceOrClassMessage = "Выходя за пределы стартовой зоны вы соглашаетесь, что располагаете достаточным опытом для игры.";
RPSCoreFramework.Literature.CharsheetRequiredMessage = "|cFFFF0000Требуется наличие одобренной анкеты.|r";
RPSCoreFramework.Literature.CharsheetRecommendedMessage = "|cFF00FF00Рекомендуется наличие анкеты.|r";

RPSCoreFramework.Literature.EnchantsRule = "Не допускается злоупотребление визуальными\nчарами оружия. Все визуальные чары оружия имеют\nролевой контекст и обязаны иметь ролевое\nобоснование их наличия.";

function RPSCoreFramework:ChangeDefaultWords()
	AFK = "Вне роли";
	CHAT_AFK_GET = "%s <Вне роли>:\32";
	CLEAR_AFK = "Автоматическая отмена режима \"Вне роли\"";
	OPTION_TOOLTIP_CLEAR_AFK = "Автоматический выход из режима \"Вне роли\"\nпри движении персонажа или начале разговора.";
	CLEARED_AFK = "Вы вышли из режима \"Вне роли\".";
	MARKED_AFK = "Вы находитесь вне роли.";
	MARKED_AFK_MESSAGE = "Вы вне роли, оставив сообщение: \"%s\".";
	CHAT_FLAG_AFK = "<Вне роли>";
	CHAT_MSG_AFK = "Вне роли";
	DEFAULT_AFK_MESSAGE = "Вне роли";
	GM_EMAIL_NAME  = "Darkmoon";
	FRIENDS_LIST_AWAY = "Вне роли";

	ITEM_MOD_MANA = "%c%s к духу";
	ITEM_MOD_MANA_SHORT = "к духу";
	
	ITEM_MOD_CRIT_RATING = "Показатель критического шанса +%s.";
	ITEM_MOD_CRIT_RATING_SHORT = "к критическому шансу";

	VOICE_CHAT_ERROR_CODE_FORMATTER = "";
	ERR_VOICE_CHAT_GENERIC_UNABLE_TO_CONNECT = "Добро пожаловать на Darkmoon!";
	
	SLURRED_SPEECH = "%s";
end

function RPSCoreFramework:LiteratureTextFormatting()
	RPS_DarkmoonInfoFrameContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DarkmoonInfoFrameContent:SetFontObject("p", GameFontNormal);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DarkmoonInfoFrameContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_DarkmoonInfoFrameContent:SetText(RPSCoreFramework.Literature.DarkmoonInfo);

	RPS_DashboardBottomContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DashboardBottomContent:SetFontObject("p", GameFontNormal);
	RPS_DashboardBottomContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DashboardBottomContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DashboardBottomContent:SetFontObject("h3", GameFontNormalLarge);

	
	RPS_RulesScrollContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_RulesScrollContent:SetFontObject("p", GameFontNormal);
	RPS_RulesScrollContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_RulesScrollContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_RulesScrollContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_RulesScrollContent:SetText(RPSCoreFramework.Literature.DarkmoonRules);

	
	RPS_DarkmoonDispFrameContent:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DarkmoonDispFrameContent:SetFontObject("p", GameFontNormal);
	RPS_DarkmoonDispFrameContent:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DarkmoonDispFrameContent:SetFontObject("h2", GameFontNormalHuge);
	RPS_DarkmoonDispFrameContent:SetFontObject("h3", GameFontNormalLarge);
	RPS_DarkmoonDispFrameContent:SetText(RPSCoreFramework.Literature.DarkmoonDispDesc);

	RPS_DescriptionMinstrel:SetFont('Fonts\FRIZQT___CYR.TTF', 14);
	RPS_DescriptionMinstrel:SetFontObject("p", GameFontNormal);
	RPS_DescriptionMinstrel:SetFontObject("h1", GameFontNormalHuge3);
	RPS_DescriptionMinstrel:SetFontObject("h2", GameFontNormalHuge);
	RPS_DescriptionMinstrel:SetFontObject("h3", GameFontNormalLarge);
	RPS_DescriptionMinstrel:SetText(RPSCoreFramework.Literature.DescriptionMinstrel)
end