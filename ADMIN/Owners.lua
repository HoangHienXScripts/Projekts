-- Admin Protection --
local plrs, rs
plrs = game:GetService("Players")
rs = game:GetService("RunService")

local plr, cons, admins
plr = plrs.LocalPlayer
cons = {}
admins = ...

repeat task.wait() until admins and type(admins) == "function"
admins = admins.read("Admins").Names or {}

function model_pos(t) return t and t.Character and t.Character:GetBoundingBox().Position end
function rcv_hrp(t) return t and t.Character and t.Character:FindFirstChildOfClass("HumanoidRootPart") end
function rcv_nearby_plr()
  local t = {n = nil, m = math.huge}
  for _, usr in pairs(plrs:GetPlayers()) do
    if usr and usr ~= plr and rcv_hrp(usr) then
      local d = (model_pos(usr) - model_pos(plr)).magnitude
      if d <= t.m then t.m = d t.n = usr end
    end
  end return t.n
end

table.insert(cons, rs.RenderStepped:Connect(function()
  local hrp, near = rcv_hrp(plr), rcv_nearby_plr()
  if near and hrp then
    if table.find(admins, near.Name) and (model_pos(near) - model_pos(plr)).magnitude <= 25 then
      hrp.Anchored = true
    end
  end
end)) task.wait(1.25) if table.find(admins, plr.Name) then
  for idx = 1, #cons do
    local con = cons[idx]
    if con then cons[idx]:Disconnect()
      cons[idx] = nil
    end
  end
end print("[Admins Protection Loaded]")
