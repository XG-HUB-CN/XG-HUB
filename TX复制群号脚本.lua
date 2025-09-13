-- 罗布乐思手机版文本复制脚本
-- 执行后直接将指定内容复制到剪贴板

-- 设置要复制的文本内容
local textToCopy = "脚本群:160369111"

-- 检测平台
local isMobile = (game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled)
local isPC = game:GetService("UserInputService").KeyboardEnabled

-- 复制函数
local function copyToClipboard(text)
    if isMobile then
        -- 手机端复制方法
        local success, result = pcall(function()
            -- 方法1: 尝试使用注入器提供的setclipboard函数
            if setclipboard then
                setclipboard(text)
                return true
            end
            
            -- 方法2: 尝试使用ClipboardService
            local ClipboardService = game:GetService("ClipboardService")
            if ClipboardService then
                ClipboardService:SetString(text)
                return true
            end
            
            -- 方法3: 创建隐藏的文本框并选择文本
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "HiddenCopyGui"
            screenGui.Parent = game:GetService("CoreGui")
            
            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(0, 1, 0, 1) -- 非常小的尺寸，几乎不可见
            textBox.Position = UDim2.new(0, 0, 0, 0)
            textBox.Text = text
            textBox.ClearTextOnFocus = false
            textBox.Parent = screenGui
            
            -- 尝试聚焦并选择文本
            textBox:CaptureFocus()
            textBox:SelectAll()
            
            -- 延迟销毁GUI
            delay(0.5, function()
                screenGui:Destroy()
            end)
            
            return false
        end)
        
        if success then
            if result then
                print("复制到剪贴板啦!")
            else
                print("手动复制一下吧！ (长按并选择复制)")
            end
        else
            warn("没用成功唉: " .. tostring(result))
            print("手动复制一下吧！:")
            print(text)
        end
    else
        -- PC端复制方法
        local success, err = pcall(function()
            if setclipboard then
                setclipboard(text)
                print("复制到剪贴板啦!")
            else
                -- 备用方法
                local ClipboardService = game:GetService("ClipboardService")
                ClipboardService:SetString(text)
                print("复制到剪贴板啦！")
            end
        end)
        
        if not success then
            warn("没有成功诶 再试一次..: " .. tostring(err))
            print("还是没有成功 要不手动复制一下呗:")
            print(text)
        end
    end
end

-- 执行复制
copyToClipboard(textToCopy)
