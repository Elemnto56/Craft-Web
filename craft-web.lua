if arg[1] ~= nil then
    if arg[1] ~= "nil" then shell.run("window-launch " .. arg[1] .. " true") end
end

-- PixelUI Generated Code
local PixelUI = require("pixelui")
PixelUI.init()

-- Create main container
local main = PixelUI.container({
    width = 51,
    height = 19
})

-- Showing tip instead of an error
local tipOnURLFormat = PixelUI.notificationToast({
    message = "Format: cw://[RTS id]?[dir]",
    type = "info",
    x = 1, y = 18,
    duration = 5 * 1000,

    animateIn = true, animateOut = true
})

local noAntennaErr = PixelUI.notificationToast({
    message = "Make sure to add the Radio Antenna!",
    type = "error",
    x = 1, y = 18,
    duration = 5 * 1000,

    animateIn = true, animateOut = true
})

local notAModem = PixelUI.notificationToast({
    message = "The back peripheral was not a modem!",
    type = "error",
    x = 1, y = 18,
    duration = 5 * 1000,

    animateIn = true, animateOut = true
})

local fileNotFound = PixelUI.notificationToast({
    message = "The file could not be found on the RTC.",
    type = "error",
    x = 1, y = 18,
    duration = 5 * 1000,

    animateIn = true, animateOut = true
})


local reqTimeout = PixelUI.notificationToast({
    message = "The request to RTC timed out.",
    type = "error",
    x = 1, y = 18,
    duration = 5 * 1000,

    animateIn = true, animateOut = true
})

main:addChild(PixelUI.textBox({
    x = 16, y = 1, width = 20,
    placeholder = "Address Bar",
    enabled = true,
    onEnter = function(self, text)
        local port, path = text:match("^cw://(%d+)%?(/[%w/-]+%.cml)$")

        if peripheral.isPresent("back") then
            local x = ""; x, _ = peripheral.getType("back");
            if x ~= "modem" then notAModem:show() end

            rednet.open("back") -- Register it to rednet
            rednet.send(tonumber(port), path, "GET")
            local _, fileContent, status = rednet.receive(nil, 3)

            if fileContent == nil and status == nil then reqTimeout:show()
            elseif tonumber(status) == 404 then fileNotFound:show() 
            else
                local grabbedFile = path:match("(%w+%.cml)")
                local tmp = fs.open(grabbedFile, "w")
                tmp.write(fileContent)
                tmp.close()

                shell.run("window-launch " .. grabbedFile .. " true")
            end
        else if peripheral.isPresent("top") then
            local freq = math.random(1, 6400)
            local ant = peripheral.wrap("top")

            if port == nil or path == nil then tipOnURLFormat:show()end 
            if ant == nil then noAntennaErr:show() end

            ant.setFrequency(0)
            ant.broadcast("GET" .. " " .. tostring(port).. " " .. path .. " " .. freq)
            ant.setFrequency(freq)
            local _, _, content, _ = os.pullEvent("radio_message")
            
            local grabbedFile = path:match("(%w+%.cml)")
            local tmp = fs.open(grabbedFile, "w")
            tmp.write(content)
            tmp.close()

            shell.run("window-launch " .. grabbedFile .. " true")
        end
    end end
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
        if arg[2] == "true" then os.queueEvent("terminate"); os.queueEvent("terminate"); end
    end,
    background = colors.red
})
main:addChild(element2)

-- Start the UI
PixelUI.run()