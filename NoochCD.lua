saltShakerText = "WoW+Cooldown%3A+Salt+Shaker"
moonclothText = "WoW+Cooldown%3A+Mooncloth"
transmuteText = "WoW+Cooldown%3A+Transmute+Arcanite"

currentTitle = saltShakerText
currentDate = "20220101T0000%2F20220101T0005"


StaticPopupDialogs["NOOCH_COPYPASTA"] = {
    text = "CTRL+C to copy, paste in browser",
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    hasEditBox = true,
    OnShow = function (self, data)
        self.editBox:SetText("https://www.google.com/calendar/render?action=TEMPLATE&text=" .. currentTitle .. "&dates=" .. currentDate)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
}

StaticPopupDialogs["NOOCH_ERRORDIALOG"] = {
    text = "Unknown error",
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnShow = function (self, data)
        self.text:SetText("No cooldown / spell doesn't exist.")
        self.button1:SetFocus()
    end,
}

function NoochCooldowns(msg)
    -- TODO: check salt shaker in inventory.
    if(msg == "lw") then
        startTime, duration, enable = GetItemCooldown(15846)
        if(startTime == 0) then
            StaticPopup_Show("NOOCH_ERRORDIALOG")
        else
            local remaining = GetCooldownLeft(startTime, duration)
            local from = date("%Y%m%dT%H%M%S", time() + remaining)
            local to = date("%Y%m%dT%H%M%S", time() + remaining + 300)
            currentDate = from .. "%2F" .. to
            currentTitle = saltShakerText
            StaticPopup_Show("NOOCH_COPYPASTA")
        end
    elseif(msg == "alch") then
        startTime, duration, enable = GetSpellCooldown(17187)
        if(startTime == 0) then
            StaticPopup_Show("NOOCH_ERRORDIALOG")
        else
            local remaining = GetCooldownLeft(startTime, duration)
            local from = date("%Y%m%dT%H%M%S", time() + remaining)
            local to = date("%Y%m%dT%H%M%S", time() + remaining + 300)
            currentDate = from .. "%2F" .. to
            currentTitle = transmuteText
            StaticPopup_Show("NOOCH_COPYPASTA")
        end
    elseif(msg == "cloth") then
        startTime, duration, enable = GetSpellCooldown(18560)
        if(startTime == 0) then
            StaticPopup_Show("NOOCH_ERRORDIALOG")
        else
            local remaining = GetCooldownLeft(startTime, duration)
            local from = date("%Y%m%dT%H%M%S", time() + remaining)
            local to = date("%Y%m%dT%H%M%S", time() + remaining + 300)
            currentDate = from .. "%2F" .. to
            currentTitle = moonclothText
            StaticPopup_Show("NOOCH_COPYPASTA")

        end
    else
        StaticPopup_Show("NOOCH_ERRORDIALOG")
    end
end

function GetCooldownLeft(start, duration)
    -- https://github.com/Stanzilla/WoWUIBugs/issues/47
    if start < GetTime() then
        local cdEndTime = start + duration
        local cdLeftDuration = cdEndTime - GetTime()
        
        return cdLeftDuration
    end

    local time = time()
    local startupTime = time - GetTime()
    -- just a simplification of: ((2^32) - (start * 1000)) / 1000
    local cdTime = (2 ^ 32) / 1000 - start
    local cdStartTime = startupTime - cdTime
    local cdEndTime = cdStartTime + duration
    local cdLeftDuration = cdEndTime - time
    
    return cdLeftDuration
end

SLASH_NOOCH1 = "/nooch"
SLASH_NOOCH2 = "/n"
SlashCmdList["NOOCH"] = NoochCooldowns