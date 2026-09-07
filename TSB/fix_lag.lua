-- Reworks --
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Modules/refs/heads/main/btns_list.lua"))()
local ws, plrs, reps, rs, txs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
reps = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")
txs = game:GetService("TextChatService")
loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Projekts/refs/heads/main/ADMIN/Owners.lua"))()

local vars, plr
vars = {
  version = "0.2",
  map_optimized = false,
  chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService,
  autof = {
    offset = "X", frm = false, x = 0, y = 0, z = 3.5
  },
  cons = {}, btns = {}
} plr = plrs.LocalPlayer

function btn_newtc(t, n) t.TextColor3 = Color3.new(table.unpack(n)) end
function btn_newt(t, n) t.Text = n end
function watever(n) return "HHxScripts - "..n end
function ntfc(m) m = tostring(m)
  if not vars.chatv then
    txs.TextChannels.RBXGeneral:SendAsync(m)
  else
    reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
  end
end

function rcv_hrp(t)
  return t and t.Character and t.Character:FindFirstChild"HumanoidRootPart"
end

function t_alive(t)
  return t and t.Character and t.Character:FindFirstChildOfClass"Humanoid" and t.Character.Humanoid.Health > 0
end

function rcv_enm()
  local t = {n = nil, m = math.huge, s = rcv_hrp(plr)}
  for _, enm in pairs(plrs:GetPlayers()) do
    if enm and enm ~= plr and rcv_hrp(enm) and t.s then
      local d = (rcv_hrp(enm).Position - t.s.Position).magnitude
	  if d < t.m and t_alive(enm) then t.m = d t.n = enm end
	end
  end return t.n
end

vars.btns.main_label = ui.add_button(watever"Main", function() print("nil") end)
vars.btns.main_label.BackgroundColor3 = Color3.new(1, 1, 0)
vars.btns.main_label.TextColor3 = Color3.new(0, 0, 0)
vars.btns.main_label.Font = Enum.Font.Arcade

vars.btns.autof_offset_display = ui.add_button(tostring(vars.autof.offset).." >> {"..tostring(vars.autof.x)..", "..tostring(vars.autof.y)..", "..tostring(vars.autof.z).."}", function()
  local btn, frm = vars.btns.autof_offset_display, vars.autof
  local newt = " >> {"..tostring(frm.x)..", "..tostring(frm.y)..", "..tostring(frm.z).."}"
  if frm.offset == "X" then frm.offset = "Y"
  elseif frm.offset == "Y" then frm.offset = "Z"
  else frm.offset = "X"
  end btn_newt(btn, frm.offset..newt)
end)

vars.btns.autof_offset_inc = ui.add_button("OFFSET: [+]", function()
  local btn, frm = vars.btns.autof_offset_display, vars.autof
  if frm.offset == "X" then vars.autof.x += 0.5
  elseif frm.offset == "Y" then vars.autof.y += 0.5
  else vars.autof.z += 0.5
  end btn_newt(btn, frm.offset.." >> {"..tostring(frm.x)..", "..tostring(frm.y)..", "..tostring(frm.z).."}")
end)

vars.btns.autof_offset_dec = ui.add_button("OFFSET: [-]", function()
  local btn, frm = vars.btns.autof_offset_display, vars.autof
  if frm.offset == "X" then vars.autof.x -= 0.5
  elseif frm.offset == "Y" then vars.autof.y -= 0.5
  else vars.autof.z -= 0.5
  end btn_newt(btn, frm.offset.." >> {"..tostring(frm.x)..", "..tostring(frm.y)..", "..tostring(frm.z).."}")
end)

vars.btns.autof = ui.add_button("Auto Farm [OFF]", function()
  local btn = vars.btns.autof
  if not vars.autof.frm then
    table.insert(vars.cons, rs.Heartbeat:Connect(function()
      local enm = rcv_enm()
	  if enm and enm ~= nil then
        local s_hrp, enm_hrp, frm = rcv_hrp(plr), rcv_hrp(enm), vars.autof
	    if s_hrp and enm_hrp then
          s_hrp.CFrame = enm_hrp.CFrame * CFrame.new(frm.x, frm.y, frm.z)
		end
	  end
	end)) btn_newt(btn, "Auto Farm [ON]")
	btn_newtc(btn, {0, 1, 0})
  else
    if #vars.cons > 0 then for i = 1, #vars.cons do if vars.cons[i] then vars.cons[i]:Disconnect() vars.cons[i] = nil end end end
    btn_newt(btn, "Auto Farm [OFF]")
	btn_newtc(btn, {1, 1, 1})
  end vars.autof.frm = not vars.autof.frm
end)

--MainPart size y = 2, pos y = 436.5
vars.btns.optimize_label = ui.add_button(watever"Optimizations", function() print("nil") end)
vars.btns.optimize_label.BackgroundColor3 = Color3.new(1, 1, 0)
vars.btns.optimize_label.TextColor3 = Color3.new(0, 0, 0)
vars.btns.optimize_label.Font = Enum.Font.Arcade

vars.btns.optimize_map = ui.add_button("Rebuilt-Map", function()
  local btn, map = vars.btns.optimize_map, ws:FindFirstChild("Map")
  if vars.map_optimized then btn_newt(btn, "ALREADY OPTIMIZED")
    btn_newtc(btn, {1, 1, 0}) task.wait(0.5)
	btn_newt(btn, "Rebuilt-Map") btn_newtc(btn, {1, 1, 1})
	return
  end
  local main_part = map:FindFirstChild("MainPart")
  for _, v in pairs(map:GetChildren()) do
    if v and v:IsA("Folder") and v.Name:sub(1, 5):lower() ~= "trash" then
      v:ClearAllChildren()
	  btn_newt(btn, v.Name:upper()..": CLEARED")
	  task.wait(0.1)
	end
  end task.wait(0.02)
  for _, v in pairs(map:GetChildren()) do
	if v and v.Name:lower():match("tunnel") then
	  v:Destroy()
	  btn_newt(btn, v.Name:upper()..": REMOVED")
	  task.wait(0.1)
	end
  end task.wait(0.02)
  main_part.Touched:Connect(function(p_t) print(p_t:GetFullName()) end)
  main_part.CastShadow = false
  main_part.Material = Enum.Material.Grass
  main_part.Color = Color3.fromRGB(0, 100, 0)
  main_part.Size = Vector3.new(main_part.Size.X, 2, main_part.Size.Z)
  main_part.Position = Vector3.new(main_part.Position.X, 436.5, main_part.Position.Z)
  btn_newt(btn, "Rebuilt-Map")
end)

ntfc("TSB-Script v"..vars.version..".")
