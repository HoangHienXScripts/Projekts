### Spawn Character Model

```lua
  local t = "username_1"
  local a, b, c
  a, b = pcall(function()
    c = plrs:CreateHumanoidModelFromUserIdAsync(plrs:GetUserIdFromNameAsync(t)
  end) c.Name = t
  c.Parent = ws
  c.CFrame = CFrame.new(v3.own)
```
