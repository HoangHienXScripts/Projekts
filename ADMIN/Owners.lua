-- Owners Control --
local ws, plrs, reps, rs, txs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
reps = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")
txs = game:GetService("TextChatService")

local vars, plr
vars = {
  chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService,
  s_des = false, s_cal = false, prefix = "/",
  owners = {"bloxfruits_devs09"}
}
plr = plrs.LocalPlayer

function ntfc(m) m = tostring(m)
  if not vars.chatv then
    txs.TextChannels.RBXGeneral:SendAsync(m)
  else
    reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
  end
end

function str_check(t, n)
  return t == vars.prefix..n
end

function rcv_hrp(t)
  return t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
end

function rcv_hmoid(t)
  return t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
end

function t_alive(t)
  return t and rcv_hmoid(t) and rcv_hmoid(t).Health > 0
end

function nearby_t()
  local t = {n = nil, m = math.huge, h = rcv_hrp(plr)}
  for _, near in pairs(plrs:GetPlayers()) do
    if t.h and near and rcv_hrp(near) then
      local d = (rcv_hrp(near).Position - t.h.Position).magnitude
      if d < t.m then t.m = d
        t.n = near
      end
    end
  end return t.n
end

function do_cmd(t, n) print(t, n)
  local t = {hrp = rcv_hrp(t), hmoid = rcv_hmoid(t), alive = t_alive(t)}
  local s = {hrp = rcv_hrp(plr), hmoid = rcv_hmoid(plr), alive = t_alive(plr)}
  --if table.find(vars.owners, plr.Name:lower()) then return end
  if str_check(n, "rs") then
    if s.hmoid and s.alive then s.hmoid.Health = 0 end
  elseif str_check(n, "br") then
    if s.hrp and s.alive and t.hrp and t.alive then
      s.hrp.CFrame = CFrame.new(t.hrp.Position + (t.hrp.CFrame.LookVector * 5))
    end
  elseif str_check(n, "dps") then
    vars.s_des = not vars.s_des
    ntfc(vars.s_des)
  elseif str_check(n, "idt") then
    if identifyexecutor then ntfc(tostring(identifyexecutor())) else ntfc("api doesn't exist...") end
  elseif str_check(n, "cmds") then
    ntfc("prefix:\""..vars.prefix.."\", rs, br, dps")
  end
end

function do_connect(t)
  t.Chatted:Connect(function(m)
    m = m:split(" ") do_cmd(t, m[1])
  end)
end

for _, user in next, plrs:GetPlayers() do if user then do_connect(user) end end
plrs.PlayerAdded:Connect(function(t) if t then do_connect(t) end end)

rs.RenderStepped:Connect(function()
  local near = nearby_t()
  if near and vars.s_des then
    --if not table.find(vars.owners, near.Name:lower()) then return end
    if not vars.s_cal then vars.s_cal = true
      local t_hmoid, s_hmoid = rcv_hmoid(near), rcv_hmoid(plr)
      if t_hmoid and s_hmoid then
        local hp = t_hmoid.Health
        task.wait(1.5)
        if hp > t_hmoid.Health then
          print("hit "..near.Name:sub(1, 4).."...")
          s_hmoid.Health = 0
        end
      end vars.s_cal = false
    end
  end
end)
