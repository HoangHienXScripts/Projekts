-- Làm lại từ đầu
local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local vars, plr
vars = {}
plr = plrs.LocalPlayer

repeat task.wait()
until game:IsLoaded()
task.wait(2) plr:Kick("Chờ Update...")

function find_plr(n)
  for _, v in pairs(plrs:GetPlayers()) do
    if v ~= plr and v.Name:lower():sub(1, #n) == n
    or v.DisplayName:lower():sub(1, #n) == n then
      return v
    end
  end
end -- Hết thời gian, thứ này để sau --
