if arg[1] ~= nil then
    shell.run("window-launch " .. arg[1] .. " true")
end

-- PixelUI Generated Code
local PixelUI = require("pixelui")
PixelUI.init()

-- Create main container
local main = PixelUI.container({
    width = 51,
    height = 19
})

main:addChild(PixelUI.textBox({
    x = 16, y = 1, width = 20,
    placeholder = "Address Bar",
    enabled = true
}))

local tabContent = PixelUI.container({
    width=51, height=19,
})

tabContent:addChild(
PixelUI.label({
    x = 16, y = 3,
    text = "Welcome to Craft-Web!",
    color = colors.black,
    background = colors.white
}))


tabContent:addChild(
    PixelUI.richTextBox({
        x = 7, y = 6, width = 40, height = 10,
        lines = {"To start, either call craft-web with the",  "arg of your .cml file, or connect to a ", "network via address bar"},
        wordWrap = true
    })
)
-- To start, either call craft-web with the arg of your cml file, or connect to a network via address bar

-- TabControl element
local element1 = PixelUI.tabControl({
    x = 1, y = 2,
    width = 51, height = 19,

    tabs = {{text = "Main", content = tabContent}},
    background = colors.white
})

main:addChild(element1)

-- Button element
local element2 = PixelUI.button({
    x = 48,
    y = 1,
    width = 4,
    height = 1,
    text = "Exit",
    onClick = function(self)
        PixelUI.clear()
        os.queueEvent("terminate")
    end,
    background = colors.red
})
main:addChild(element2)

-- Start the UI
PixelUI.run()