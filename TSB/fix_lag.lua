local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local vars, plr
vars = {}
plr = plrs.LocalPlayer

function find_plr(n)
  for _, v in pairs(plrs:GetPlayers()) do
    if v ~= plr and v.Name:lower():sub(1, #n) == n then
      print(v.Name)
    end
  end
end

plr.Chatted:Connect(function(str)
  str = str:split(" ")
  if str[1] == "-find" then
    if str[2] then
      find_plr(str[2])
    end
  end
end)
