-- Admin --
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
  frz = false,
  cmds = {},
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

function total() return plrs:GetPlayers() end
function same(t) return t.Name:lower() end

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

function add_cmd(n, d, f) vars.cmds[n] = {desc = d, func = f} end
function run_cmd(n, ...)
  for name, _ in next, vars.cmds do
    if name ~= n then return end
  end vars.cmds[n].func(table.unpack({...}))
end

-- Commands Section --
add_cmd("prefix", "change cmds prefix", function(nf)
  vars.prefix = nf
  ntfc("prefix changed to: "..nf)
end)

add_cmd("hp", "change health", function(n, amount)

end)
-- Close Commands Section --

function do_connect(t)
  t.Chatted:Connect(function(s)
    s = s:split(" ")
    if s and type(s) == "table" and #s > 0 then
      run_cmd(s[1], table.concat(s, " ", 2):split(" "))
    end
  end)
end

for _, user in next, total() do
  if user then do_connect(user)
    if same(plr) ~= same(user) and table.find(vars.owners, user.Name:lower()) then
      ntfc("<I Found You, Commander "..user.DisplayName:sub(1, 4)..">")
    end
  end
end

plrs.PlayerAdded:Connect(function(user)
  if user then do_connect(user)
    if same(plr) ~= same(user) and table.find(vars.owners, user.Name:lower()) then
      ntfc("<Welcome, Commander "..user.DisplayName:sub(1, 4)..">")
    end
  end
end)
