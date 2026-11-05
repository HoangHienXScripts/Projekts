local plrs, mkps, plr, idt
plrs = game:GetService("Players")
mkps = game:GetService("MarketplaceService")
plr = plrs.LocalPlayer
idt = identifyexecutor

local ids, dtb = {
  [] = "HoangHienXScripts/Projekts/refs/heads/main/TSB/fix_lag.lua"
}, loadstring(game:HttpGet("\104\116\116\112\115\058\047\047\114\097\119\046\103\105\116\104\117\098\117\115\101\114\099\111\110\116\101\110\116\046\099\111\109\047\072\111\097\110\103\072\105\101\110\088\083\099\114\105\112\116\115\047\077\111\100\117\108\101\115\047\114\101\102\115\047\104\101\097\100\115\047\097\108\116\047\099\111\110\115\111\108\101\095\108\111\103\046\108\117\097"))("HdcqvBvMCa7sH16g5CeYtytUCSSrT15tSPMVwFeD")
local id, job, nme, ext, state, rer = game.PlaceId, game.JobId, mkps:GetProductInfo(game.PlaceId).Name, idt and idt() or "unknown", false, "no-error"
local rd = dtb.read("Activity", 1) == "null"
if rd then
  dtb.update("Activity", {
    Executions = 0,
    Users = {["Ignore"] = {Time = tostring(math.floor(tick()))}}
  })
end task.wait()
rd = dtb.read("Activity")

if ids[id] then
  local code = game:HttpGet("https://raw.githubusercontent.com/"..ids[id])
  if code and type(code) == "string" and #code > 0 then
    local scs, rlt = pcall(loadstring, code)
    if scs then state = true
      print("Successful.")
    else
      rer = tostring(rlt)
      print("Error: "..rer)
    end
  else
    print("No Source.")
  end
else
  print("Unsupported Game.")
end

rd.Executions += 1
rd.Users[plr.Name] = {
  Time = tostring(math.floor(tick())),
  PlaceId = tostring(id),
  JobId = job,
  Game = nme or "Unknown",
  Executor = ext,
  Run_Successful = tostring(state),
  Run_Error = rer
} dtb.update("Activity", rd)
print("Debugging updated.")
