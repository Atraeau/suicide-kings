GUILDMEMBERS_TO_DISPLAY = 13;

function SuicideKings_OnShow()
    SuicideKings_Update();
    C_GuildInfo.GuildRoster();
end

function SuicideKings_Update()
    SuicideKingsFrameInset:SetPoint("TOPLEFT", 4, -80);
    SuicideKingsTitleText:SetText("Suicide Kings");
    print("update")
end
