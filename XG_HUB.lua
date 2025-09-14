local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建主窗口
local Window = Rayfield:CreateWindow({
    Name = "XG脚本整合",
    LoadingTitle = "马上加载 啦～",
    LoadingSubtitle = "v0.0.1",
    ConfigurationSaving = {
        Enabled = false,
    },
})

-- 创建标签页
local Tab1 = Window:CreateTab("公告")
local Tab2 = Window:CreateTab("走马观花X")
local Tab3 = Window:CreateTab("退休TX")
local Tab4 = Window:CreateTab("king")
local Tab5 = Window:CreateTab("冷全源")
local Tab6 = Window:CreateTab("待更新")


--公告
local ButtonExample = Tab1:CreateButton({
    Name = "感谢使用XG脚本",
    Callback = function()
        print("嘿嘿 被发现了")
    end,
})

--公告
local ButtonExample = Tab1:CreateButton({
    Name = "由哔站稀饭不熙制作",
    Callback = function()
        print("嘿嘿 又被发现了")
    end,
})

--公告
local ButtonExample = Tab1:CreateButton({
    Name = "不要倒卖哦毕竟每个人的钱都不是大风刮来的",
    Callback = function()
        print("祝你健康哦")
    end,
})

--公告
local ButtonExample = Tab1:CreateButton({
    Name = "此版本为0.0.1最后更新时间2025913",
    Callback = function()
        print("学业有成哦 不要像作者一样成绩那么差....")
    end,
})

--2走马观花x执行
local ButtonExample = Tab2:CreateButton({
    Name = "点击执行",
    Callback = function()
        _ZOUMAGUANHUAGUI='走马观花X'loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\88\80\84\105\86\75\87\120"))()
    end,
})

--走马观花卡密
local ButtonExample = Tab2:CreateButton({
    Name = "查看卡密",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/走马观花卡密查询.lua"))()
    end,
})

--tx执行
local ButtonExample = Tab3:CreateButton({
    Name = "点击执行",
    Callback = function()
        TX = "脚本群:160369111"Script = "Free永久免费"loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/refs/heads/main/FREE-TX-TEAM"))()
    end,
})

--TX公告
local ButtonExample = Tab3:CreateButton({
    Name = "TX公告",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/TX公告.lua"))()
    end,
})

--TX复制群号
local ButtonExample = Tab3:CreateButton({
    Name = "点击复制qq群号",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/TX复制群号脚本.lua"))()
    end,
})

--king执行
local ButtonExample = Tab4:CreateButton({
    Name = "点击执行",
    Callback = function()
        --免费版支持服务器数量达到+70(如果体验不好请谅解)
--支持的服务器看群公告图片！
--霖溺Team只有1个作者:霖溺[免费]
LnScript = "霖溺-免费版加载器"
loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ScriptLoader/refs/heads/main/Linni_FreeLoader.lua"))()
    end,
})

--king公告
local ButtonExample = Tab4:CreateButton({
    Name = "点击查看支持游戏和忠告",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/king支持列表.lua"))()
    end,
})

--king群组复制
local ButtonExample = Tab4:CreateButton({
    Name = "点击复制群组名字",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/king群组名字复制.lua"))()
    end,
})

--冷伐木
local ButtonExample = Tab5:CreateButton({
    Name = "伐木大亨",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/伐木大亨.lua"))()
    end,
})

--冷火箭发射
local ButtonExample = Tab5:CreateButton({
    Name = "火箭发射模拟器",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/重做火箭发射模拟器.lua"))()
    end,
})

--冷力量
local ButtonExample = Tab5:CreateButton({
    Name = "力量传奇",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/力量传奇.lua"))()
    end,
})

--狗熊岭
local ButtonExample = Tab5:CreateButton({
    Name = "狗熊岭",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/狗熊岭.lua"))()
    end,
})

--冷力量
local ButtonExample = Tab2:CreateButton({
    Name = "力量传奇",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/力量传奇.lua"))()
    end,
})

--冷门
local ButtonExample = Tab2:CreateButton({
    Name = "冷.门",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XG-HUB-CN/XG-HUB/refs/heads/main/Doors.lua"))()
    end,
})
