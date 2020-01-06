function initframe(self)
	self:RegisterEvent("ADDON_LOADED")
	self.TitleTopBox:SetText(RPSCoreFramework.content.TitleTopBoxText)
	self.SmallBoxWithContentOneBorder.tex_image_one:SetTexture(RPSCoreFramework.content.image_one)
	self.SmallBoxWithContentTwoBorder.tex_image_two:SetTexture(RPSCoreFramework.content.image_two)
	self.SmallBoxWithContentThreeBorder.tex_image_three:SetTexture(RPSCoreFramework.content.image_three)
	textedit()
end

function new_character(frame, event, ...)
	if event == "ADDON_LOADED" then
		if (not RPSMOTDDate) or (RPSMOTDDate == nil) or not (RPSMOTDDate == RPSCoreFramework.content.verison_date) then
			RPSMOTDDate = RPSCoreFramework.content.verison_date
			mainframe:Show()
		end
	end
end

function textedit()
	Text_Content_One:SetFont('Fonts\FRIZQT___CYR.TTF', 14)
	Text_Content_One:SetFontObject("p", GameFontNormal)
	Text_Content_One:SetFontObject("h1", GameFontNormalHuge3)
	Text_Content_One:SetFontObject("h2", GameFontNormalHuge)
	Text_Content_One:SetFontObject("h3", GameFontNormalLarge)
	Text_Content_One:SetText(RPSCoreFramework.content.text_one)

	Text_Content_Two:SetFont('Fonts\FRIZQT___CYR.TTF', 14)
	Text_Content_Two:SetFontObject("p", GameFontNormal)
	Text_Content_Two:SetFontObject("h1", GameFontNormalHuge3)
	Text_Content_Two:SetFontObject("h2", GameFontNormalHuge)
	Text_Content_Two:SetFontObject("h3", GameFontNormalLarge)
	Text_Content_Two:SetText(RPSCoreFramework.content.text_two)

	Text_Content_Three:SetFont('Fonts\FRIZQT___CYR.TTF', 14)
	Text_Content_Three:SetFontObject("p", GameFontNormal)
	Text_Content_Three:SetFontObject("h1", GameFontNormalHuge3)
	Text_Content_Three:SetFontObject("h2", GameFontNormalHuge)
	Text_Content_Three:SetFontObject("h3", GameFontNormalLarge)
	Text_Content_Three:SetText(RPSCoreFramework.content.text_three)
end

--1) Левый верхний блок. Изображение, заголовок, описание
--2) Левый нижний блок. Изображение, заголовок, описание
--3) Правый блок. Изображение, заголовок, описание
--Фрейм - заголовок, описание