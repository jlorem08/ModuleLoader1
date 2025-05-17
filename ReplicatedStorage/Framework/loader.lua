--// Services
local RunService = game:GetService("RunService")

--// Module
local ModuleLoader = {}

--// Constants
local framework: Folder = script.Parent
local services: Folder = framework.Services

local serverServices: Folder = services.Server
local clientServices: Folder = services.Client
local globalServices: Folder = services.Global
local utilServices: Folder = services.Util

--// Variables
local loadedServices = {}

--// Functions
local function runInit(service: ModuleScript)
    local serviceInCache = loadedServices[service.Name]

    if serviceInCache then
        if serviceInCache._initialized then
            return
        end

        if serviceInCache["Init"] then
            local success, result = pcall(function()
                serviceInCache:Init()
            end)    

            if success then
                print("[LOADER]: Successfully initialized " .. service.Name .. ".")
                serviceInCache._initialized = true
            else
                warn("[LOADER]: Error running initializer in " .. service.Name .. ". Return value is required.")
            end
        end
    end
end

local function cacheEnv(environment: Folder)
    for i, service: ModuleScript in ipairs(environment:GetChildren()) do
        if not service:IsA("ModuleScript") then continue end

        if loadedServices[service.Name] then
            warn("[LOADER]: Duplicate service detected: " .. service.Name .. " in environment " .. environment.Name .. ".")
        end

        local success, err = pcall(function()
            loadedServices[service.Name] = require(service)
        end)

        if success then
            print("[LOADER]: " .. service.Name .. " successfully loaded in environment " .. environment.Name .. ".")
            runInit(service)
        else
            warn("[LOADER]: There was an issue loading " .. service.Name .. " in environment " .. environment.Name .. ".")
        end
    end
end

--// Methods
function ModuleLoader:Load()
    local onServer = RunService:IsServer()

    if onServer then
        cacheEnv(serverServices)
    else
        cacheEnv(clientServices)
    end

    cacheEnv(globalServices)
    cacheEnv(utilServices)
end

function ModuleLoader:Get(serviceName: string)
    local serviceInCache = loadedServices[serviceName]

    if serviceInCache then
        return serviceInCache
    else
        warn("[LOADER]: There was an issue getting service " .. serviceName .. ".")
    end

    return nil
end

function ModuleLoader:ReloadService(serviceName: string, forceInit: boolean)
    local isServer = RunService:IsServer()

    if isServer then
        if serverServices:FindFirstChild(serviceName) then
            local service = serverServices:FindFirstChild(serviceName)
            loadedServices[service.Name] = require(service)

            print("[LOADER]: " .. service.Name .. " successfully loaded in environment " .. "Server" .. ".")

            if forceInit then
                loadedServices[service.Name]._initialized = nil
            end

            runInit(service)
            return
        end
    else
        if clientServices:FindFirstChild(serviceName) then
            local service = clientServices:FindFirstChild(serviceName)
            loadedServices[service.Name] = require(service)

            print("[LOADER]: " .. service.Name .. " successfully loaded in environment " .. "Client" .. ".")

            if forceInit then
                loadedServices[service.Name]._initialized = nil
            end

            runInit(service)
            return
        end
    end

    if globalServices:FindFirstChild(serviceName) then
        local service = globalServices:FindFirstChild(serviceName)
        loadedServices[service.Name] = require(service)

        print("[LOADER]: " .. service.Name .. " successfully loaded in environment " .. "Global" .. ".")

        if forceInit then
            loadedServices[service.Name]._initialized = nil
        end

        runInit(service)
        return
    else
        return
    end
end

function ModuleLoader:GetServices()
    return loadedServices
end

--// Closing
return ModuleLoader