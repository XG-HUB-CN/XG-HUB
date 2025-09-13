-- 创建一个ScreenGui来存放UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnnouncementGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 创建主容器
local mainFrame = Instance.new("Frame")
mainFrame.Name = "AnnouncementFrame"
mainFrame.Size = UDim2.new(0.8, 0, 0.7, 0) -- 使用相对尺寸
mainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
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
title.Size = UDim2.new(0, 100, 0, 30)
title.Position = UDim2.new(0.5, -50, 0.5, -15)
title.BackgroundTransparency = 1
title.Text = "king执行忠告"
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

-- 创建内容滚动区域
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ContentScroll"
scrollFrame.Size = UDim2.new(1, -20, 1, -120)
scrollFrame.Position = UDim2.new(0, 10, 0, 60)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 126, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- 初始大小，会根据内容调整
scrollFrame.Parent = mainFrame

-- 创建内容文本
local contentText = Instance.new("TextLabel")
contentText.Name = "ContentText"
contentText.Size = UDim2.new(1, 0, 0, 0)
contentText.Position = UDim2.new(0, 0, 0, 0)
contentText.BackgroundTransparency = 1
contentText.Text = "欢迎使用XG脚本整合！\n\n感谢您选择我们的服务，以下是重要公告内容：\n• 服务器将于本周六进行维护\n• 新增了5个独家小游戏场景\n• 优化了脚本执行效率\n• 修复了已知的3个主要bug\n• 增加了新的玩家互动功能\n\n请注意遵守游戏规则，文明游戏，共同营造良好的游戏环境。任何作弊行为都将受到处罚。\n\n如有任何问题，请联系客服支持。感谢您的理解与支持！\n\n更多更新内容请关注我们的官方频道，我们将持续为您带来优质的游戏体验。"
contentText.TextColor3 = Color3.fromRGB(225, 225, 225)
contentText.Font = Enum.Font.SourceSans
contentText.TextSize = 18
contentText.TextWrapped = true
contentText.TextXAlignment = Enum.TextXAlignment.Left
contentText.TextYAlignment = Enum.TextYAlignment.Top
contentText.AutomaticSize = Enum.AutomaticSize.Y -- 自动调整高度
contentText.Parent = scrollFrame

-- 更新滚动区域大小以适应内容
contentText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentText.AbsoluteSize.Y + 20)
end)

-- 创建确定按钮
local confirmButton = Instance.new("TextButton")
confirmButton.Name = "ConfirmButton"
confirmButton.Size = UDim2.new(0.5, 0, 0, 40)
confirmButton.Position = UDim2.new(0.25, 0, 1, -50)
confirmButton.BackgroundColor3 = Color3.fromRGB(255, 126, 0)
confirmButton.BorderSizePixel = 0
confirmButton.Text = "好的呢～"
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.TextSize = 18
confirmButton.Parent = mainFrame

-- 按钮圆角
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = confirmButton

-- 按钮点击事件 - 修复了可能的nil值错误
confirmButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false -- 直接禁用整个ScreenGui
end)

-- 确保UI在移动设备上正确显示
if game:GetService("UserInputService").TouchEnabled then
    -- 调整按钮大小以便于触摸
    confirmButton.Size = UDim2.new(0.7, 0, 0, 50)
    confirmButton.Position = UDim2.new(0.15, 0, 1, -60)
    confirmButton.TextSize = 20
    
    -- 调整内容字体大小
    contentText.TextSize = 20
end

print("king忠告UI已加载完成！")
