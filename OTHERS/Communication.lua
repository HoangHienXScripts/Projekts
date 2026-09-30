-- Test 1 --
local ws, plrs, core
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
core = game:GetService("CoreGui")

local plr, vars
plr = plrs.LocalPlayer
vars = {
  version = "0.01",
  ui = {
    display = false, order = 0
  },
  radnum = function() return tostring(math.random(1, 9999)) end
}

local fol, screenui, toggle, scroll, layout, box
fol = Instance.new("Folder", core)
fol.Name = "CommF_Script_v"..vars.version

screenui = Instance.new("ScreenGui", fol)
screenui.Name = "BOARD:["..vars.radnum().."]"

toggle = Instance.new("TextButton", screenui)
toggle.Name = "TOGGLE:["..vars.radnum().."]"
toggle.BackgroundTransparency = 0.5
toggle.BackgroundColor3 = Color3.new(0, 0, 0)
toggle.Position = UDim2.new(0.2, 0, 0.3, 0)
toggle.Size = UDim2.new(0.05, 0, 0.1, 0)
toggle.TextSize = 12
toggle.TextScaled = true
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.Arcade
toggle.Text = "OPEN"
toggle.Visible = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 0.15)

scroll = Instance.new("ScrollingFrame", screenui)
scroll.Name = "DISPLAYER:["..vars.radnum().."]"
scroll.BackgroundTransparency = 0.5
scroll.BackgroundColor3 = Color3.new(0, 0, 0)
scroll.BorderColor3 = Color3.new(1, 1, 1)
scroll.Position = UDim2.new(0.3, 0, 0.12, 0)
scroll.Size = UDim2.new(0.4, 0, 0.5, 0)
scroll.CanvasSize = UDim2.new(0, 0, 20, 0)
scroll.ScrollBarThickness = 0.1
scroll.Visible = false

layout = Instance.new("UIListLayout", scroll)
layout.Name = "LAYOUT-HANDLER:["..vars.radnum().."]"
layout.SortOrder = "LayoutOrder"

box = Instance.new("TextBox", screenui)
box.Name = "BOX:["..vars.radnum().."]"
box.BackgroundTransparency = 0.5
box.BackgroundColor3 = Color3.new(0, 0, 0)
box.Position = UDim2.new()
box.Size = UDim2.new()
box.TextSize = 14
box.TextScaled = false
box.TextColor3 = Color3.new(1, 1, 1)
box.TextWrapped = true
box.Font = Enum.Font.Arcade
box.Text = ""
box.PlaceholderText = "Your message... =>"
box.TextXAlignment = "Left"
box.TextYAlignment = "Top"
box.Visible = false

function add_message(user, message)
  local lb = Instance.new("TextLabel", scroll)
  lb.Name = "STRF:"..str:sub(1, 4):upper().."-"..vars.radnum()
  lb.BackgroundTransparency = 0.5
  lb.BackgroundColor3 = Color3.new(0, 0, 0)
  lb.BorderColor3 = Color3.new(1, 1, 1)
  lb.Position = UDim2.new(0, 0, 0, 0)
  lb.Size = UDim2.new(1, 0, 0.003, 0)
  lb.TextSize = 14
  lb.TextScaled = false
  lb.TextColor3 = Color3.new(1, 1, 1)
  lb.TextWrapped = true
  lb.RichText = false
  lb.Font = Enum.Font.Arcade
  lb.Text = user..": "..message
  lb.LayoutOrder = vars.ui.order or 0
  lb.TextXAlignment = "Left"
  lb.TextYAlignment = "Top"
  lb.Visible = true
  vars.ui.order += 1
end

toggle.MouseButton1Click:Connect(function()
  if not vars.ui.display then
    scroll.Visible = true
    toggle.TextColor3 = Color3.new(0, 1, 0)
  else
    scroll.Visible = false
    toggle.TextColor3 = Color3.new(1, 1, 1)
  end vars.ui.display = not vars.ui.display
end)

box.FocusLost:Connect(function(t)
  if t then
    add_message(plr.DisplayName, box.Text)
  end
end)
