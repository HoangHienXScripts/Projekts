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
  version = "0.25".." [BETA]",
  map_optimized = false,
  last_pos = nil,
  chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService,
  autof = {
    offset = "X", frm = false, x = 0, y = 0, z = 3.5
  },
  locations = {
    ["Samurai-Cutscene"] = {-54, 1636, 25249},
	["Map-Edge"] = {-281, 440, 478}
  },
  cons = {}, btns = {}, sorts = {}, tp_btns = {}
} plr = plrs.LocalPlayer

function btn_newbc(t, n) t.BackgroundColor3 = Color3.new(table.unpack(n)) end
function btn_newtc(t, n) t.TextColor3 = Color3.new(table.unpack(n)) end
function btn_newt(t, n) t.Text = n end
function watever(n) return "HHxScripts - "..n end
function new_cnt(n, t) if n and type(n) == "string" then vars.cons[n] = t end end
function ntfc(m) m = tostring(m)
  if not vars.chatv then
    txs.TextChannels.RBXGeneral:SendAsync(m)
  else
    reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
  end
end

function exit_cnt(n)
  local found = false
  for idx, _ in next, vars.cons do
    if idx == n then vars.cons[idx]:Disconnect()
	  vars.cons[idx] = nil
	  found = true
	  break
	end
  end if found then found = "[-]: disconnect successful."
  else found = "[!]: name mismatch."
  end return found
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
    new_cnt("autof", rs.Heartbeat:Connect(function()
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
    --if #vars.cons > 0 then for i = 1, #vars.cons do if vars.cons[i] then vars.cons[i]:Disconnect() vars.cons[i] = nil end end end
	--for i, c_n in next, vars.cons do if i == "autof" then vars.cons[i]:Disconnect() vars.cons[i] = nil end end
	exit_cnt("autof")
    btn_newt(btn, "Auto Farm [OFF]")
	btn_newtc(btn, {1, 1, 1})
  end vars.autof.frm = not vars.autof.frm
end)

vars.btns.mod_map_label = ui.add_button(watever"Map", function() print("nil") end)
vars.btns.mod_map_label.BackgroundColor3 = Color3.new(1, 1, 0)
vars.btns.mod_map_label.TextColor3 = Color3.new(0, 0, 0)
vars.btns.mod_map_label.Font = Enum.Font.Arcade

for lc_name, lc_pos in next, vars.locations do
  table.insert(vars.tp_btns, ui.add_button("🔒: "..lc_name, function()
    local m_hrp = rcv_hrp(plr)
	if m_hrp and t_alive(plr) and vars.map_optimized then
      m_hrp.CFrame = CFrame.new(Vector3.new(unpack(lc_pos)) + Vector3.new(0, 2, 0))
	else
	  if #vars.tp_btns > 0 then
        for idx = 1, #vars.tp_btns do
          local s_btn = vars.tp_btns[idx]
		  s_btn.Text = s_btn.Text:gsub("🔒", "🔐") task.wait(0.05)
		  s_btn.Text = s_btn.Text:gsub("🔐", "🔒") task.wait(0.05)
		  s_btn.Text = s_btn.Text:gsub("🔒", "🔐") task.wait(0.05)
		  s_btn.Text = s_btn.Text:gsub("🔐", "🔒") task.wait(0.05)
		end
	  end
	  btn_newbc(vars.btns.optimize_map, {1, 1, 1}) task.wait(0.15)
	  btn_newbc(vars.btns.optimize_map, {1, 1, 0}) task.wait(0.15)
	  btn_newbc(vars.btns.optimize_map, {1, 1, 1}) task.wait(0.15)
	  btn_newbc(vars.btns.optimize_map, {1, 1, 0}) task.wait(0.15)
	end btn_newbc(vars.btns.optimize_map, {0, 0, 0})
  end)) --btn:SetAttribute("BTN_LOCKED", true)
end

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
  end vars.map_optimized = true
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
  main_part.Touched:Connect(function(p_t)
    local xp_t = p_t.Parent
    if xp_t.Name:match(plr.Name) and xp_t:FindFirstChild("HumanoidRootPart") then
      vars.last_pos = xp_t.HumanoidRootPart.Position or nil
	end
  end) new_cnt("anti_void", rs.RenderStepped:Connect(function()
    local m_hrp = rcv_hrp(plr)
	if m_hrp and t_alive(plr) then
      local y_pos_hrp, y_pos_mp = m_hrp.Position.Y, main_part.Position.Y
	  if vars.last_pos and y_pos_hrp < y_pos_mp - 25 then
	    m_hrp.CFrame = CFrame.new(vars.last_pos + Vector3.new(0, 2, 0))
	  end
	end
  end)) main_part.CastShadow = false
  main_part.Material = Enum.Material.Grass
  main_part.Color = Color3.fromRGB(0, 100, 0)
  main_part.Size = Vector3.new(main_part.Size.X, 2, main_part.Size.Z)
  main_part.Position = Vector3.new(main_part.Position.X, 436.5, main_part.Position.Z)
  btn_newt(btn, "Rebuilt-Map")
end)

ntfc("TSB-Script v"..vars.version..".")
