-- 创建一个ScreenGui来存放UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnnouncementGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 创建主容器
local mainFrame = Instance.new("Frame")
mainFrame.Name = "AnnouncementFrame"
mainFrame.Size = UDim2.new(0.9, 0, 0.8, 0) -- 增加高度以适应长列表
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.AnchorPoint = Vector2.new(0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 64)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = ScreenGui

-- 创建圆角效果
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = mainFrame

-- 创建标题栏
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(255, 126, 0)
header.BorderSizePixel = 0
header.Parent = mainFrame

-- 标题栏圆角（只对顶部）
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- 添加标题文本
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0.5, -100, 0.5, -15)
title.BackgroundTransparency = 1
title.Text = "king支持游戏列表"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = header

-- 左上角文字
local cornerLeft = Instance.new("TextLabel")
cornerLeft.Name = "CornerLeft"
cornerLeft.Size = UDim2.new(0, 60, 0, 20)
cornerLeft.Position = UDim2.new(0, 10, 0, 5)
cornerLeft.BackgroundTransparency = 1
cornerLeft.Text = "XG制作"
cornerLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
cornerLeft.Font = Enum.Font.SourceSansBold
cornerLeft.TextSize = 12
cornerLeft.TextXAlignment = Enum.TextXAlignment.Left
cornerLeft.Parent = header

-- 右上角文字
local cornerRight = Instance.new("TextLabel")
cornerRight.Name = "CornerRight"
cornerRight.Size = UDim2.new(0, 80, 0, 20)
cornerRight.Position = UDim2.new(1, -90, 0, 5)
cornerRight.BackgroundTransparency = 1
cornerRight.Text = "XG脚本整合"
cornerRight.TextColor3 = Color3.fromRGB(255, 255, 255)
cornerRight.Font = Enum.Font.SourceSansBold
cornerRight.TextSize = 12
cornerRight.TextXAlignment = Enum.TextXAlignment.Right
cornerRight.Parent = header

-- 创建顶部提示文本
local topNote = Instance.new("TextLabel")
topNote.Name = "TopNote"
topNote.Size = UDim2.new(1, -20, 0, 40)
topNote.Position = UDim2.new(0, 10, 0, 55)
topNote.BackgroundTransparency = 1
topNote.Text = "记得加群组才能执行哦\n支持游戏:"
topNote.TextColor3 = Color3.fromRGB(225, 225, 225)
topNote.Font = Enum.Font.SourceSansBold
topNote.TextSize = 18
topNote.TextWrapped = true
topNote.TextXAlignment = Enum.TextXAlignment.Left
topNote.Parent = mainFrame

-- 创建内容滚动区域
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ContentScroll"
scrollFrame.Size = UDim2.new(1, -20, 1, -160)
scrollFrame.Position = UDim2.new(0, 10, 0, 100)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 126, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- 初始大小，会根据内容调整
scrollFrame.Parent = mainFrame

-- 创建游戏列表容器
local gameListLayout = Instance.new("UIListLayout")
gameListLayout.Padding = UDim.new(0, 5)
gameListLayout.Parent = scrollFrame

-- 创建支持的游戏列表
local supportedGames = {
    "1.力量传奇",
    "2.忍者传奇",
    "3.极速传奇",
    "4.奇怪枪游戏{国内第一个出的}",
    "5.殖民地生存",
    "6.Planks",
    "7.战地大亨",
    "8.像素之刃(PixelBlade [Early Access])",
    "9.蓝色锁:对手(Blue Lock: Rivals)",
    "10.一路向西",
    "11.墨水游戏(勘探中Ink game){国内第一个出的}",
    "12.Ohio <俄亥俄州>",
    "13.房屋大亨(House Tycoon)",
    "14.进击的僵尸",
    "15.终极采矿大亨",
    "16.奴才必须死(NoobsMustDie [Alpha])",
    "17.破门而入2-故事(Break In 2 [story])",
    "18.鱼的训练",
    "19.隐藏或死亡",
    "20.刀片和buffoonery",
    "21.元素力量大亨",
    "22.能量突击",
    "23.感染力微笑<感染的微笑>",
    "24.The Rake重置版",
    "25.nico的下一个机器人",
    "26.逃避(Evade)",
    "27.柱子追逐",
    "28.破坏者谜团2",
    "29.挖掘地球核心",
    "30.动漫传奇[AnimeSaga]",
    "31.Blox Fruits",
    "32.建造一座岛屿(Build An Island)",
    "33.泡泡糖模拟器无限",
    "34.僵尸游戏[更新3]",
    "35.无限旅馆",
    "36.Rope Battle",
    "37.无标题钻机游戏(Untitled Drill Game)",
    "38.合并 BRAINROTB (Merge Brainrot)",
    "39.竞争对手(RIVALS)",
    "40.3008『透视』",
    "41.矿井(Mines)",
    "42.七天生存(7 days to live)",
    "43.掠夺(Lootify){国内第一个出的}",
    "44.挖出后院(Dig the backyard)",
    "45.森林中的99夜(99 Nights in the forest)",
    "46.动漫崛起(Anime Rising)",
    "47.兵工厂(Arsenal)",
    "48.枪战FFA",
    "49.吃吃世界(eat the world)",
    "50.动漫王国模拟器(Anime Kingdom Simulator)",
    "51.挖掘(DIG)",
    "52.速度越狱(prison speed escape)",
    "53.2 Player Brainrot Tycoon <没有中文名>",
    "54.在森林里偷99夜(Steal 99 Nights In The Forest)",
    "55.建造一个堡垒以生存僵尸大亨(Build A Bunker To Survive Zombies Tycoon)",
    "56.男孩可爱发型奥此(Cute Hair Obby for Boys [UGC HAIR])",
    "57.死铁轨",
    "58.在超级超市过夜生存",
    "59.刀刃球",
    "60.汽车经销大亨(EVENT-Car-Dealership-Tycoon)",
    "61.偷走一条鱼(Steal a fish)",
    "62.排球传奇",
    "63.偷走一把剑(Steal a sword)",
    "64.战斗竞技场",
    "65.枪战竞技场",
    "66.忍者传奇2",
    "67.Prospecting<勘探中!>『国内第一个制作』",
    "68.门(Doors)",
    "69.地牢英雄(Dungeon Quest)",
    "70.杀手Vs警长"
}

