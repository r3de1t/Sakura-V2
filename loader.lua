
local Sakura = {}

Sakura.Version = "2.0.0"
Sakura.Modules = {}
Sakura.Loaded = {}

local ModulesFolder = script.Parent:WaitForChild("Modules")

local ModuleOrder = {
    "Settings",
    "Notifications",
    "SakuraUI",
    "BallDetection",
    "AutoParry",
    "Visuals"
}

function Sakura:LoadModules()
    for _, name in ipairs(ModuleOrder) do
        local moduleScript = ModulesFolder:FindFirstChild(name)

        if not moduleScript then
            warn("[Sakura] Missing module:", name)
            continue
        end

        local ok, result = pcall(require, moduleScript)

        if not ok or type(result) ~= "table" then
            warn("[Sakura] Failed:", name, result)
            continue
        end

        self.Modules[name] = result

        if type(result.Init) == "function" then
            local initialized, err = pcall(result.Init, self)

            if not initialized then
                warn("[Sakura] Init failed:", name, err)
                self.Modules[name] = nil
                continue
            end
        end

        self.Loaded[name] = true
        print("[Sakura] Loaded:", name)
    end

    print("[Sakura] Sakura V2.0 ready")
end

return Sakura

