-- 服务引用与基础配置（手机端优先适配）
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TouchInputService = game:GetService("TouchInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") -- 确保PlayerGui加载完成

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

-- 主UI容器（修复CornerRadius属性兼容性）
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XG_Script_UI"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = PhoneConfig.MainSize
MainFrame.Position = PhoneConfig.MainPos
MainFrame.BackgroundTransparency = 0.65
MainFrame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
MainFrame.CornerRadius = UDim2.new(0, 20, 0, 20) -- 适配旧版本双值语法
MainFrame.Visible = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- 主背景模糊效果
local MainBlur = Instance.new("UIGaussianBlurEffect")
MainBlur.Name = "MainBackgroundBlur"
MainBlur.Radius = 8
MainBlur.Parent = MainFrame

-- 顶部分割条（修复CornerRadius属性）
local TopDivider = Instance.new("Frame")
TopDivider.Name = "TopDivider"
TopDivider.Size = UDim2.new(1, 0, 0.12, 0)
TopDivider.Position = UDim2.new(0, 0, 0, 0)
TopDivider.BackgroundColor3 = Color3.new(1, 1, 1)
TopDivider.BackgroundTransparency = 0.6
TopDivider.CornerRadius = UDim2.new(0, 20, 0, 20) -- 统一双值语法
TopDivider.Parent = MainFrame

-- 拖动提示条（含图标）
local DragTipBar = Instance.new("Frame")
DragTipBar.Name = "DragTipBar"
DragTipBar.Size = UDim2.new(1, 0, PhoneConfig.DragTipHeight / TopDivider.AbsoluteSize.Y, 0)
DragTipBar.Position = UDim2.new(0, 0, 0, 0)
DragTipBar.BackgroundColor3 = Color3.new(0.6, 0.6, 0.6)
DragTipBar.BackgroundTransparency = 0.5
DragTipBar.CornerRadius = UDim2.new(0, 6, 0, 6)
DragTipBar.Parent = TopDivider

local DragIcon = Instance.new("TextLabel")
DragIcon.Name = "DragIcon"
DragIcon.Size = UDim2.new(0, 30, 0, PhoneConfig.DragTipHeight)
DragIcon.Position = UDim2.new(0.5, -15, 0, 0)
DragIcon.BackgroundTransparency = 1
DragIcon.Text = "☰"
DragIcon.TextColor3 = Color3.new(0.2, 0.2, 0.2)
DragIcon.TextScaled = true
DragIcon.Parent = DragTipBar

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

-- 关闭按钮（补全事件逻辑）
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 60, 0, 60)
CloseBtn.Position = UDim2.new(1, -70, 0.5, -30)
CloseBtn.BackgroundColor3 = Color3.new(1, 0.25, 0.25)
CloseBtn.BackgroundTransparency = 0
CloseBtn.CornerRadius = UDim2.new(0, 15, 0, 15)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextScaled = true
CloseBtn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
CloseBtn.MaxTextSize = 32

-- 鼠标按压效果
CloseBtn.MouseButton1Down:Connect(function()
    CloseBtn.Size = CloseBtn.Size * PhoneConfig.PressScale
    CloseBtn.BackgroundTransparency = PhoneConfig.PressTransparency
end)
CloseBtn.MouseButton1Up:Connect(function()
    CloseBtn.Size = CloseBtn.Size / PhoneConfig.PressScale
    CloseBtn.BackgroundTransparency = 0
    ScreenGui:Destroy() -- 点击关闭时销毁整个UI
end)

-- 触摸按压效果
CloseBtn.TouchTap:Connect(function()
    CloseBtn.Size = CloseBtn.Size * PhoneConfig.PressScale
    task.delay(0.08, function() 
        CloseBtn.Size = CloseBtn.Size / PhoneConfig.PressScale 
        ScreenGui:Destroy() -- 触摸关闭时销毁整个UI
    end)
end)
CloseBtn.Parent = TopDivider

-- 主UI拖动逻辑（优化触摸ID管理）
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

-- 鼠标拖动触发
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

-- 触摸拖动触发
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

-- 更新拖动位置（添加屏幕边界判断）
local function updateDrag(currentPos)
    if not isDraggingMain then return end
    local dragDelta = currentPos - dragStartPos
    local newX = mainStartPos.X.Offset + dragDelta.X
    local newY = mainStartPos.Y.Offset + dragDelta.Y
    local screenSize = workspace.CurrentCamera.ViewportSize
    local margin = 20

    -- 限制UI在屏幕内
    newX = math.clamp(newX, margin, screenSize.X - MainFrame.AbsoluteSize.X - margin)
    newY = math.clamp(newY, margin, screenSize.Y - MainFrame.AbsoluteSize.Y - margin)
    MainFrame.Position = UDim2.new(0, newX, 0, newY)
end

-- 鼠标拖动更新
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDraggingMain then
        updateDrag(UserInputService:GetMouseLocation())
    end
