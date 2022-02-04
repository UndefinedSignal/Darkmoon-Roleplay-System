local function QuizShuffles(tInput)
	local tReturn = {}
	for i = #tInput, 1, -1 do
		local j = math.random(i)
		tInput[i], tInput[j] = tInput[j], tInput[i]
		table.insert(tReturn, tInput[i])
	end
	return tReturn
end

function RPSCoreFramework:ScheduleQuizTimer()
	QuizToastStatusBar:SetValue(RPSCoreFramework.QuizTimer.Counter);
	QuizFrameStatusBar:SetValue(RPSCoreFramework.QuizTimer.Counter);

	RPSCoreFramework.QuizTimer.Counter = RPSCoreFramework.QuizTimer.Counter - 1;
	if (RPSCoreFramework.QuizTimer.Counter == 0) then
		RPSCoreFramework:CancelTimer(RPSCoreFramework.QuizTimer.Timer);
		if (QuizToast:IsShown()) then
			QuizToast.FadeOut:Play();
		else
			QuizFrame.FadeOut:Play();
		end
		RPSCoreFramework:QuizCloseReload();
	end
end

function RPSCoreFramework:QuizShowToast()
	QuizToast:Show();
	RPSCoreFramework.Quiz.Toast = true;
end

function RPSCoreFramework:QuizProcess() --> RPSCoreFramework:GlobalTimer()
	if (RPSCoreFramework:HasAura(RPSCoreFramework.QuizAura) and not RPSCoreFramework.Quiz.Toast) then
		RPSCoreFramework:QuizShowToast();
	end
end

function RPSCoreFramework:QuizStart()
	QuizFrameQuestion:SetText(RPSCoreFramework.Quiz.Question);
	QuizFrameOption1:SetText(RPSCoreFramework.Quiz.Answers[1][1]);
	QuizFrameOption2:SetText(RPSCoreFramework.Quiz.Answers[2][1]);
	QuizFrameOption3:SetText(RPSCoreFramework.Quiz.Answers[3][1]);
	QuizFrameOption4:SetText(RPSCoreFramework.Quiz.Answers[4][1]);
	
	QuizFrame:Show();
end

function RPSCoreFramework:QuizAccept()
	RPSCoreFramework:SendCoreMessage("quiz start");
end

function RPSCoreFramework:QuizDecline()
	RPSCoreFramework:CancelTimer(RPSCoreFramework.QuizTimer.Timer);
	RPSCoreFramework:SendCoreMessage("quiz end");
	RPSCoreFramework:QuizCloseReload();
end

function RPSCoreFramework:QuizSetQuestion(msg)
	RPSCoreFramework.Quiz.Question = msg;
	RPSCoreFramework.QuizTimer.Counter = 30;
end

function RPSCoreFramework:QuizAddAnswer(msg)
	if (#RPSCoreFramework.Quiz.Answers ~= 3) then
		table.insert(RPSCoreFramework.Quiz.Answers, {msg, #RPSCoreFramework.Quiz.Answers+1});
	else
		table.insert(RPSCoreFramework.Quiz.Answers, {msg, #RPSCoreFramework.Quiz.Answers+1});
		RPSCoreFramework.QuizTimer.Counter = 30;

		--QuizFrameStatusBar:SetMinMaxValues(1,RPSCoreFramework.QuizTimer.Counter);
		RPSCoreFramework.QuizTimer.Timer = RPSCoreFramework:ScheduleRepeatingTimer("ScheduleQuizTimer", 1);
		
		RPSCoreFramework.Quiz.Answers = QuizShuffles(RPSCoreFramework.Quiz.Answers);
		RPSCoreFramework:QuizStart();
	end
end

function RPSCoreFramework:QuizProcessAnswer(num)
	QuizFrame.FadeOut:Play();
	RPSCoreFramework:SendCoreMessage("quiz select "..RPSCoreFramework.Quiz.Answers[num][2]);
	RPSCoreFramework:QuizCloseReload();
end

function RPSCoreFramework:QuizCloseReload()
	RPSCoreFramework.Quiz.Toast = false;
	QuizFrameStatusBar:SetValue(30);
	QuizToastStatusBar:SetValue(120);
	RPSCoreFramework.Quiz.Answers = {};
	RPSCoreFramework:CancelTimer(RPSCoreFramework.QuizTimer.Timer);
end
