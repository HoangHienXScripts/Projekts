function srv(t) return game:GetService(t) end
function git(t) return game:HttpGet("https://raw.githubusercontent.com/" .. t) end
function chd(t) return t:GetChildren() end
function des(t) return t:GetDescendants() end
function tmc(t, m) return t.Text:lower():match(m) end
function spt(t) return t.Text:split(" ") end

local ws, plrs, reps, bulb, statr, tps, rs
ws = srv"Workspace"
plrs = srv"Players"
reps = srv"ReplicatedStorage"
bulb = srv"Lighting"
statr = srv"StarterGui"
tps = srv"TeleportService"
rs = srv"RunService"

local plr, id, job, token, ui, items
plr = plrs.LocalPlayer
id = game.PlaceId
job = game.JobId
token = git("HoangHienXScripts/Projekts/refs/heads/main/TSB/token") or "0"
ui = loadstring(git("HoangHienXScripts/Modules/refs/heads/main/btns_list.lua"))()
items = {
  ignore = {"Part", "MeshPart", "WedgePart"},
  delay = 0.01, btns = {}, confuse_u = {
    shadows = true, l_trash = false, d_call = 5
  }, version = token, call = false
}

if ui and type(ui) == "table" then
  function ntf(m)
    statr:SetCore("SendNotification", {Title = "HHxScripts", Text = m, Duration = 1.25})
  end function no_shadows()
    local ins_f = 0
    for _, ins in next, des(ws) do
      if ins and table.find(items.ignore, ins.ClassName) then
        ins.CastShadow = items.confuse_u.shadows
        ins_f += 1 task.wait(items.delay)
      end
    end ntf("Đã hủy hiệu ứng đổ bóng cho "..tostring(ins_f).." vật thể.")
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
  ui.add_button("Loại bỏ cây cối...", function()
    local trs = ws.Map:FindFirstChild"Trees"
    if trs then trs:ClearAllChildren() ntf("Đã xoá hết tất cả cây cối có... \n trên bản đồ.") end
  end)
  
  items.btns.c_shadow = ui.add_button("Đổ bóng [Bật]", function()
    local btn = items.btns.c_shadow
    if tmc(btn, "bật") then
      btn.Text = "Đổ bóng [Tắt]"
      items.confuse_u.shadows = false
    else
      btn.Text = "Đổ bóng [Bật]"
      items.confuse_u.shadows = true
    end no_shadows()
  end)

  items.btns.n_trash = ui.add_button("Xoá rác [Tắt]", function()
    local btn = items.btns.n_trash
    if tmc(btn, "tắt") then
      btn.Text = "Xoá rác [Bật]"
      items.confuse_u.l_trash = true
    else
      btn.Text = "Xoá rác [Tắt]"
      items.confuse_u.l_trash = false
    end while items.confuse_u.l_trash do task.wait(items.delay)
      no_debris()
    end
  end)

  rs.RenderStepped:Connect(function()
    if not items.call then items.call = true
      token = git("HoangHienXScripts/Projekts/refs/heads/main/TSB/token") or "0"
      if tonumber(items.version) < tonumber(token) then
        local ss, err = pcall(function() tps:TeleportToPlaceInstance(id, job, plr) end)
        if ss then ntf("Đang update script...") else ntf("Lỗi " .. err) end
      end task.wait(items.confuse_u.d_call)
      items.call = false
    end
  end)
end
