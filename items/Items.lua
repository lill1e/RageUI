---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---


local ItemsSettings = {
    CheckBox = {
        Textures = {
            "shop_box_blankb", -- 1
            "shop_box_tickb", -- 2
            "shop_box_blank", -- 3
            "shop_box_tick", -- 4
            "shop_box_crossb", -- 5
            "shop_box_cross", -- 6
        },
        X = 380, Y = -6, Width = 50, Height = 50
    },
    Rectangle = {
        Y = 0, Width = 431, Height = 38
    }
}

local function StyleCheckBox(Selected, Checked, Box, BoxSelect, OffSet)
    local CurrentMenu = RageUI.CurrentMenu;
    if OffSet == nil then
        OffSet = 0
    end
    if Selected then
        if Checked then
            Graphics.Sprite("commonmenu", ItemsSettings.CheckBox.Textures[Box], CurrentMenu.X + 380 + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + -6 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 50, 50)
        else
            Graphics.Sprite("commonmenu", ItemsSettings.CheckBox.Textures[1], CurrentMenu.X + 380 + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + -6 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 50, 50)
        end
    else
        if Checked then
            Graphics.Sprite("commonmenu", ItemsSettings.CheckBox.Textures[BoxSelect], CurrentMenu.X + 380 + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + -6 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 50, 50)
        else
            Graphics.Sprite("commonmenu", ItemsSettings.CheckBox.Textures[3], CurrentMenu.X + 380 + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + -6 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 50, 50)
        end
    end

end

local function StyleStopLight(Selected, Checked, Box, BoxSelect, OffSet)
    local CurrentMenu = RageUI.CurrentMenu;
    if OffSet == nil then
        OffSet = 0
    end
    if Checked then
        Graphics.Sprite("timerbars", "circle_checkpoints", CurrentMenu.X + 395 + CurrentMenu.WidthOffset, CurrentMenu.Y + 10 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 17, 17, 0, 102, 255, 102, 185)
    else
        Graphics.Sprite("timerbars", "circle_checkpoints", CurrentMenu.X + 395 + CurrentMenu.WidthOffset, CurrentMenu.Y + 10 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 17, 17, 0, 255, 51, 51, 185)
    end

end

---@class Items
Items = {}

---AddButton
---
--- Add items button.
---
---@param Label string
---@param Description string
---@param Style table
---@param Actions fun(onSelected:boolean, onActive:boolean)
---@param Submenu any
---@public
---@return void
function Items:AddButton(Label, Description, Style, Actions, Submenu)
    local CurrentMenu = RageUI.CurrentMenu
    local Option = RageUI.Options + 1
    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        local Active = CurrentMenu.Index == Option
        RageUI.ItemsSafeZone(CurrentMenu)
        local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= RageUI.BadgeStyle.None
        local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= RageUI.BadgeStyle.None)
        local LeftBadgeOffset = haveLeftBadge and 27 or 0
        local RightBadgeOffset = haveRightBadge and 32 or 0
        if Style.Color and Style.Color.BackgroundColor then
            Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38, Style.Color.BackgroundColor[1], Style.Color.BackgroundColor[2], Style.Color.BackgroundColor[3], Style.Color.BackgroundColor[4])
        end
        if Active then
            if Style.Color and Style.Color.HightLightColor then
                Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38, Style.Color.HightLightColor[1], Style.Color.HightLightColor[2], Style.Color.HightLightColor[3], Style.Color.HightLightColor[4])
            else
                Graphics.Sprite("commonmenu", "gradient_nav", CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38)
            end
        end
        if not (Style.IsDisabled) then
            if haveLeftBadge then
                if (Style.LeftBadge ~= nil) then
                    local LeftBadge = Style.LeftBadge(Active)
                    Graphics.Sprite(LeftBadge.BadgeDictionary or "commonmenu", LeftBadge.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255)
                end
            end
            if haveRightBadge then
                if (Style.RightBadge ~= nil) then
                    local RightBadge = Style.RightBadge(Active)
                    Graphics.Sprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + 385 + CurrentMenu.WidthOffset, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end
            end
            if Style.RightLabel then
                Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255, 2)
            end
            Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255)
        else
            local RightBadge = RageUI.BadgeStyle.Lock(Active)
            Graphics.Sprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + 385 + CurrentMenu.WidthOffset, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
            Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 163, 159, 148, 255)
        end
        RageUI.ItemOffset = RageUI.ItemOffset + 38
        if (Active) then
            RageUI.ItemsDescription(Description);
            if not (Style.IsDisabled) then
                local Selected = (CurrentMenu.Controls.Select.Active)
                Actions(Selected, Active)
                if Selected then
                    Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
                    if Submenu and Submenu() then
                        RageUI.NextMenu = Submenu
                    end
                end
            end
        end
    end
    RageUI.Options = RageUI.Options + 1
