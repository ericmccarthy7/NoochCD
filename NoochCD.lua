StaticPopupDialogs["NOOCH_COPYPASTA"] = {
    text = "CTRL+C to copy, paste in browser",
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    hasEditBox = true,
    OnShow = function (self, data)
        self.editBox:SetText("Some text goes here")
        self.editBox:HighlightText()
        self.editBox:SetFocus()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
}

function NoochCooldowns(msg)
    -- TODO: check salt shaker in inventory.
    if(msg == "lw") then
        startTime, duration, enable = GetItemCooldown(15846)
        print("start: ", startTime)
        print("duration: ", duration)
        print("enable: ", enable)
    elseif(msg == "alch") then
        startTime, duration, enable = GetSpellCooldown(17187)
        print("usable: ", IsUsableSpell(17187))
        print("start: ", startTime)
        print("duration: ", duration)
        print("enable: ", enable)
    elseif(msg == "cloth") then
        startTime, duration, enable = GetSpellCooldown(18560)
        print("usable: ", IsUsableSpell(18560))
        print("start: ", startTime)
        print("duration: ", duration)
        print("enable: ", enable)
    else
        StaticPopup_Show("NOOCH_COPYPASTA")
    end
end



SLASH_NOOCH1 = "/nooch"
SlashCmdList["NOOCH"] = NoochCooldowns