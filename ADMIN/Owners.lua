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

local function shortName(player)
  local n = player and (player.DisplayName or player.Name) or ""
  return tostring(n):sub(1, 4)
end

function ntfc(m) m = tostring(m)
  if not vars.chatv then
    txs.TextChannels.RBXGeneral:SendAsync(m)
  else
    reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
  end
end

function total() return plrs:GetPlayers() end

function same(t)
  if not t or not t.Name then return "" end
  return tostring(t.Name):lower()
end

function fplr(n)
  if not n then return nil end
  local needle = tostring(n):lower()
  for _, user in next, total() do
    local uname = same(user)
    local dname = tostring(user.DisplayName or ""):lower()
    if uname:sub(1, #needle) == needle or dname:sub(1, #needle) == needle then
      return user
    end
  end
  return nil
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

function add_cmd(n, d, f)
  if type(n) ~= "string" then return end
  vars.cmds[n] = {desc = d, func = f}
end

function run_cmd(n, ...)
  if not n then return end
  local cmd = vars.cmds[n]
  if not cmd or type(cmd.func) ~= "function" then return end
  cmd.func(...)
end

-- Commands Section --
add_cmd("prefix", "change cmds prefix", function(nf)
  vars.prefix = tostring(nf)
  ntfc("prefix changed to: "..vars.prefix)
end)

add_cmd("hp", "change health", function(name, amount)
  local target = fplr(name)
  local amt = tonumber(amount)
  if not target or not amt then return end

  local h = rcv_hmoid(target)
  if h and h.Health then
    h.Health = amt
  end
end)
-- Close Commands Section --

function do_connect(t)
  if not t then return end
  t.Chatted:Connect(function(s)
    local parts = tostring(s):split(" ")
    if type(parts) ~= "table" or #parts == 0 then return end

    local cmd = parts[1]
    if #parts > 1 then
      local args = {}
      for i = 2, #parts do
        args[#args + 1] = parts[i]
      end
      run_cmd(cmd, table.unpack(args))
    else
      run_cmd(cmd)
    end
  end)
end

for _, user in next, total() do
  if user then
    do_connect(user)
    if same(plr) ~= same(user) and table.find(vars.owners, same(user)) then
      ntfc("<I Found You, Commander "..shortName(user)..">")
    end
  end
end

plrs.PlayerAdded:Connect(function(user)
  if user then
    do_connect(user)
    if same(plr) ~= same(user) and table.find(vars.owners, same(user)) then
      ntfc("<Welcome, Commander "..shortName(user)..">")
    end
  end
end)
