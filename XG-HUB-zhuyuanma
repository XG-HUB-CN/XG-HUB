-- 服务引用与基础配置（手机端优先适配）
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TouchInputService = game:GetService("TouchInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XG_Script_UI"
ScreenGui.Parent = Players.LocalPlayer.PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 手机端专属配置
local PhoneConfig = {
    MainSize = UDim2.new(0.9, 0, 0.75, 0),
    MainPos = UDim2.new(0.05, 0, 0.12, 0),
    MinBtnSize = UDim2.new(0, 120, 0, 50),
    CategoryBtnHeight = 0.28,
    PressScale = 0.96,
    PressTransparency = 0.4,
    DragTipHeight = 12,
    ScaleOptions = {0.9, 1.0, 1.1},
    CurrentScale = 1.0
}

-- 主UI容器
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = PhoneConfig.MainSize
MainFrame.Position = PhoneConfig.MainPos
MainFrame.BackgroundTransparency = 0.65
MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
MainFrame.CornerRadius = UDim.new(0, 20)
MainFrame.Visible = true
MainFrame.ClipsDescendants = true
local MainBlur = Instance.new("UIGaussianBlurEffect")
MainBlur.Name = "MainBackgroundBlur"
MainBlur.Radius = 8
MainBlur.Parent = MainFrame

-- 顶部分割条
local TopDivider = Instance.new("Frame")
TopDivider.Name = "TopDivider"
TopDivider.Size = UDim2.new(1, 0, 0.12, 0)
TopDivider.Position = UDim2.new(0, 0, 0, 0)
TopDivider.BackgroundColor3 = Color3.new(1, 1, 1)
TopDivider.BackgroundTransparency = 0.6
TopDivider.CornerRadius = UDim.new(0, 20, 0, 0)
TopDivider.Parent = MainFrame

-- 拖动提示条（含图标）
local DragTipBar = Instance.new("Frame")
DragTipBar.Name = "DragTipBar"
DragTipBar.Size = UDim2.new(1, 0, PhoneConfig.DragTipHeight / TopDivider.AbsoluteSize.Y, 0)
DragTipBar.Position = UDim2.new(0, 0, 0, 0)
DragTipBar.BackgroundColor3 = Color3.new(0.6, 0.6, 0.6)
DragTipBar.BackgroundTransparency = 0.5
DragTipBar.CornerRadius = UDim.new(0, 6, 0, 0)
local DragIcon = Instance.new("TextLabel")
DragIcon.Name = "DragIcon"
DragIcon.Size = UDim2.new(0, 30, 0, PhoneConfig.DragTipHeight)
DragIcon.Position = UDim2.new(0.5, -15, 0, 0)
DragIcon.BackgroundTransparency = 1
DragIcon.Text = "☰"
DragIcon.TextColor3 = Color3.new(0.2, 0.2, 0.2)
DragIcon.TextScaled = true
DragIcon.Parent = DragTipBar
DragTipBar.Parent = TopDivider

-- 脚本名称与版本
local ScriptNameLabel = Instance.new("TextLabel")
ScriptNameLabel.Name = "ScriptNameLabel"
ScriptNameLabel.Size = UDim2.new(0.4, 0, 0.6, 0)
ScriptNameLabel.Position = UDim2.new(0.04, 0, PhoneConfig.DragTipHeight / TopDivider.AbsoluteSize.Y, 0)
ScriptNameLabel.BackgroundTransparency = 1
ScriptNameLabel.Text = "XG脚本整合"
ScriptNameLabel.TextColor3 = Color3.new(0.15, 0.15, 0.15)
ScriptNameLabel.TextScaled = true
ScriptNameLabel.Font = Enum.Font.Bold
ScriptNameLabel.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
ScriptNameLabel.MaxTextSize = 24
ScriptNameLabel.Parent = TopDivider

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "VersionLabel"
VersionLabel.Size = UDim2.new(0.4, 0, 0.35, 0)
VersionLabel.Position = UDim2.new(0.04, 0, PhoneConfig.DragTipHeight / TopDivider.AbsoluteSize.Y + 0.62, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v0.0.1"
VersionLabel.TextColor3 = Color3.new(0.3, 0.3, 0.3)
VersionLabel.TextScaled = true
VersionLabel.Font = Enum.Font.Regular
VersionLabel.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
VersionLabel.MaxTextSize = 16
VersionLabel.Parent = TopDivider

-- 关闭按钮
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 60, 0, 60)
CloseBtn.Position = UDim2.new(1, -70, 0.5, -30)
CloseBtn.BackgroundColor3 = Color3.new(1, 0.25, 0.25)
CloseBtn.BackgroundTransparency = 0
CloseBtn.CornerRadius = UDim.new(0, 15)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextScaled = true
CloseBtn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
CloseBtn.MaxTextSize = 32
CloseBtn.MouseButton1Down:Connect(function()
    CloseBtn.Size = CloseBtn.Size * PhoneConfig.PressScale
    CloseBtn.BackgroundTransparency = PhoneConfig.PressTransparency
end)
CloseBtn.MouseButton1Up:Connect(function()
    CloseBtn.Size = CloseBtn.Size / PhoneConfig.PressScale
    CloseBtn.BackgroundTransparency = 0
end)
CloseBtn.TouchTap:Connect(function()
    CloseBtn.Size = CloseBtn.Size * PhoneConfig.PressScale
    task.delay(0.08, function() CloseBtn.Size = CloseBtn.Size / PhoneConfig.PressScale end)
end)
CloseBtn.Parent = TopDivider

-- 主UI拖动逻辑
local isDraggingMain = false
local dragStartPos = Vector2.new()
local mainStartPos = MainFrame.Position
local activeTouchId = nil

local function startDrag(startPos)
    isDraggingMain = true
    dragStartPos = startPos
    mainStartPos = MainFrame.Position
    MainFrame.Size = PhoneConfig.MainSize * PhoneConfig.CurrentScale * 0.95
end

TopDivider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local dragAreaTop = TopDivider.AbsolutePosition.Y
        local dragAreaBottom = TopDivider.AbsolutePosition.Y + PhoneConfig.DragTipHeight
        if mousePos.Y >= dragAreaTop and mousePos.Y <= dragAreaBottom then
            startDrag(mousePos)
        end
    end
end)