end)

-- 触摸拖动更新
TouchInputService.TouchMoved:Connect(function(input)
    if input.TouchId == activeTouchId and isDraggingMain then
        updateDrag(Vector2.new(input.Position.X, input.Position.Y))
    end
end)

-- 结束拖动
local function endDrag()
    if isDraggingMain then
        isDraggingMain = false
        MainFrame.Size = PhoneConfig.MainSize * PhoneConfig.CurrentScale
        activeTouchId = nil
    end
end

-- 鼠标拖动结束
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

-- 触摸拖动结束/取消
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
CategoryFrame.CornerRadius = UDim2.new(0, 15, 0, 15)
CategoryFrame.Parent = MainFrame

-- 分类数据
local categories = {
    {Name = "背包", Color = Color3.new(0.25, 0.45, 0.65), SelectColor = Color3.new(0.35, 0.55, 0.75)},
    {Name = "商店", Color = Color3.new(0.65, 0.25, 0.45), SelectColor = Color3.new(0.75, 0.35, 0.55)},
    {Name = "设置", Color = Color3.new(0.25, 0.65, 0.45), SelectColor = Color3.new(0.35, 0.75, 0.55)},
    {Name = "任务", Color = Color3.new(0.65, 0.65, 0.25), SelectColor = Color3.new(0.75, 0.75, 0.35)}
}
local currentSelectIndex = 1

-- 创建分类按钮（修复按钮位置计算）
local function createCategoryBtn(index, data)
    local btn = Instance.new("TextButton")
    btn.Name = data.Name .. "Btn"
    btn.Size = UDim2.new(0.9, 0, PhoneConfig.CategoryBtnHeight, 0)
    -- 修复按钮间距（用UDim2确保比例适配）
    btn.Position = UDim2.new(0.05, 0, (index-1)*(PhoneConfig.CategoryBtnHeight + 0.02), 0)
    btn.BackgroundColor3 = index == currentSelectIndex and data.SelectColor or data.Color
    btn.BackgroundTransparency = 0.25
    btn.CornerRadius = UDim2.new(0, 12, 0, 12)
    btn.Text = data.Name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
    btn.MaxTextSize = 22
    btn.Font = Enum.Font.Bold

    -- 鼠标按压效果
    btn.MouseButton1Down:Connect(function()
        btn.Size = btn.Size * PhoneConfig.PressScale
        btn.BackgroundTransparency = PhoneConfig.PressTransparency
    end)
    btn.MouseButton1Up:Connect(function()
        btn.Size = btn.Size / PhoneConfig.PressScale
        btn.BackgroundTransparency = 0.25
    end)

    -- 触摸按压效果
    btn.TouchTap:Connect(function()
        btn.Size = btn.Size * PhoneConfig.PressScale
        task.delay(0.08, function() btn.Size = btn.Size / PhoneConfig.PressScale end)
    end)

    -- 分类选择逻辑
    local function selectCategory()
        currentSelectIndex = index
        -- 更新所有分类按钮颜色
        for _, child in ipairs(CategoryFrame:GetChildren()) do
            if child:IsA("TextButton") then
                -- 修复分类索引匹配（通过按钮名称提取分类名）
                local btnCatName = string.gsub(child.Name, "Btn", "")
                for i, cat in ipairs(categories) do
                    if cat.Name == btnCatName then
                        child.BackgroundColor3 = child == btn and cat.SelectColor or cat.Color
                        break
                    end
                end
            end
        end
        -- 显示对应功能区
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

-- 生成所有分类按钮
for i, data in ipairs(categories) do
    createCategoryBtn(i, data)
end

-- 功能区：背包（补全空状态UI）
local BagFunction = Instance.new("Frame")
BagFunction.Name = "背包Function"
BagFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
BagFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
BagFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
BagFunction.BackgroundTransparency = 0.5
BagFunction.CornerRadius = UDim2.new(0, 15, 0, 15)
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

-- 功能区：商店（补全空状态UI）
local ShopFunction = Instance.new("Frame")
ShopFunction.Name = "商店Function"
ShopFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
ShopFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
ShopFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
ShopFunction.BackgroundTransparency = 0.5
ShopFunction.CornerRadius = UDim2.new(0, 15, 0, 15)
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

-- 功能区：设置（补全缩放、恢复位置功能）
local SettingFunction = Instance.new("Frame")
SettingFunction.Name = "设置Function"
SettingFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
SettingFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
SettingFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
SettingFunction.BackgroundTransparency = 0.5
SettingFunction.CornerRadius = UDim2.new(0, 15, 0, 15)
SettingFunction.Visible = false
SettingFunction.Parent = MainFrame

