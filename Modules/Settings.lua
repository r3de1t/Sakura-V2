
local Settings = {}

Settings.Values = {
    Enabled = true,
    Theme = "Sakura",
    Notifications = true,
    Visuals = true,
    BallDetection = true,
    ParryEnabled = false,
    ParryStrength = 5
}

function Settings.Init(Sakura)
    print("[Sakura] Settings ready")
end

function Settings:Get(name)
    return self.Values[name]
end

function Settings:Set(name, value)
    if self.Values[name] == nil then
        warn("[Sakura] Unknown setting:", name)
        return
    end

    self.Values[name] = value
end

return Settings

