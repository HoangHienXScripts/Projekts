function srv(t) return game:GetService(t) end
function git(t) return game:HttpGet("https://raw.githubusercontent.com/" .. t) end
function chd(t) return t:GetChildren() end
function des(t) return t:GetDescendants() end

local ws, plrs, reps, bulb
ws = srv"Workspace"
plrs = srv"Players"
reps = srv"ReplicatedStorage"
bulb = srv"Lighting"

local plr, token, ui, items
plr = plrs.LocalPlayer
token = git("HoangHienXScripts/Projekts/refs/heads/main/TSB/token") or ""
ui = loadstring(git("HoangHienXScripts/Shieru/refs/heads/main/MODULES/Items_List.lua?token=" .. token))()
items = {
  ignore = {"Part", "MeshPart", "WedgePart"},
  delay = 0.01
}

if ui and type(ui) == "table" then
  function no_shadows(t)
    for _, ins in next, des(ws) do
      if ins and table.find(items.ignore, ins.ClassName) then
        ins.CastShadow = t
        task.wait(items.delay)
      end
    end
  end function no_debris()
    local trash = ws:FindFirstChild"Thrown"
    if trash and #chd(trash) > 0 then
      for _, ins in next, chd(trash) do
        if ins then
          ins:Destroy()
          task.wait(items.delay)
        end
      end
    end
  end
  -- create ui --
  ui.add_button("Đổ bóng")
end
