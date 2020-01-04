
local QuizzAnswerCounter = 1;


local function QuizShuffles(tInput)
	local tReturn = {}
	for i = #tInput, 1, -1 do
		local j = math.random(i)
		tInput[i], tInput[j] = tInput[j], tInput[i]
		table.insert(tReturn, tInput[i])
	end
	return tReturn
end

function RPSCoreFramework:SchedulePollTimer()
	PollToastStatusBar:SetValue(RPSCoreFramework.PollTimer.Counter);
	PollFrameStatusBar:SetValue(RPSCoreFramework.PollTimer.Counter);

	RPSCoreFramework.PollTimer.Counter = RPSCoreFramework.PollTimer.Counter - 1;
	if (RPSCoreFramework.PollTimer.Counter == 0) then
		RPSCoreFramework:CancelTimer(RPSCoreFramework.PollTimer.Timer);
		if PollToast:IsShown() then
			PollToast.FadeOut:Play();
		else
			PollFrame.FadeOut:Play();
		end
		RPSCoreFramework:QuizCloseReload();
	end
end

function RPSCoreFramework:QuizShowToast()
	PollToast:Show();
	RPSCoreFramework.Quiz.PollToast = true;
end

function RPSCoreFramework:QuizProcess() --> RPSCoreFramework:GlobalTimer()
	if (RPSCoreFramework:HasAura(1000041, "player") and not RPSCoreFramework.Quiz.PollToast) then
		RPSCoreFramework:QuizShowToast();
	end
end

function RPSCoreFramework:QuizStart()
	RPSCoreFramework:QuizSetTexts();
	PollFrame:Show();
end

function RPSCoreFramework:QuizAccept()
	RPSCoreFramework:SendCoreMessage("quiz start");
end

function RPSCoreFramework:QuizDecline()
	RPSCoreFramework:SendCoreMessage("quiz end");
	RPSCoreFramework:QuizCloseReload();
end

function RPSCoreFramework:QuizSetQuestion(msg)
	RPSCoreFramework.Quiz.Question = msg;
	RPSCoreFramework.PollTimer.Counter = 30;
end

function RPSCoreFramework:QuizAddAnswer(msg)
	if (QuizzAnswerCounter ~= 4) then
		table.insert(RPSCoreFramework.Quiz.Answers, {msg, QuizzAnswerCounter});
		QuizzAnswerCounter = QuizzAnswerCounter + 1;
	else
		table.insert(RPSCoreFramework.Quiz.Answers, {msg, QuizzAnswerCounter});
		QuizzAnswerCounter = 1;
		RPSCoreFramework.PollTimer.Counter = 30;

		--PollFrameStatusBar:SetMinMaxValues(1,RPSCoreFramework.PollTimer.Counter);
		RPSCoreFramework.PollTimer.Timer = RPSCoreFramework:ScheduleRepeatingTimer("SchedulePollTimer", 1);
		
		RPSCoreFramework.Quiz.Answers = QuizShuffles(RPSCoreFramework.Quiz.Answers);
		RPSCoreFramework:QuizStart();
	end
end

function RPSCoreFramework:QuizSetTexts()
	RPSPoll_NPCFrameChatNextText:SetText(RPSCoreFramework.Quiz.Question);
	PollFrameChoice1:SetText(RPSCoreFramework.Quiz.Answers[1][1]);
	PollFrameChoice2:SetText(RPSCoreFramework.Quiz.Answers[2][1]);
	PollFrameChoice3:SetText(RPSCoreFramework.Quiz.Answers[3][1]);
	PollFrameChoice4:SetText(RPSCoreFramework.Quiz.Answers[4][1]);
end

function RPSCoreFramework:QuizProcessAnswer(num)
	RPSCoreFramework:SendCoreMessage("quiz select "..num);
	PollFrame.FadeOut:Play();
	RPSCoreFramework:QuizCloseReload();
end

function RPSCoreFramework:QuizCloseReload()
	print("QuizCloseReload");
	--PollFrame:Hide();
	--PollToast:Hide();
	RPSCoreFramework.Quiz.PollToast = false;
	PollFrameStatusBar:SetValue(30);
	PollToastStatusBar:SetValue(120);
	RPSCoreFramework.Quiz.Answers = {};
	RPSCoreFramework:CancelTimer(RPSCoreFramework.PollTimer.Timer);
end