end

---CheckBox
---@param Label string
---@param Description string
---@param Checked boolean
---@param Style table
---@param Actions fun(onSelected:boolean, IsChecked:boolean)
function Items:CheckBox(Label, Description, Checked, Style, Actions)
    local CurrentMenu = RageUI.CurrentMenu;

    local Option = RageUI.Options + 1
    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

        local Active = CurrentMenu.Index == Option;
        local Selected = false;
        local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
        local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
        local BoxOffset = 0
        RageUI.ItemsSafeZone(CurrentMenu)

        if (Active) then
            Graphics.Sprite("commonmenu", "gradient_nav", CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38)
        end

        if (Style.IsDisabled == nil) or not (Style.IsDisabled) then
            if Active then
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 0, 0, 0, 255)
            else
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 245, 245, 245, 255)
            end
            if Style.LeftBadge ~= nil then
                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                    local BadgeData = Style.LeftBadge(Active)
                    Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                end
            end
            if Style.RightBadge ~= nil then
                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                    local BadgeData = Style.RightBadge(Active)
                    Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + 385 + CurrentMenu.WidthOffset, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                end
            end
        else
            local LeftBadge = RageUI.BadgeStyle.Lock
            LeftBadgeOffset = ((LeftBadge == RageUI.BadgeStyle.None or LeftBadge == nil) and 0 or 27)

            if Active then
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 0, 0, 0, 255)
            else
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 163, 159, 148, 255)
            end

            if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                local BadgeData = LeftBadge(Active)
                Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
            end
        end

        if (Active) then
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 0, 0, 0, 255, 2)
                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
            end
        else
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 2)
                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
            end
        end

        BoxOffset = RightBadgeOffset + BoxOffset
        if Style.Style ~= nil then
            if Style.Style == 1 then
                StyleCheckBox(Active, Checked, 2, 4, BoxOffset)
            elseif Style.Style == 2 then
                StyleCheckBox(Active, Checked, 5, 6, BoxOffset)
            else
                StyleCheckBox(Active, Checked, 2, 4, BoxOffset)
            end
        else
            StyleCheckBox(Active, Checked, 2, 4, BoxOffset)
        end

        if (Active) and (CurrentMenu.Controls.Select.Active) then
            Selected = true;
            Checked = not Checked
            Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
        end

        if (Active) then
            Actions(Selected, Checked)
            RageUI.ItemsDescription(Description)
        end

        RageUI.ItemOffset = RageUI.ItemOffset + 38
    end
    RageUI.Options = RageUI.Options + 1
end

