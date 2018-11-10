function RPSCoreFramework:GenerateScrollMenu()
  FauxScrollFrame_Update(DarkmoonAurasScrollFrame,#RPSCoreFramework.Interface.Auras,6,32);

  for jBtn=1, 6 do
    lineplusoffset = jBtn + FauxScrollFrame_GetOffset(DarkmoonAurasScrollFrame);
    RPSCoreFramework.Scroller.lineplusoffset[jBtn] = tonumber(lineplusoffset)
    --print("RPSCoreFramework.Scroller.lineplusoffset["..jBtn.."]:"..RPSCoreFramework.Scroller.lineplusoffset[jBtn])
  end

  RPSCoreFramework:ScrollMenuUpdater()

end
