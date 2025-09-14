local LS = {
    getorb = false,
    area = "City",
    mainexe = false,
    hoop = false,
    opencrystal = false,
    petshop = false,
    evolvepet = false,
    birth = 9e9,
    autobirth = false,
}

local CoreGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local crystalshow = {}
local OpenCrystal = ""

for i, crystal in pairs(game:GetService("Workspace").mapCrystalsFolder:GetChildren()) do
    crystalshow[i] = crystal.Name
end

local Maps = {}
local Races = ""

for i, Map in pairs(game:GetService("Workspace").raceMaps:GetChildren()) do
    Maps[i] = Map.Name
end

local petshow = {}
local BuyPetShop = ""
local EvolvePet = ""

for i, pet in pairs(game:GetService("ReplicatedStorage").cPetShopFolder:GetChildren()) do
    petshow[i] = pet.Name
end

local speeds = 5
local nowe = false
local tpwalking = false
local speaker = game:GetService("Players").LocalPlayer
local heartbeat = game:GetService("RunService").Heartbeat

local function updatespeed(char, hum)
	if nowe == true then
		tpwalking = false
		heartbeat:Wait()
		task.wait(.1)
		heartbeat:Wait()

		for i = 1, speeds do
			spawn(function()
				tpwalking = true

				while tpwalking and heartbeat:Wait() and char and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						char:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
	end
end

speaker.CharacterAdded:Connect(function(char)
	local char = speaker.Character
	if char then
		task.wait(0.7)
		char.Humanoid.PlatformStand = false
		char.Animate.Disabled = false
	end
end)

local tpwalkingspeed = false
local RunService = game:GetService("RunService")
local hb = RunService.Heartbeat
local speed = 1
local brightLoop = nil
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LENG8123/UI/refs/heads/main/%E5%86%B7library.lua"))()

local window = library:new("XG脚本")

local Page = window:Tab("主要功能",'16060333448')
local Main = Page:section("主要",true)
local Orb = Page:section("球",true)

local Page2 = window:Tab("其他",'16060333448')
local Crystal = Page2:section("水晶",true)
local PetShop = Page2:section("商店",true)
local Evolve = Page2:section("进化",true)

local Page3 = window:Tab("刷重生",'16060333448')
local Birth = Page3:section("重生",true)

local Page4 = window:Tab("传送",'16060333448')
local Leng = Page4:section("传送",true)

local Page5 = window:Tab("修改",'16060333448')
local LBTCS = Page5:section("修改",true)

local Page6 = window:Tab("自动",'16060333448')
local YUN = Page6:section("自动",true)

Main:Button("点击即可时间循环中午",function()
    if brightLoop then
        brightLoop:Disconnect() 
    end
    local function brightFunc()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end


    brightLoop = RunService.RenderStepped:Connect(brightFunc)
end)

Main:Label("输入的数字越大效果越明显")

Main:Textbox("漂移加速", "", "输入数字", function(Value)
    if tonumber(Value) then
        speed = tonumber(Value)
        tpwalkingspeed = true
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
        
        if humanoid then
            RunService:UnbindFromRenderStep("TPWalk")

            RunService:BindToRenderStep("TPWalk", Enum.RenderPriority.Character.Value, function(delta)
                if tpwalkingspeed and character and humanoid and humanoid.Parent then
                    if humanoid.MoveDirection.Magnitude > 0 then
                        character:TranslateBy(humanoid.MoveDirection * speed * delta * 10)
                    end
                end
            end)
        end
    else
        print("Invalid input. Please enter a number.")
    end
end)

Main:Button("点击即可漂移加速关闭",function()
    tpwalkingspeed = false
    RunService:UnbindFromRenderStep("TPWalk")
end)

Main:Toggle("自动重生", "birth", false, function(birth)
    LS.mainexe = birth
    if LS.mainexe then
        while LS.mainexe do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            wait()
        end
    end
end)

Main:Button("获得所有宝箱", function()
    for _, v in pairs(game.ReplicatedStorage.chestRewards:GetChildren()) do
        game.ReplicatedStorage.rEvents.checkChestRemote:InvokeServer(v.Name)
    end
end)

Main:Dropdown("比赛终点传送", "Select Region", Maps, function(Value)
    Races = Value
end)

Main:Button("点击传送",function()
game.Players.LocalPlayer.Character.HumanoidRootPart = game.workspace.raceMaps[selectedMap].finishPart.CFrame
end)

Main:Toggle("自动参赛", "joinRace", false, function(joinrace)
    LS.mainexe = joinrace
    if LS.mainexe then
        if game.PlaceId == 3101667897 then
            while LS.mainexe do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Grassland.finishPart.CFrame
                task.wait(0.1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Magma.finishPart.CFrame
                task.wait(0.1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Desert.finishPart.CFrame
                task.wait(0.3)
            end
        elseif game.PlaceId == 3276265788 then
            while LS.mainexe do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Speedway.finishPart.CFrame
                task.wait(0.2)
            end
        elseif game.PlaceId == 3232996272 then
            while LS.mainexe do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.raceMaps.Starway.finishPart.CFrame
                task.wait(0.2)
            end
        end
    end
end)


Main:Toggle("吸全部环", "hoops", false, function(hoops)
    LS.hoop = hoops
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
        while LS.hoop do
            for i, hoops in ipairs(workspace.Hoops:GetChildren()) do
                if hoops.Name == "Hoop" then
                hoops.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait()
                end
            end
        end
    end
end)

Orb:Dropdown("选择地区", "Select Region", {"City","Snow City","Magma City","Desert","Space", "Legends Highway"}, function(Value)
    LS.area = Value
end)

Orb:Label("请先选择地区 | 否则获得球的地点将默认为City(部分城市可能没有球所以不是无效)")

Orb:Toggle("红球 x50", "collectOrb", false, function(orb)
    LS.getorb = orb
        while LS.getorb do
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", LS.area)
            wait()
      end
end)

Orb:Toggle("蓝球 x50", "collectOrb", false, function(orb)
    LS.getorb = orb
        while LS.getorb do
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", LS.area)
            wait()
      end
end)

Orb:Toggle("橙球 x50", "collectOrb", false, function(orb)
    LS.getorb = orb
        while LS.getorb do
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", LS.area)
      end
end)

Orb:Toggle("黄球 x50", "collectOrb", false, function(orb)
    LS.getorb = orb
        while LS.getorb do
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", LS.area)
            wait()
      end
end)

Orb:Toggle("宝石球 x50", "collectOrb", false, function(orb)
    LS.getorb = orb
        while LS.getorb do
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            game.ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Gem", LS.area)
            wait()
      end
end)

Crystal:Dropdown("选择水晶", "Choose Crystal", crystalshow, function(Value)
    OpenCrystal = Value
end)

Crystal:Button("购买水晶", function()
game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
end)

Crystal:Toggle("自动购买", "Auto Buy Crystal", false, function(autobuy)
    LS.opencrystal = autobuy
    if LS.opencrystal then
        while LS.opencrystal do
            game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", OpenCrystal)
            wait()
        end
    end
end)

PetShop:Dropdown("选择购买的宠物", "Choose Pet", petshow, function(Value)
    BuyPetShop = Value
end)

PetShop:Button("购买", function()
    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
end)

PetShop:Toggle("自动购买", "Auto buy", false, function(state)
    if LS.petshop then
        while LS.petshop do
            game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild(BuyPetShop))
            wait()
        end
    end
end)

Evolve:Dropdown("选择进化的宠物", "Choose Pet", petshow, function(Value)
    EvolvePet = Value
end)

Evolve:Button("进化", function()
    game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", EvolvePet)
end)

Evolve:Toggle("自动进化", "Auto Evolve", false, function(state)
    if LS.evolvepet then
        while LS.evolvepet do
            game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", EvolvePet)
            wait()
        end
    end
end)

Birth:Textbox("自定义重生次数","Birth number","By LS", false, function(value)
    LS.birth = value
end)

Birth:Toggle("重生到指定的重生次数","LS", false, function(state)
    if game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value >= LS.birth then
    game.Players.LocalPlayer:Kick("已自动重生到"..LS.birth"，已自动为你踢出")
else
    LS.autobirth = state
    if LS.autobirth then
        while LS.autobirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            wait()
        end
     end
end
end)

Leng:Button("城市",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2002.0133056640625, 1.2624330520629883, 985.2265625)
        end)

Leng:Button("洞穴",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9683.048828125, 59.306854248046875, 3136.626953125)
        end)
        
        Leng:Button("雪城",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9675.25, 59.63568115234375, 3783.50146484375)
        end)

        Leng:Button("火山",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11052.4189453125, 217.59571838378906, 4898.76416015625)
        end)

        Leng:Button("公路",function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13095.255859375, 217.59567260742188, 5905.240234375)
        end)
        