---CheckBox
---@param Label string
---@param Description string
---@param Checked boolean
---@param Style table
---@param Actions fun(onSelected:boolean, IsChecked:boolean)
function Items:StopLight(Label, Description, Checked, Style, Actions)
    local CurrentMenu = RageUI.CurrentMenu;

    local Option = RageUI.Options + 1
    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

        local Active = CurrentMenu.Index == Option;
        local Selected = false;
        local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
        local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
        local BoxOffset = 0
        RageUI.ItemsSafeZone(CurrentMenu)

        if (Active) then
            Graphics.Sprite("commonmenu", "gradient_nav", CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38)
        end

        if (Style.IsDisabled == nil) or not (Style.IsDisabled) then
            if Active then
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 0, 0, 0, 255)
            else
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 245, 245, 245, 255)
            end
            if Style.LeftBadge ~= nil then
                if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                    local BadgeData = Style.LeftBadge(Active)
                    Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                end
            end
            if Style.RightBadge ~= nil then
                if Style.RightBadge ~= RageUI.BadgeStyle.None then
                    local BadgeData = Style.RightBadge(Active)
                    Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + 385 + CurrentMenu.WidthOffset, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                end
            end
        else
            local LeftBadge = RageUI.BadgeStyle.Lock
            LeftBadgeOffset = ((LeftBadge == RageUI.BadgeStyle.None or LeftBadge == nil) and 0 or 27)

            if Active then
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 0, 0, 0, 255)
            else
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 163, 159, 148, 255)
            end

            if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                local BadgeData = LeftBadge(Active)
                Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
            end
        end

        if (Active) then
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 0, 0, 0, 255, 2)
                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
            end
        else
            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 2)
                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
            end
        end

        BoxOffset = RightBadgeOffset + BoxOffset
        if Style.Style ~= nil then
            if Style.Style == 1 then
                StyleStopLight(Active, Checked, 2, 4, BoxOffset)
            elseif Style.Style == 2 then
                StyleStopLight(Active, Checked, 5, 6, BoxOffset)
            else
                StyleStopLight(Active, Checked, 2, 4, BoxOffset)
            end
        else
            StyleStopLight(Active, Checked, 2, 4, BoxOffset)
        end

        if (Active) and (CurrentMenu.Controls.Select.Active) then
            Selected = true;
            Checked = not Checked
            Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
        end

        if (Active) then
            Actions(Selected, Checked)
            RageUI.ItemsDescription(Description)
        end

        RageUI.ItemOffset = RageUI.ItemOffset + 38
    end
    RageUI.Options = RageUI.Options + 1
end

---AddSeparator
---
--- Add separator
---
---@param Label string
---@public
---@return void
function Items:AddSeparator(Label)
    local CurrentMenu = RageUI.CurrentMenu
    local Option = RageUI.Options + 1
    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        local Active = CurrentMenu.Index == Option;
        if (Label ~= nil) then
            Graphics.Text(Label, CurrentMenu.X + 0 + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200), CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 245, 245, 245, 255, 1)
        end
        RageUI.ItemOffset = RageUI.ItemOffset + 38
        if (Active) then
            if (RageUI.LastControl) then
                CurrentMenu.Index = Option - 1
                if (CurrentMenu.Index < 1) then
                    CurrentMenu.Index = RageUI.CurrentMenu.Options
                end
            else
                CurrentMenu.Index = Option + 1
            end
            RageUI.ItemsDescription(nil)
        end
    end
    RageUI.Options = RageUI.Options + 1
end

