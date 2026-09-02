function srv(t) return game:GetService(t) end
function git(t) return game:HttpGet("https://raw.githubusercontent.com/" .. t) end
function chd(t) return t:GetChildren() end
function des(t) return t:GetDescendants() end
function tmc(t, m) return t.Text:lower():match(m) end
function spt(t) return t.Text:split(" ") end

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
  delay = 0.01, btns = {}, confuse_u = {
    shadows = true, l_trash = false
  }
}

if ui and type(ui) == "table" then
  function no_shadows()
    for _, ins in next, des(ws) do
      if ins and table.find(items.ignore, ins.ClassName) then
        ins.CastShadow = items.confuse_u.shadows
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
  items.btns.c_shadow = ui.add_button("Đổ bóng [Bật]", function()
    local btn = items.btns.c_shadow
    local txt = spt(btn)[1]..spt(btn)[2]
    if tmc(btn, "bật") then
      btn.Text = txt.." [Tắt]"
      items.confuse_u.shadows = false
    else
      btn.Text = txt.." [Bật]"
      items.confuse_u.shadows = true
    end no_shadows()
  end)

  items.btns.n_trash = ui.add_button("Xoá rác [Tắt]", function()
    local btn = items.btns.n_trash
    local txt = spt(btn)[1]..spt(btn)[2]
    if tmc(btn, "tắt") then
      btn.Text = txt.." [Bật]"
      items.confuse_u.l_trash = true
    else
      btn.Text = txt.." [Tắt]"
      items.confuse_u.l_trash = false
    end while items.confuse_u.l_trash do task.wait(items.delay)
      no_debris()
    end
  end)
end
