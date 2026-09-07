-- Reworks --
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Modules/refs/heads/main/btns_list.lua"))()
local ws, plrs, reps, rs, txs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
reps = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")
txs = game:GetService("TextChatService")

local vars, plr
vars = {
  version = "0.1",
  chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService,
  autof = {
    frm = false, x = 0, y = 0, z = 3
  },
  cons = {}, btns = {}
} plr = plrs.LocalPlayer

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

ui.add_button(watever"Main", function() print("nil") end)
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
  else
    if #vars.cons > 0 then for i = 1, #vars.cons do if vars.cons[i] then vars.cons[i]:Disconnect() vars.cons[i] = nil end end end
    btn_newt(btn, "Auto Farm [OFF]")
  end vars.autof.frm = not vars.autof.frm
end) ntfc("TSB-Script v"..vars.version..".")
