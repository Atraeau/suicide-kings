SK_GUILDMEMBERS_TO_DISPLAY = 21;
SK_GUILDMEMBERS_TO_HEIGHT = SK_GUILDMEMBERS_TO_DISPLAY + 1;

SK_EVENT_NAME_ADDON_LOADED = "ADDON_LOADED"
SK_EVENT_NAME_PLAYER_LOGOUT = "PLAYER_LOGOUT"

function SuicideKings_OnEvent(self, event, payload)
    if (event == SK_EVENT_NAME_ADDON_LOADED and payload == "SuicideKings") then
        if (SuicideKingsList == nil) then
            print("SK List not created yet")
        else
            ReadSuicideList(SuicideKingsList)
            DisplayCurrentListMembers()
        end
    end
end

function SuicideKings_OnLoad(self)
    self:RegisterEvent(SK_EVENT_NAME_ADDON_LOADED); -- Fired when saved variables are loaded
    self:RegisterEvent(SK_EVENT_NAME_PLAYER_LOGOUT); -- Fired when about to log out
    RegisterSlashCommand()
    --PanelTemplates_SetNumTabs(self, 2);
    --PanelTemplates_SetTab(self, 1)
end

function RegisterSlashCommand()
    SlashCmdList["SUICIDEKINGS"] = HandleSlashCommand
    SLASH_SUICIDEKINGS1 = "/sk"
end

function HandleSlashCommand(arg)
    SuicideKingsFrame:Show()
end

function SuicideKings_OnShow()
    GuildMembers_Update();
    C_GuildInfo.GuildRoster();
end

function GuildMembers_Update()
    SuicideKingsFrameInset:SetPoint("TOPLEFT", 4, -80);
    PopulateGuildMembers();
end

function SuicideKingsListMembers_Update()
    DisplayCurrentListMembers()
end

function PopulateGuildMembers()

    local totalMembers, onlineMembers, onlineAndMobileMembers = GetNumGuildMembers();
    local guildOffset = SuicideKingsGuildListScrollFrame.offset or 0

    -- Go through the members to display, starting at the top person, to the end person
    for displayButtonIdx=1, SK_GUILDMEMBERS_TO_DISPLAY, 1 do
        -- Determine who should be at the top of the list. The offset for the scroll bar would adjust who the top person
        -- should be provided the scroll bar has been adjusted and the top person in the guild is not the top person
        -- in the display list

        local rosterIdx = guildOffset + displayButtonIdx;
        local button = getglobal("SKButtonGuildPlayerListItem"..displayButtonIdx);
        button.guildIndex = rosterIdx;

        local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(rosterIdx);
        if not IsEmpty(fullName) then
            local displayedName = Ambiguate(fullName, "guild");
            getglobal("SKButtonGuildPlayerListItem"..displayButtonIdx.."Name"):SetText(displayedName);
            getglobal("SKButtonGuildPlayerListItem"..displayButtonIdx.."Rank"):SetText(rank);
        end
    end

    FauxScrollFrame_Update(SuicideKingsGuildListScrollFrame, totalMembers, SK_GUILDMEMBERS_TO_DISPLAY, SK_GUILDMEMBERS_TO_HEIGHT );
end

function DisplayCurrentListMembers()
    if (SuicideKingsList ~= nil) then
        local totalListMembers = SuicideKings_GetCurrentListMemberCount()
        local memberOffset = SuicideKingsListScrollFrame.offset or 0

        for displayButtonIdx=1, SK_GUILDMEMBERS_TO_DISPLAY, 1 do
            local lookupOffset = memberOffset + displayButtonIdx
            local name, rank = unpack(SuicideKingsList[lookupOffset])

            local displayedName = Ambiguate(name, "guild");
            getglobal("SKButtonSuicideKingsListItem"..displayButtonIdx.."Name"):SetText(displayedName);
            getglobal("SKButtonSuicideKingsListItem"..displayButtonIdx.."Rank"):SetText(rank);
        end

        FauxScrollFrame_Update(SuicideKingsListScrollFrame, totalListMembers, SK_GUILDMEMBERS_TO_DISPLAY, SK_GUILDMEMBERS_TO_HEIGHT );
    end
end

-- Statefull function to assign the new list to the shared variable "SuicideKingsList"
function SuicideKings_CreateList()
    print("Create")
    SuicideKingsList = CreateSuicideList()
end

function SuicideKings_DeleteList()
    SuicideKingsList = nil
end

function SuicideKings_GetCurrentListMemberCount()
    return GetTableLength(SuicideKingsList)
end

function GetTableLength(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Static function to create list and return (stateless)
function CreateSuicideList()
    local totalMembers, onlineMembers, onlineAndMobileMembers = GetNumGuildMembers();
    local suicideList = { }

    for idx=1, SK_GUILDMEMBERS_TO_DISPLAY + 1, 1 do
        local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(idx);
        --if online then
            table.insert(suicideList, idx, {fullName, rank})
        --end
    end

    return suicideList
end

function IsEmpty(s)
    return s == nil or s == ''
end

function ReadSuicideList(list)
    for i,v in ipairs(list) do 
        local name, rank = unpack(v)
        print("Name: "..name.. "rank".. rank .. " Position: "..i) end
end

function UpdateSuicideList(list)
end

function RandomizeSuicideList(suicideList)
end

function SuicideKingsGuildListColumn_SetWidth(frame, width)
	frame:SetWidth(width);
	local name = frame:GetName().."Middle";
	local middleFrame = _G[name];
	if middleFrame then
		middleFrame:SetWidth(width - 9);
	end
end