-- Test 1 --
local ws, plrs, core, rs, htps, mdl
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
core = game:GetService("CoreGui")
rs = game:GetService("RunService")
htps = game:GetService("HttpService")
mdl = loadstring(game:HttpGet("\104\116\116\112\115\058\047\047\114\097\119\046\103\105\116\104\117\098\117\115\101\114\099\111\110\116\101\110\116\046\099\111\109\047\072\111\097\110\103\072\105\101\110\088\083\099\114\105\112\116\115\047\077\111\100\117\108\101\115\047\114\101\102\115\047\104\101\097\100\115\047\097\108\116\047\099\111\110\115\111\108\101\095\108\111\103\046\108\117\097"))("HdcqvBvMCa7sH16g5CeYtytUCSSrT15tSPMVwFeD")
repeat task.wait() until mdl and type(mdl) == "table"

local plr, vars
plr = plrs.LocalPlayer
vars = {
  version = "0.01",
  ui = {
    display = false, order = 0, updt = false
  },
  info = {},
  radnum = function() return tostring(math.random(1, 9999)) end,
  child = function(t) return t:GetChildren() end,
  enc = function(t) return htps:JSONEncode(t) end,
  dec = function(t) return htps:JSONDecode(t) end
}

if mdl.read("Projekts", 1) == "null" then
  mdl.update("Projekts", {["Communication_Script"] = {["Ignore"] = {user = "nil", str = "test"}}})
end vars.info = mdl.read("Projekts")
_G.test = {mdl, vars.info}

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
box.BorderColor3 = Color3.new(1, 1, 1)
box.Position = UDim2.new(0.3, 0, 0.6275, 0)
box.Size = UDim2.new(0.4, 0, 0.06, 0)
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

function rcv_info()
  vars.info = mdl.read("Projekts")
end

function inspect_element(t, time)
    time = time or 0 local structure = string.rep(" ", time) .. "{\n"
    for a, b in pairs(t) do local _istype = type(b)
        if _istype == "table" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = {\n"
            structure = structure .. inspect_element(b, time + 8)
            structure = structure .. string.rep(" ", time + 4) .. "}\n"
        elseif _istype == "function" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = function: " .. tostring(b) .. "\n"
        elseif _istype == "boolean" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = " .. tostring(b) .. "\n"
        elseif _istype == "number" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = " .. tostring(b) .. "\n"
        elseif _istype == "string" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = \"" .. tostring(b) .. "\"\n"
        elseif _istype == "nil" then structure = structure .. string.rep(" ", time + 4) .. tostring(a) .. " = nil\n"
        end end structure = structure .. string.rep(" ", time) .. "}\n"
    print(structure)
end

function find_expired_key()
  local out, sect = {}, vars.info.Communication_Script
  for idx, data in next, sect do
    if idx ~= "Ignore" then
      local slt = tick() - tonumber(idx)
      if slt >= 18000 then
        table.insert(out, idx)
      end
    end
  end return out
end

function rmv_expired_key(t)
  local out, sect = {}, vars.info.Communication_Script
  for idx, data in next, sect do
    if idx ~= "Ignore" then
      if not table.find(t, idx) then
        out[idx] = data
      end
    end
  end vars.info.Communication_Script = out
end

function update_key(m)
  local sect, expi = vars.info.Communication_Script, find_expired_key()
  if #expi > 0 then rmv_expired_key(expi) end
  if sect and type(sect) == "table" then
    vars.info.Communication_Script[tostring(tick())] = {
      user = plr.DisplayName, str = m
    } inspect_element(vars.info, 0) --mdl.update("Projekts", vars.info)
  end
end

function add_message(user, message)
  local base, m_len, lb = 0.003, #message, nil
  if m_len > 185 then return end
  if m_len > 37 then
    base = 0.003 + (0.006 * (m_len / 37))
  end print("[!]: Base size changed to "..tostring(base)..".")
  lb = Instance.new("TextLabel", scroll)
  lb.Name = "STRF:"..user:sub(1, 4):upper().."-"..vars.radnum()
  lb.BackgroundTransparency = 0.5
  lb.BackgroundColor3 = Color3.new(0, 0, 0)
  lb.BorderColor3 = Color3.new(1, 1, 1)
  lb.Position = UDim2.new(0, 0, 0, 0)
  lb.Size = UDim2.new(1, 0, base, 0)
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

function clear_scroll()
  for _, item in next, vars.child(scroll) do
    if item.ClassName == "TextLabel" then
      item:Destroy()
    end
  end
end

function update_scroll()
  local order, sect = {}, vars.info.Communication_Script
  for idx, _ in next, sect do
    if idx ~= "Ignore" then
      table.insert(order, tonumber(idx))
    end
  end table.sort(order) clear_scroll()
  for idx = 1, #order do
    local data = sect[tostring(order[idx])]
    add_message(data.user, data.str)
  end
end

toggle.MouseButton1Click:Connect(function()
  if not vars.ui.display then
    scroll.Visible = true
    box.Visible = true
    toggle.TextColor3 = Color3.new(0, 1, 0)
  else
    scroll.Visible = false
    box.Visible = false
    toggle.TextColor3 = Color3.new(1, 1, 1)
  end vars.ui.display = not vars.ui.display
end)

box.FocusLost:Connect(function(t)
  if t then update_key(box.Text) end
end)

rs.RenderStepped:Connect(function(dt)
  if dt and not vars.ui.updt then vars.ui.updt = true
    rcv_info() task.wait(1)
    update_scroll() task.wait(5)
    vars.ui.updt = false
  end
end)
