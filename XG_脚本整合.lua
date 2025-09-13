local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建主窗口
local Window = Rayfield:CreateWindow({
    Name = "XG-脚本整合",
    LoadingTitle = "马上加载 莫慌...",
    LoadingSubtitle = "v0.0.1",
    ConfigurationSaving = {
        Enabled = false,
    },
})

-- 创建标签页
local Tab1 = Window:CreateTab("公告")
local Tab2 = Window:CreateTab("king脚本")
local Tab3 = Window:CreateTab("走马观花X")
local Tab4 = Window:CreateTab("通用")

--tab1公告
local ButtonExample = Tab1:CreateButton({
    Name = "感谢使用该脚本",
    Callback = function()
        print("点我干嘛!")
    end,
})

--1公告
local ButtonExample = Tab1:CreateButton({
    Name = "由XG制作 使用RFUI",
    Callback = function()
        print("点我干嘛!")
    end,
})

--1公告
local ButtonExample = Tab1:CreateButton({
    Name = "哔站稀饭不熙",
    Callback = function()
        print("点我干嘛!")
    end,
})

--king执行
local ButtonExample = Tab2:CreateButton({
    Name = "点击执行",
    Callback = function()
        print("--免费版支持服务器数量达到+70(如果体验不好请谅解)
--支持的服务器看群公告图片！
--霖溺Team只有1个作者:霖溺[免费]
月星[是一个大圈子]
LnScript = "霖溺-免费版加载器"
loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ScriptLoader/refs/heads/main/Linni_FreeLoader.lua"))()")
    end,
})

--king支持游戏
local ButtonExample = Tab2:CreateButton({
    Name = "点击查看king支持游戏(执行前必看)",
    Callback = function()
        print("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/king执行忠告.lua")
    end,
})

--走马观花_执行
local ButtonExample = Tab2:CreateButton({
    Name = "点击执行哦",
    Callback = function()
        print("_ZOUMAGUANHUAGUI='走马观花X'loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\88\80\84\105\86\75\87\120"))()")
    end,
})