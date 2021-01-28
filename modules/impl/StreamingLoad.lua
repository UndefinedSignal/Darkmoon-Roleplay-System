local STREAMING_CURRENT_STATUS = 0;

function RPSCoreFramework:POIStreamingLoad()
	RPSCoreFramework.Map.POICountLow = ceil(tonumber(RPSCoreFramework.Map.POICount*4)/7);
	RPSCoreFramework.Map.POICountMid = ceil(tonumber(RPSCoreFramework.Map.POICount*2)/7) + RPSCoreFramework.Map.POICountLow;
end

function RPSCoreFramework:POIStreamingProcess()
	if (RPSCoreFramework.Map.POICounter < RPSCoreFramework.Map.POICountLow) then
		RPSCoreFramework:StreamingLoad_UpdateIcon(3);
	elseif (RPSCoreFramework.Map.POICounter < RPSCoreFramework.Map.POICountMid) then
		RPSCoreFramework:StreamingLoad_UpdateIcon(2);
	else
		if (RPSCoreFramework.Map.POICounter == RPSCoreFramework.Map.POICount-1) then
			RPSCoreFramework:StreamingLoad_UpdateIcon(0);
		else
			RPSCoreFramework:StreamingLoad_UpdateIcon(1);
		end
	end
end

function RPSCoreFramework:StreamingLoad_UpdateIcon(status)
	if(status > 0) then
		if (status == 1) then
			RPSStreamingLoadSpinSpinner:SetVertexColor(0,1,0);
			RPSStreamingLoadFrameBackground:SetVertexColor(0,1,0);
			--RPSStreamingLoad.tooltip = "Идёт загрузка POI";
		elseif (status == 2) then
			RPSStreamingLoadSpinSpinner:SetVertexColor(1,.82,0);
			RPSStreamingLoadFrameBackground:SetVertexColor(1,0.82,0);
			--RPSStreamingLoad.tooltip = "Идёт загрузка POI";
		elseif (status == 3) then
			RPSStreamingLoadSpinSpinner:SetVertexColor(1,0,0);
			RPSStreamingLoadFrameBackground:SetVertexColor(1,0,0);
			--RPSStreamingLoad.tooltip = "Идёт загрузка POI";
		end
		if (RPSStreamingLoad.FadeOUT:IsPlaying()) then
			local alpha = RPSStreamingLoad:GetAlpha();
			RPSStreamingLoad.FadeOUT:Stop();
			RPSStreamingLoad:SetAlpha(alpha);
		end
		if (not RPSStreamingLoad:IsShown()) then
			RPSStreamingLoad.FadeIN:Play();
		end
		RPSStreamingLoad.Loop:Play();
		RPSStreamingLoad:Show();
		RPSStreamingLoad.tooltip = "Загрузка точек интереса(POI): ".. ceil(RPSCoreFramework.Map.POICounter*100/tonumber(RPSCoreFramework.Map.POICount)) .. "%";
		RPSCoreFramework:StreamingLoadRecheck();
	elseif(STREAMING_CURRENT_STATUS > 0) then
		RPSStreamingLoadSpinSpinner:SetVertexColor(0,1,0);
		RPSStreamingLoadFrameBackground:SetVertexColor(0,1,0);
		if (RPSStreamingLoad.FadeIN:IsPlaying()) then
			local alpha = RPSStreamingLoad:GetAlpha();
			RPSStreamingLoad.FadeIN:Stop();
			RPSStreamingLoad:SetAlpha(alpha);
		end
		RPSStreamingLoad.tooltip = "Загрузка точек интереса(POI) завершена, приятной игры!";
		RPSStreamingLoad.FadeOUT:Play();
	end

	STREAMING_CURRENT_STATUS = status;
end

function RPSCoreFramework:StreamingLoadRecheck()
	if tonumber(ceil(RPSCoreFramework.Map.POICounter*100/tonumber(RPSCoreFramework.Map.POICount))) >= 99 then
		RPSCoreFramework:CharacterInfoPOIBlock(2);
		RPSCoreFramework:StreamingLoad_UpdateIcon(0);
	end
end

function RPSCoreFramework:StreamingLoad_FadeIN_OnFinished()
	RPSStreamingLoad:SetAlpha(1);
end

function RPSCoreFramework:StreamingLoad_FadeOUT_OnFinished()
	RPSStreamingLoad:SetAlpha(0)
	RPSStreamingLoad:Hide();
end