TopDivider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not activeTouchId then
        local touchPos = Vector2.new(input.Position.X, input.Position.Y)
        local dragAreaTop = TopDivider.AbsolutePosition.Y
        local dragAreaBottom = TopDivider.AbsolutePosition.Y + PhoneConfig.DragTipHeight
        if touchPos.Y >= dragAreaTop and touchPos.Y <= dragAreaBottom then
            activeTouchId = input.TouchId
            startDrag(touchPos)
        end
    end
end)

local function updateDrag(currentPos)
    if not isDraggingMain then return end
    local dragDelta = currentPos - dragStartPos
    local newX = mainStartPos.X.Offset + dragDelta.X
    local newY = mainStartPos.Y.Offset + dragDelta.Y
    local screenSize = workspace.CurrentCamera.ViewportSize
    local margin = 20
    newX = math.clamp(newX, margin, screenSize.X - MainFrame.AbsoluteSize.X - margin)
    newY = math.clamp(newY, margin, screenSize.Y - MainFrame.AbsoluteSize.Y - margin)
    MainFrame.Position = UDim2.new(0, newX, 0, newY)
end

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDraggingMain then
        updateDrag(UserInputService:GetMouseLocation())
    end
end)

TouchInputService.TouchMoved:Connect(function(input)
    if input.TouchId == activeTouchId and isDraggingMain then
        updateDrag(Vector2.new(input.Position.X, input.Position.Y))
    end
end)

local function endDrag()
    if isDraggingMain then
        isDraggingMain = false
        MainFrame.Size = PhoneConfig.MainSize * PhoneConfig.CurrentScale
        activeTouchId = nil
    end
end

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

TouchInputService.TouchEnded:Connect(function(input)
    if input.TouchId == activeTouchId then
        endDrag()
    end
end)

TouchInputService.TouchCancelled:Connect(function(input)
    if input.TouchId == activeTouchId then
        endDrag()
    end
end)

-- 侧边分类栏
local CategoryFrame = Instance.new("Frame")
CategoryFrame.Name = "CategoryFrame"
CategoryFrame.Size = UDim2.new(0.28, 0, 0.86, 0)
CategoryFrame.Position = UDim2.new(0.02, 0, 0.14, 0)
CategoryFrame.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
CategoryFrame.BackgroundTransparency = 0.3
CategoryFrame.CornerRadius = UDim.new(0, 15)
CategoryFrame.Parent = MainFrame

-- 分类数据
local categories = {
    {Name = "背包", Color = Color3.new(0.25, 0.45, 0.65), SelectColor = Color3.new(0.35, 0.55, 0.75)},
    {Name = "商店", Color = Color3.new(0.65, 0.25, 0.45), SelectColor = Color3.new(0.75, 0.35, 0.55)},
    {Name = "设置", Color = Color3.new(0.25, 0.65, 0.45), SelectColor = Color3.new(0.35, 0.75, 0.55)},
    {Name = "任务", Color = Color3.new(0.65, 0.65, 0.25), SelectColor = Color3.new(0.75, 0.75, 0.35)}
}

