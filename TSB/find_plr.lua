local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local plr
plr = plrs.LocalPlayer

function total() return plrs:GetPlayers() end
function rp(t, n) return t and t.Character and t.Character:FindFirstChild("Humanoid"..n) end
function pos(t) return t and t.Character and t.Character:GetBoundingBox().Position end
function hp(t, g, a)
  local x = t and rp(t, "")
  if x and x.Health then
    if g == 0 then x = x.Health < a
    elseif g == 1 then x = x.Health > a
    end
  end return x
end

function find_plr()
  local t = {n = nil, m = math.huge}
  for _, x in pairs(total()) do
    if x and x ~= plr and rp(x, "RootPart") then
      local d = (pos(x) - pos(plr)).magnitude
      if d < t.m and hp(x, 1, 0) then
        if hp(x, 0, 30) and hp(x, 1, 0) then
          t.m = d t.n = x
        else
          t.m = d t.n = x
        end
      end
    end
  end if t.n then return t.n else
    local dum = ws.Live:FindFirstChild("Weakest Dummy")
    if dum then return dum end
  end
end

return find_plr
