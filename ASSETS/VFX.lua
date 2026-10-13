-- vfx module --
local ws, plrs, dbrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
dbrs = game:GetService("Debris")

local plr, module, vars
plr = plrs.LocalPlayer
module = {}
vars = {}

function inst(n, p) return Instance.new(n, p) end
function fc(t, n) return t:FindFirstChild(n) end
function v3(...) return Vector3.new(...) end
function tof(t) return typeof(t):lower() end
function crt_fol(t, n) if not fc(t, n) then return inst(n, t) end end

vars.mainf = crt_fol(ws, "HHxScripts")
vars.vfx_f = crt_fol(vars.mainf, "VFXs")
vars.vfx_d = crt_fol(vars.vfx_f, "HG")

if vars.vfx_d then
  vars.part = inst("Part", vars.vfx_d)
  local x = vars.part
  x.Name = "TestPoint"
  x.Anchored = true
  x.Transparency = 1
  x.CanCollide = false
  x.Size = v3(0.5, 0.5, 0.5)
  x.Position = v3(0, 9e6, 0)
end

function module.basic_fire(t, existance_time)
  if t and tof(t) == "vector3" then
    if vars.part then
      local x, z = vars.part:Clone()
      x.Parent = vars.part.Parent
      x.Position = t
      z = inst("Fire", x)
      dbrs:AddItem(z, existance_time or 0.2)
    end
  end
end

return module