LBTCS:Textbox("修改经验值", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.exp.Value=arg
end)

LBTCS:Textbox("修改等级", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.level
.Value=arg
end)

LBTCS:Textbox("修改比赛数", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.leaderstats.Races.Value=arg
end)

LBTCS:Textbox("修改圈数", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value=arg
end)

LBTCS:Textbox("修改重生", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value=arg
end)

LBTCS:Textbox("修改步数", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.leaderstats.Steps.Value=arg
end)

LBTCS:Textbox("修改尾迹容量", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.maxPetCapacity.Value=arg
end)

LBTCS:Textbox("修改宠物位数量", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.maxPetCapacity.Value=arg
end)

LBTCS:Textbox("修改宝石数量", "arg", "输入",function(arg)
game:GetService("Players").LocalPlayer.Gems.Value=arg
end)

YUN:Toggle("自动设置最大速度", "SD", false, function(SD)
    if SD then while true do game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeSpeed,math.huge")
 wait() end end
end)

YUN:Toggle("自动设置最大跳跃", "TY", false, function(TY)
    if TY then while true do game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeJump,math.huge")
 wait() end end
end)

YUN:Toggle("自动刷经验", "TD", false, function(TD)
    if TD then
     wait(0)
        while TD do
        local args = {
    [1] = "collectOrb",
    [2] = "Blue Orb",
    [3] = "City"
}

game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait(0)
     
        end
    end
end)

YUN:Toggle("自动刷步数", "TD", false, function(TD)
    if TD then
     wait(0)
        while TD do
        local args = {
    [1] = "collectOrb",
    [2] = "Orange Orb",
    [3] = "City"
}

game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait(0)
     
        end
    end
end)

YUN:Toggle("自动刷宝石", "TD", false, function(TD)
    if TD then
     wait(0)
        while TD do
       local args = {
    [1] = "collectOrb",
    [2] = "Gem",
    [3] = "City"
}

game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
  wait(0)
     
        end
    end
end)