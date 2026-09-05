-- Làm lại từ đầu
local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local vars, plr
vars = {
  expire = game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Projekts/refs/heads/main/TSB/time")
}
plr = plrs.LocalPlayer

function _ft(s)
	local d = math.floor(s / 86400)
	local h = math.floor((s % 86400) / 3600)
	local m = math.floor((s % 3600) / 60)
	s = math.floor(s % 60) return string.format("%02d:%02d:%02d:%02d", d, h, m, s)
end

function find_plr(n)
  for _, v in pairs(plrs:GetPlayers()) do
    if v ~= plr and v.Name:lower():sub(1, #n) == n
    or v.DisplayName:lower():sub(1, #n) == n then
      return v
    end
  end
end

repeat task.wait()
until game:IsLoaded() and vars.expire and type(vars.expire) == "string"
task.wait(2) plr:Kick("Updating, plz waitt... \nTime left: ".._ft(tonumber(vars.expire) - tick()))
-- Hết thời gian, thứ này để sau --
