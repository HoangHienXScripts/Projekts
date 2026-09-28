local owners = ...
local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local plr, vars, cmds, module
plr = plrs.LocalPlayer
vars, cmds, module = {
  prefix = "/"
}, {}, {}

function total() return plrs:GetPlayers() end
function childs(t) return t:GetChildren() end
function descen(t) return t:GetDescendants() end

function has_owner()
  local out = false
  if owners and type(owners) == "table" and #owners > 0 then
    out = true
  end return out
end

function module.add_cmd(n, d, f)
  if n and type(n) ~= "string" then
    return
  else cmds[n] = {desc = d, func = f}
  end
end

function run_cmd(n, s)
  local ex = cmds[n]
  if ex and ex.func and type(ex.func) == "function" then
    if has_owner and table.find(owners, plr.UserId) then return end
    ex.func(table.unpack(s:split(" ")))
  end
end

function connect_user(t)
  t.Chatted:Connect(function(s)
    s = s:split(" ")
    if #s > 0 then
      if s[1]:sub(1, 1) ~= vars.prefix then return end
      run_cmd(s[1], table.concat(s, " ", 2))
    end
  end)
end

module.add_cmd("prefix", "change command prefix", function(pf)
  local newpf = pf or vars.prefix
  if newpf == vars.prefix then
    print("[-]: Prefix remains unchanged.")
  else
    vars.prefix = tostring(newpf)
    print("[-]: Prefix changed to "..vars.prefix..".")
  end
end)

module.add_cmd("cmds", "display any cmds available", function()
  local out, t = "", 0
  for n, i in next, cmds do
    out = out .. n .. ": " .. i.desc .. "\n"
    t += 1
  end out = out.."Total: "..tostring(t).." commands."
  print(out)
end)

for _, user in next, total() do if user then connect_user(user) end end
plrs.PlayerAdded:Connect(function(t) if t then connect_user(t) end end)

return module, "v0.1"