---AddList
---@param Label string
---@param Items table<any, any>
---@param Index number
---@param Style table<any, any>
---@param Description string
---@param Actions fun(Index:number, onSelected:boolean, onListChange:boolean))
---@param Submenu any
function Items:AddList(Label, Items, Index, Description, Style, Actions, Submenu)
    local CurrentMenu = RageUI.CurrentMenu;

    local Option = RageUI.Options + 1
    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        local Active = CurrentMenu.Index == Option;
        local onListChange = false;
        RageUI.ItemsSafeZone(CurrentMenu)
        local LeftBadgeOffset = ((Style.LeftBadge == RageUI.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
        local RightBadgeOffset = ((Style.RightBadge == RageUI.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
        local RightOffset = 0
        local ListText = (type(Items[Index]) == "table") and string.format("← %s →", Items[Index].Name) or string.format("← %s →", Items[Index]) or "NIL"

        if (Active) then
            Graphics.Sprite("commonmenu", "gradient_nav", CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38)
        end

        if (not Style.IsDisabled) then
            if Active then
                if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                    Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 0, 0, 0, 255, 2)
                    RightOffset = Graphics.MeasureStringWidth(Style.RightLabel, 0, 0.35)
                end
            else
                if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                    RightOffset = Graphics.MeasureStringWidth(Style.RightLabel, 0, 0.35)
                    Graphics.Text(Style.RightLabel, CurrentMenu.X + 420 - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 2)
                end
            end
        end
        RightOffset = RightBadgeOffset * 1.3 + RightOffset
        if (not Style.IsDisabled) then
            if (Active) then
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 0, 0, 0, 255)
                Graphics.Text(ListText, CurrentMenu.X + 403 + 15 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 0, 0, 0, 255, 2)
            else
                Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 245, 245, 245, 255)
                Graphics.Text(ListText, CurrentMenu.X + 403 + 15 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 2)
            end
        else
            Graphics.Text(Label, CurrentMenu.X + 8 + LeftBadgeOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, 163, 159, 148, 255)
            Graphics.Text(ListText, CurrentMenu.X + 403 + 15 + CurrentMenu.WidthOffset, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 163, 159, 148, 255, 2)
        end

        if type(Style) == "table" then
            if Style.Enabled == true or Style.Enabled == nil then
                if type(Style) == 'table' then
                    if Style.LeftBadge ~= nil then
                        if Style.LeftBadge ~= RageUI.BadgeStyle.None then
                            local BadgeData = Style.LeftBadge(Active)
                            Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                        end
                    end

                    if Style.RightBadge ~= nil then
                        if Style.RightBadge ~= RageUI.BadgeStyle.None then
                            local BadgeData = Style.RightBadge(Active)
                            Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + 385 + CurrentMenu.WidthOffset, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                        end
                    end
                end
            else
                local LeftBadge = RageUI.BadgeStyle.Lock
                if LeftBadge ~= RageUI.BadgeStyle.None and LeftBadge ~= nil then
                    local BadgeData = LeftBadge(Active)
                    Graphics.Sprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + -2 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                end
            end
        else
            error("UICheckBox Style is not a `table`")
        end

        RageUI.ItemOffset = RageUI.ItemOffset + 38

        if (Active) then
            RageUI.ItemsDescription(Description);
            if (not Style.IsDisabled) then
                if (CurrentMenu.Controls.Left.Active) and not (CurrentMenu.Controls.Right.Active) then
                    Index = Index - 1
                    if Index < 1 then
                        Index = #Items
                    end
                    onListChange = true
                    Audio.PlaySound(RageUI.Settings.Audio.LeftRight.audioName, RageUI.Settings.Audio.LeftRight.audioRef)
                elseif (CurrentMenu.Controls.Right.Active) and not (CurrentMenu.Controls.Left.Active) then
                    Index = Index + 1
                    if Index > #Items then
                        Index = 1
                    end
                    onListChange = true
                    Audio.PlaySound(RageUI.Settings.Audio.LeftRight.audioName, RageUI.Settings.Audio.LeftRight.audioRef)
                end
                local Selected = (CurrentMenu.Controls.Select.Active)
                Actions(Index, Selected, onListChange, Active)
                if (Selected) then
                    Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
                    if Submenu ~= nil and type(Submenu) == "table" then
                        RageUI.NextMenu = Submenu[Index]
                    end
                end
            end
        end
    end
    RageUI.Options = RageUI.Options + 1
end

---Heritage
---@param Mum number
---@param Dad number
function Items:Heritage(Mum, Dad)
    local CurrentMenu = RageUI.CurrentMenu;
    if Mum < 0 or Mum > 21 then
        Mum = 0
    end
    if Dad < 0 or Dad > 23 then
        Dad = 0
    end
    if Mum == 21 then
        Mum = "special_female_" .. (tonumber(string.sub(Mum, 2, 2)) - 1)
    else
        Mum = "female_" .. Mum
    end
    if Dad >= 21 then
        Dad = "special_male_" .. (tonumber(string.sub(Dad, 2, 2)) - 1)
    else
        Dad = "male_" .. Dad
    end
    Graphics.Sprite("pause_menu_pages_char_mom_dad", "mumdadbg", CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + (CurrentMenu.WidthOffset / 1), 228)
    Graphics.Sprite("char_creator_portraits", Dad, CurrentMenu.X + 195 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 228, 228)
    Graphics.Sprite("char_creator_portraits", Mum, CurrentMenu.X + 25 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 228, 228)
    RageUI.ItemOffset = RageUI.ItemOffset + 228
end

---AddList
---@param Label string
---@param ItemIndex number
---@param Description string
---@param Actions fun(Index:number, onSelected:boolean, onListChange:boolean))
function Items:HeritageSlider(Label, ItemIndex, Description, Actions)
    local CurrentMenu = RageUI.CurrentMenu
    local Option = RageUI.Options + 1
    local preWorkIndex = ItemIndex

    local items = {}
    for i=1,10 do
        table.insert(items, i)
    end

    if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
        local Active = CurrentMenu.Index == Option
        -- local LeftArrowHovered, RightArrowHovered = false, false

        RageUI.ItemsSafeZone(CurrentMenu)

        local Hovered = false
        local RightOffset = 0

        if Active then
            Graphics.Sprite("commonmenu", "gradient_nav", CurrentMenu.X, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 38)
        end

        Graphics.Text(Label, CurrentMenu.X + 8, CurrentMenu.Y + 3 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.33, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255)
        Graphics.Sprite("mpleaderboard", "leaderboard_female_icon", CurrentMenu.X + 215 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, Active and 0 or 255, Active and 0 or 255, Active and 0 or 255, 255)
        Graphics.Sprite("mpleaderboard", "leaderboard_male_icon", CurrentMenu.X + 395 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 0 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 40, 40, 0, Active and 0 or 255, Active and 0 or 255, Active and 0 or 255, 255)

        Graphics.Rectangle(CurrentMenu.X + 250 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 14.5 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 150, 9, 4, 32, 57, 255)
        Graphics.Rectangle(CurrentMenu.X + 250 + (((150 - 75) / (#items)) * (ItemIndex)) + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + 14.5 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 75, 9, 57, 116, 200, 255)
        Graphics.Rectangle(CurrentMenu.X + 323.5 + CurrentMenu.WidthOffset, CurrentMenu.Y + 9 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 2.5, 20, 245, 245, 245, 255)

        RageUI.ItemOffset = RageUI.ItemOffset + 38

        if Active then
            RageUI.ItemsDescription(Description)
            
            if CurrentMenu.Controls.Left.Active and not CurrentMenu.Controls.Right.Active then
                ItemIndex = ItemIndex - 0.1
                if ItemIndex < 0.1 then
                    ItemIndex = 0.0
                else
                    Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
                end
            elseif not CurrentMenu.Controls.Left.Active and CurrentMenu.Controls.Right.Active then
                ItemIndex = ItemIndex + 0.1
                if ItemIndex > #items then
                    ItemIndex = 10
                else
                    Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
                end
            end

            if CurrentMenu.Controls.Select.Active then
                Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef, false)
            end
        end

        Actions(ItemIndex, Active and CurrentMenu.Controls.Select.Active, ItemIndex ~= preWorkIndex)
    end
    RageUI.Options = RageUI.Options + 1
end

--[[
---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsSlider = {
    Background = { X = 250, Y = 14.5, Width = 150, Height = 9 },
    Slider = { X = 250, Y = 14.5, Width = 75, Height = 9 },
    Divider = { X = 323.5, Y = 9, Width = 2.5, Height = 20 },
    LeftArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_female_icon", X = 215, Y = 0, Width = 40, Height = 40 },
    RightArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_male_icon", X = 395, Y = 0, Width = 40, Height = 40 },
}
]]
