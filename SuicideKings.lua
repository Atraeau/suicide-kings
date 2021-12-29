SK_GUILDMEMBERS_TO_DISPLAY = 13;
SK_GUILDMEMBERS_TO_HEIGHT = SK_GUILDMEMBERS_TO_DISPLAY + 1;
SK_FRAME_SIZE = 600;
local GuildList = {}


function SuicideKings_OnShow()
    SuicideKings_Update();
    C_GuildInfo.GuildRoster();
end

function SuicideKings_Update()
    SuicideKingsTitleText:SetText("Suicide Kings");
    PopulateGuildMembers();
    print("update")
end

function PopulateGuildMembers()
    local numGuildMembers;
    local totalMembers, onlineMembers, onlineAndMobileMembers = GetNumGuildMembers();

    local guildOffset = SuicideKingsPlayerListScrollFrame.offset or 0

    -- Go through the members to display, starting at the top person, to the end person
    for displayButtonIdx=1, SK_GUILDMEMBERS_TO_DISPLAY, 1 do
        -- Determine who should be at the top of the list. The offset for the scroll bar would adjust who the top person
        -- should be provided the scroll bar has been adjusted and the top person in the guild is not the top person
        -- in the display list

        local rosterIdx = guildOffset + displayButtonIdx;
        local button = getglobal("SuicideKingsPlayerListButton"..displayButtonIdx);
        button.guildIndex = rosterIdx;

        local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(rosterIdx);
        local displayedName = Ambiguate(fullName, "guild");

        getglobal("SuicideKingsPlayerListButton"..displayButtonIdx.."Name"):SetText(displayedName);
        getglobal("SuicideKingsPlayerListButton"..displayButtonIdx.."Rank"):SetText(rank);
    end
end