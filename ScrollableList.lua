MyModData = {}

function MyMod_OnLoad()
  for i=1,50 do
    MyModData[i] = "Test "..math.random(100)
  end
  MyModScrollBar:Show()
end

function MyModScrollBar_Update()
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  FauxScrollFrame_Update(MyModScrollBar,50,5,16);
  for line=1,5 do
    lineplusoffset = line + FauxScrollFrame_GetOffset(MyModScrollBar);
    if lineplusoffset <= 50 then
      getglobal("MyModEntry"..line):SetText(MyModData[lineplusoffset]);
      getglobal("MyModEntry"..line):Show();
    else
      getglobal("MyModEntry"..line):Hide();
    end
  end
end