-- 缩放设置标题
local ScaleTitle = Instance.new("TextLabel")
ScaleTitle.Name = "ScaleTitle"
ScaleTitle.Size = UDim2.new(0.8, 0, 0.1, 0)
ScaleTitle.Position = UDim2.new(0.1, 0, 0.1, 0)
ScaleTitle.BackgroundTransparency = 1
ScaleTitle.Text = "UI缩放设置"
ScaleTitle.TextColor3 = Color3.new(0.9, 0.9, 0.9)
ScaleTitle.TextScaled = true
ScaleTitle.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
ScaleTitle.MaxTextSize = 22
ScaleTitle.Parent = SettingFunction

-- 缩放按钮容器
local ScaleBtnFrame = Instance.new("Frame")
ScaleBtnFrame.Name = "ScaleBtnFrame"
ScaleBtnFrame.Size = UDim2.new(0.8, 0, 0.2, 0)
ScaleBtnFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
ScaleBtnFrame.BackgroundTransparency = 1
ScaleBtnFrame.Parent = SettingFunction

-- 生成缩放按钮（对应PhoneConfig.ScaleOptions）
for i, scale in ipairs(PhoneConfig.ScaleOptions) do
    local ScaleBtn = Instance.new("TextButton")
    ScaleBtn.Name = "Scale" .. scale .. "Btn"
    ScaleBtn.Size = UDim2.new(1/3 - 0.02, 0, 0.8, 0)
    ScaleBtn.Position = UDim2.new((i-1)*(1/3) + 0.01, 0, 0.1, 0)
    ScaleBtn.BackgroundColor3 = PhoneConfig.CurrentScale == scale and Color3.new(0.4, 0.6, 0.8) or Color3.new(0.2, 0.2, 0.2)
    ScaleBtn.BackgroundTransparency = 0.3
    ScaleBtn.CornerRadius = UDim2.new(0, 8, 0, 8)
    ScaleBtn.Text = scale .. "x"
    ScaleBtn.TextColor3 = Color3.new(1, 1, 1)
    ScaleBtn.TextScaled = true
    ScaleBtn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
    ScaleBtn.MaxTextSize = 18

    -- 缩放按钮点击逻辑
    ScaleBtn.MouseButton1Click:Connect(function()
        PhoneConfig.CurrentScale = scale
        MainFrame.Size = PhoneConfig.MainSize * scale
        -- 更新所有缩放按钮颜色
        for _, btn in ipairs(ScaleBtnFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                local btnScale = tonumber(string.gsub(btn.Name, "Scale", ""):gsub("xBtn", ""))
                btn.BackgroundColor3 = btnScale == scale and Color3.new(0.4, 0.6, 0.8) or Color3.new(0.2, 0.2, 0.2)
            end
        end
    end)
    ScaleBtn.Parent = ScaleBtnFrame
end

-- 恢复初始位置按钮
local ResetPosBtn = Instance.new("TextButton")
ResetPosBtn.Name = "ResetPosBtn"
ResetPosBtn.Size = UDim2.new(0.5, 0, 0.12, 0)
ResetPosBtn.Position = UDim2.new(0.25, 0, 0.55, 0)
ResetPosBtn.BackgroundColor3 = Color3.new(0.3, 0.5, 0.7)
ResetPosBtn.BackgroundTransparency = 0.3
ResetPosBtn.CornerRadius = UDim2.new(0, 10, 0, 10)
ResetPosBtn.Text = "恢复初始位置"
ResetPosBtn.TextColor3 = Color3.new(1, 1, 1)
ResetPosBtn.TextScaled = true
ResetPosBtn.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
ResetPosBtn.MaxTextSize = 18

-- 恢复位置逻辑
ResetPosBtn.MouseButton1Click:Connect(function()
    MainFrame.Position = PhoneConfig.MainPos
end)
ResetPosBtn.Parent = SettingFunction

-- 功能区：任务（补全空状态UI）
local TaskFunction = Instance.new("Frame")
TaskFunction.Name = "任务Function"
TaskFunction.Size = UDim2.new(0.7, 0, 0.86, 0)
TaskFunction.Position = UDim2.new(0.29, 0, 0.14, 0)
TaskFunction.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
TaskFunction.BackgroundTransparency = 0.5
TaskFunction.CornerRadius = UDim2.new(0, 15, 0, 15)
TaskFunction.Visible = false
TaskFunction.Parent = MainFrame

local TaskEmptyTip = Instance.new("TextLabel")
TaskEmptyTip.Name = "TaskEmptyTip"
TaskEmptyTip.Size = UDim2.new(0.8, 0, 0.1, 0)
TaskEmptyTip.Position = UDim2.new(0.1, 0, 0.45, 0)
TaskEmptyTip.BackgroundTransparency = 1
TaskEmptyTip.Text = "当前暂无任务"
TaskEmptyTip.TextColor3 = Color3.new(0.7, 0.7, 0.7)
TaskEmptyTip.TextScaled = true
TaskEmptyTip.TextSizeConstraint = Enum.TextSizeConstraint.MaxSize
TaskEmptyTip.MaxTextSize = 20
TaskEmptyTip.Parent = TaskFunction
