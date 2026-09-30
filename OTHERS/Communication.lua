local ws, plrs, core
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
core = game:GetService("CoreGui")

local plr, vars
plr = plrs.LocalPlayer
vars = {
  version = "0.01",
  ui = {
    display = false
  },
  radnum = function() return tostring(math.random(1, 9999)) end
}

local fol, screenui, toggle, scroll, layout
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
  lb.RichText = false
  lb.Font = Enum.Font.Arcade
  lb.Text = user..": "..message
  lb.LayoutOrder = 0
  lb.TextXAlignment = "Left"
  lb.TextYAlignment = "Top"
  lb.Visible = true
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
