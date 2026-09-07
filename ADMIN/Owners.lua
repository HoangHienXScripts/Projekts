local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local vars, plr
vars = {}
plr = plrs.LocalPlayer

function rcv_hrp(t)
  return t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
end

function rcv_hmoid(t)
  return t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
end

function t_alive(t)
  return t and rcv_hmoid(t) and rcv_hmoid(t).Health > 0
end

function do_cmd(t, n)
  local t = {hrp = rcv_hrp(t), hmoid = rcv_hmoid(t), alive = t_alive(t)}
  local s = {hrp = rcv_hrp(plr), hmoid = rcv_hmoid(plr), alive = t_alive(plr)}
  if n == "/rs" then
    if s.hmoid and s.alive then s.hmoid.Health = 0 end
  elseif n == "/br" then
    if s.hrp and s.alive and t.hrp and t.alive then
      s.hrp.CFrame = CFrame.new(t.hrp.Position + (t.hrp.CFrame.LookVector * 5))
    end
  end
end

function do_connect(t)
  t.Chatted:Connect(function(m)
    m = m:split(" ") do_cmd(t, m)
  end)
end

for _, user in next, plrs:GetPlayers() do
  if user then do_connect(user) end
end

plrs.PlayerAdded:Connect(function(t) if t then do_connect(t) end end)
