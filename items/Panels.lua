---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

---@class Panels
Panels = {};

local GridType = {
    Default = 1,
    Horizontal = 2,
    Vertical = 3
}

local GridSprite = {
    [GridType.Default] = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", },
    [GridType.Horizontal] = { Dictionary = "RageUI_", Texture = "horizontal_grid", },
    [GridType.Vertical] = { Dictionary = "RageUI_", Texture = "vertical_grid", },
}

local Grid = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
        Left = { X = 57.75, Y = 130, Scale = 0.35 },
        Right = { X = 373.25, Y = 130, Scale = 0.35 },
    },
}

local Percentage = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
    Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
    Text = {
        Left = { X = 25, Y = 15, Scale = 0.35 },
        Middle = { X = 215.5, Y = 15, Scale = 0.35 },
        Right = { X = 398, Y = 15, Scale = 0.35 },
    },
}

local function UIGridPanel(Type, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if (CurrentMenu.Index == Index) then
        local X = Type == GridType.Default and StartedX or Type == GridType.Horizontal and StartedX or Type == GridType.Vertical and 0.5
        local Y = Type == GridType.Default and StartedY or Type == GridType.Horizontal and 0.5 or Type == GridType.Vertical and StartedY
        local Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + Grid.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20, Grid.Grid.Width + CurrentMenu.WidthOffset - 40, Grid.Grid.Height - 40)
        local Selected = false
        local CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20
        local CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20
        if X < 0.0 or X > 1.0 then
            X = 0.0
        end
        if Y < 0.0 or Y > 1.0 then
            Y = 0.0
        end
        CircleX = CircleX + ((Grid.Grid.Width - 40) * X) - (Grid.Circle.Width / 2)
        CircleY = CircleY + ((Grid.Grid.Height - 40) * Y) - (Grid.Circle.Height / 2)
        Graphics.Sprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Background.Width + CurrentMenu.WidthOffset, Grid.Background.Height)
        Graphics.Sprite(GridSprite[Type].Dictionary, GridSprite[Type].Texture, CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Grid.Width, Grid.Grid.Height)
        Graphics.Sprite(Grid.Circle.Dictionary, Grid.Circle.Texture, CircleX, CircleY, Grid.Circle.Width, Grid.Circle.Height)
        if (Type == GridType.Default) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Vertical) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Horizontal) then
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if Hovered then
            if IsDisabledControlPressed(0, 24) then
                Selected = true
                CircleX = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (Grid.Circle.Width / 2)
                CircleY = math.round(GetControlNormal(2, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (Grid.Circle.Height / 2)
                if CircleX > (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40
                elseif CircleX < (CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)
                end
                if CircleY > (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40
                elseif CircleY < (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)
                end
                X = math.round((CircleX - (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20) + (Grid.Circle.Width / 2)) / (Grid.Grid.Width - 40), 2)
                Y = math.round((CircleY - (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20) + (Grid.Circle.Height / 2)) / (Grid.Grid.Height - 40), 2)
                if (X ~= StartedX) and (Y ~= StartedY) then
                    Action(X, Y, (X * 2 - 1), (Y * 2 - 1))
                    --	Action.onPositionChange(X, Y, (X * 2 - 1), (Y * 2 - 1))
                end
                StartedX = X;
                StartedY = Y;
                if X > 1.0 then
                    X = 1.0
                end
                if Y > 1.0 then
                    Y = 1.0
                end
            end
        end
        RageUI.ItemOffset = RageUI.ItemOffset + Grid.Background.Height + Grid.Background.Y
        if Hovered and Selected then
            Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
            --if (Action.onSelected ~= nil) then
            --	Action.onSelected(X, Y, (X * 2 - 1), (Y * 2 - 1));
            --end
        end
    end
end

---Grid
---@param StartedX number
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:Grid(StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Default, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
end

---GridHorizontal
---@param StartedX number
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridHorizontal(StartedX, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Horizontal, StartedX, nil, nil, nil, LeftText, RightText, Action, Index)
end

---GridVertical
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridVertical(StartedY, TopText, BottomText, Action, Index)
    UIGridPanel(GridType.Vertical, nil, StartedY, TopText, BottomText, nil, nil, Action, Index)
end

function Panels:PercentagePanel(Percent, Header, Min, Max, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu.Index == Index then
        local Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + 9 + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + 50 + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 4, 413 + CurrentMenu.WidthOffset, 10 + 8)
        local Selected = false
        local Progress = 413

        if Percent < 0.0 then Percent = 0.0 elseif Percent > 1.0 then Percent = 1.0 end

        Progress = Progress * Percent

        Graphics.Sprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 76)
        Graphics.Rectangle(CurrentMenu.X + 9 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 50 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 413, 10, 87, 87, 87, 255)
        Graphics.Rectangle(CurrentMenu.X + 9 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 50 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Progress, 10, 245, 245, 245, 255)

        Graphics.Text(Header or "Opacity", CurrentMenu.X + 215.5 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 1)
        Graphics.Text(Min or "0%", CurrentMenu.X + 25 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 1)
        Graphics.Text(Max or "100%", CurrentMenu.X + 398 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 1)

        if Hovered and IsDisabledControlPressed(0, 24) then
            Selected = true

            Progress = math.round(math.round(GetControlNormal(0, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (CurrentMenu.X + 9 + (CurrentMenu.WidthOffset / 2)))

            if Progress < 0 then
                Progress = 0
            elseif Progress > 413 then
                Progress = 413
            end

            Percent = math.round(Progress/413, 2)
        end

        RageUI.ItemOffset = RageUI.ItemOffset + 76 + 4

        if Hovered and Selected then
            local sound = RageUI.Settings.Audio

            Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
        end

        Action(Hovered, Selected, Percent)
    end
end

function Panels:ColourPanel(Title, Colours, Min, Current, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu

    if CurrentMenu.Index == Index then
        local Max = (#Colours > 9) and 9 or #Colours
        local Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + 15 + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 55 + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, (44.5 * Max), 44.5)
        local LeftArrowHovered = Graphics.IsMouseInBounds(CurrentMenu.X + 7.5 + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 30, 30)
        local RightArrowHovered = Graphics.IsMouseInBounds(CurrentMenu.X + 393.5 + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 30, 30)
        local Selected = false
        Graphics.Sprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + 4 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 431 + CurrentMenu.WidthOffset, 112)
        Graphics.Sprite("commonmenu", "arrowleft", CurrentMenu.X + 7.5 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 30, 30)
        Graphics.Sprite("commonmenu", "arrowright", CurrentMenu.X + 393.5 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 30, 30)

        Graphics.Rectangle(CurrentMenu.X + 15 + (44.5 * (Current - Min)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 47 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 44.5, 8, 245, 245, 245, 255)

        for i = 1,Max do
            Graphics.Rectangle(CurrentMenu.X + 15 + (44.5 * (i - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 55 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 44.5, 44.5, table.unpack(Colours[Min + i - 1]))
        end

        Graphics.Text((Title and Title or "") .. " (" .. Current .. "/" .. #Colours .. ")", CurrentMenu.X + 215.5 + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 15 + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, 0.35, 245, 245, 245, 255, 1)

        if Hovered or LeftArrowHovered or RightArrowHovered then
            if RageUI.Settings.Controls.Click.Active then
                Selected = true

                if LeftArrowHovered then
                    Current = Current - 1
                    if Current < 1 then
                        Current = #Colours
                        Min = #Colours - Max + 1
                    elseif Current < Min then
                        Min = Min - 1
                    end
                elseif RightArrowHovered then
                    Current = Current + 1
                    if Current > #Colours then
                        Current = 1
                        Min = 1
                    elseif Current > Min + Max - 1 then
                        Min = Min + 1
                    end
                elseif Hovered then
                    for i = 1,Max do
                        if Graphics.IsMouseInBounds(CurrentMenu.X + 15 + (44.5 * (i - 1)) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + 55 + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 44.5, 44.5) then
                            Current = Min + i - 1
                        end
                    end
                end
            end
        end

        RageUI.ItemOffset = RageUI.ItemOffset + 112 + 4

        if (Hovered or LeftArrowHovered or RightArrowHovered) and Selected then
            Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
        end

        Action((Hovered or LeftArrowHovered or RightArrowHovered), Selected, Min, Current)
    end
end