local currentSelectIndex = 1

-- 创建分类按钮
local function createCategoryBtn(index, data)
    local btn = Instance.new("TextButton")
    btn.Name = data.Name .. "Btn"
    btn.Size = UDim2.new(0.9, 0, PhoneConfig.CategoryBtnHeight, 0)
    btn.Position = UDim2.new(0.05, 0, (index-1)*(PhoneConfig.CategoryBtnHeight + 0.02), 0)
    btn.BackgroundColor3 = index == currentSelectIndex and data.SelectColor or data.Color
    btn.BackgroundTransparency = 0.25
    btn.CornerRadius = UDim.new(0, 12)
    btn.Text = data.Name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
    btn.MaxTextSize = 22
    btn.Font = Enum.Font.Bold

    btn.MouseButton1Down:Connect(function()
        btn.Size = btn.Size * PhoneConfig.PressScale
        btn.BackgroundTransparency = PhoneConfig.PressTransparency
    end)
    btn.MouseButton1Up:Connect(function()
        btn.Size = btn.Size / PhoneConfig.PressScale
        btn.BackgroundTransparency = 0.25
    end)
    btn.TouchTap:Connect(function()
        btn.Size = btn.Size * PhoneConfig.PressScale
        task.delay(0.08, function() btn.Size = btn.Size / PhoneConfig.PressScale end)
    end)

    local function selectCategory()
        currentSelectIndex = index
        for _, child in ipairs(CategoryFrame:GetChildren()) do
            if child:IsA("TextButton") then
                local catIndex = tonumber(string.match(child.Name, "%d+")) or 1
                local catData = categories[catIndex]
                child.BackgroundColor3 = child == btn and catData.SelectColor or catData.Color
            end
        end
        for _, child in ipairs(MainFrame:GetChildren()) do
            if child.Name:find("Function") then
                child.Visible = child.Name == data.Name .. "Function"
            end
        end
    end
    btn.MouseButton1Click:Connect(selectCategory)
    btn.TouchTap:Connect(selectCategory)

    btn.Parent = CategoryFrame
    return btn
end

for i, data in ipairs(categories) do
    createCategoryBtn(i, data)
end

-- 功能区：背包（空状态）
local BagFunction = Instance.new("Frame")
BagFunction.Name = "背包Function"
BagFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
BagFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
BagFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
BagFunction.BackgroundTransparency = 0.5
BagFunction.CornerRadius = UDim.new(0, 15)
BagFunction.Visible = true
BagFunction.Parent = MainFrame

local BagEmptyTip = Instance.new("TextLabel")
BagEmptyTip.Name = "BagEmptyTip"
BagEmptyTip.Size = UDim2.new(0.8, 0, 0.1, 0)
BagEmptyTip.Position = UDim2.new(0.1, 0, 0.45, 0)
BagEmptyTip.BackgroundTransparency = 1
BagEmptyTip.Text = "当前背包暂无物品"
BagEmptyTip.TextColor3 = Color3.new(0.7, 0.7, 0.7)
BagEmptyTip.TextScaled = true
BagEmptyTip.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
BagEmptyTip.MaxTextSize = 20
BagEmptyTip.Parent = BagFunction

-- 功能区：商店（空状态）
local ShopFunction = Instance.new("Frame")
ShopFunction.Name = "商店Function"
ShopFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
ShopFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
ShopFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
ShopFunction.BackgroundTransparency = 0.5
ShopFunction.CornerRadius = UDim.new(0, 15)
ShopFunction.Visible = false
ShopFunction.Parent = MainFrame

local ShopEmptyTip = Instance.new("TextLabel")
ShopEmptyTip.Name = "ShopEmptyTip"
ShopEmptyTip.Size = UDim2.new(0.8, 0, 0.1, 0)
ShopEmptyTip.Position = UDim2.new(0.1, 0, 0.45, 0)
ShopEmptyTip.BackgroundTransparency = 1
ShopEmptyTip.Text = "商店功能待开放"
ShopEmptyTip.TextColor3 = Color3.new(0.7, 0.7, 0.7)
ShopEmptyTip.TextScaled = true
ShopEmptyTip.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
ShopEmptyTip.MaxTextSize = 20
ShopEmptyTip.Parent = ShopFunction

-- 功能区：设置（含恢复位置、缩放功能）
local SettingFunction = Instance.new("Frame")
SettingFunction.Name = "设置Function"
SettingFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
SettingFunction.Position