-- 创建游戏列表项
local totalHeight = 0
for i, gameName in ipairs(supportedGames) do
    local gameItem = Instance.new("TextLabel")
    gameItem.Name = "GameItem_" .. i
    gameItem.Size = UDim2.new(1, 0, 0, 20)
    gameItem.BackgroundTransparency = 1
    gameItem.Text = gameName
    gameItem.TextColor3 = Color3.fromRGB(225, 225, 225)
    gameItem.Font = Enum.Font.SourceSans
    gameItem.TextSize = 16
    gameItem.TextWrapped = true
    gameItem.TextXAlignment = Enum.TextXAlignment.Left
    gameItem.AutomaticSize = Enum.AutomaticSize.Y -- 自动调整高度
    gameItem.Parent = scrollFrame
    
    -- 更新总高度
    gameItem:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        totalHeight = 0
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                totalHeight = totalHeight + child.AbsoluteSize.Y + 5
            end
        end
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 10)
    end)
end

-- 创建确定按钮
local confirmButton = Instance.new("TextButton")
confirmButton.Name = "ConfirmButton"
confirmButton.Size = UDim2.new(0.6, 0, 0, 40)
confirmButton.Position = UDim2.new(0.2, 0, 1, -50)
confirmButton.BackgroundColor3 = Color3.fromRGB(255, 126, 0)
confirmButton.BorderSizePixel = 0
confirmButton.Text = "确定"
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.TextSize = 18
confirmButton.Parent = mainFrame

-- 按钮圆角
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = confirmButton

-- 按钮点击事件
confirmButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false -- 直接禁用整个ScreenGui
end)

-- 添加滚动提示
local scrollHint = Instance.new("TextLabel")
scrollHint.Name = "ScrollHint"
scrollHint.Size = UDim2.new(1, -20, 0, 20)
scrollHint.Position = UDim2.new(0, 10, 1, -80)
scrollHint.BackgroundTransparency = 1
scrollHint.Text = "↑ 滑动查看所有支持游戏 ↑"
scrollHint.TextColor3 = Color3.fromRGB(200, 200, 200)
scrollHint.Font = Enum.Font.SourceSans
scrollHint.TextSize = 14
scrollHint.TextXAlignment = Enum.TextXAlignment.Center
scrollHint.Parent = mainFrame

-- 确保UI在移动设备上正确显示
if game:GetService("UserInputService").TouchEnabled then
    -- 调整按钮大小以便于触摸
    confirmButton.Size = UDim2.new(0.7, 0, 0, 50)
    confirmButton.Position = UDim2.new(0.15, 0, 1, -60)
    confirmButton.TextSize = 20
    
    -- 调整内容字体大小
    topNote.TextSize = 20
    scrollHint.TextSize = 16
end

-- 添加淡入动画
mainFrame.BackgroundTransparency = 1
header.BackgroundTransparency = 1
confirmButton.BackgroundTransparency = 1

local tweenService = game:GetService("TweenService")
local fadeIn = tweenService:Create(
    mainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)
local headerFadeIn = tweenService:Create(
    header,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)
local buttonFadeIn = tweenService:Create(
    confirmButton,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
)

-- 延迟一点时间再显示动画，确保UI已加载
wait(0.1)
fadeIn:Play()
headerFadeIn:Play()
buttonFadeIn:Play()

print("XG脚本支持游戏列表UI已加载完成！共支持 " .. #supportedGames .. " 款游戏")
