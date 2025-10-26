local function parseCML(text)
    local result = {}
    local i = 1

    while i <= #text do
        -- Check if we're at a color tag
        if text:sub(i, i) == "[" then
            -- Find the closing bracket
            local closeBracket = text:find("]", i, true)
            if closeBracket then
                -- Extract the entire tag including brackets
                local tag = text:sub(i, closeBracket)
                table.insert(result, tag)
                i = closeBracket + 1
            else
                -- No closing bracket found, treat as regular text
                i = i + 1
            end
        else
            -- Extract a word (non-whitespace characters)
            local word = ""
            while i <= #text and not text:sub(i, i):match("%s") and text:sub(i, i) ~= "[" do
                word = word .. text:sub(i, i)
                i = i + 1
            end

            if #word > 0 then
                table.insert(result, word)
            end

            -- Capture whitespace as a separate token
            local whitespace = ""
            while i <= #text and text:sub(i, i):match("%s") do
                whitespace = whitespace .. text:sub(i, i)
                i = i + 1
            end

            if #whitespace > 0 then
                table.insert(result, whitespace)
            end
        end
    end

    return result
end

-- White Bar
term.clear()
term.setCursorBlink(false)
term.setCursorPos(1,1)
paintutils.drawLine(1, 1, 51, 1, colors.lightGray)

-- Name of file
term.setTextColor(colors.black)
term.setCursorPos(1, 1)
term.write("\nCraft: ")
local to_write = ""
if arg[1] ~= nil then to_write = arg[1] else to_write = "" end
term.write(to_write)
term.setTextColor(colors.white)

-- Return to craft-web button
paintutils.drawBox(24, 1, 45, 1, colors.blue)
term.setCursorPos(25, 1)
term.write("Return to Craft-Web")

-- Exit button
paintutils.drawBox(45, 1, 51, 1, colors.red)
term.setCursorPos(47, 1)
term.write("Exit")

-- Reset to write
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.setCursorPos(1, 2)

-- arg[2] will be debug. It'll run on booleans.
if #arg ~= 0 then
    local cmlTable = {}
    local cmlParsedTable = {}

    local raw_str = ""
    local t, _ = term.getSize()

    local index = 0
    local x = 0
    local y = 0

    for line in io.lines(arg[1]) do
        if string.sub(line, 1, 2) == "--" then
            goto continue
        end
        cmlTable[#cmlTable+1] = line
        ::continue::
    end

    for _, value in ipairs(cmlTable) do
        raw_str = raw_str .. value .. "\n"
    end

    cmlParsedTable = parseCML(raw_str)
    while index < #cmlParsedTable do
        local word = cmlParsedTable[index + 1]
        x, y = term.getCursorPos()

        if string.match(word, "%[/?[A-Za-z]+%]") ~= nil then
            local color = string.match(word, "/?[A-Za-z]+")
            if string.sub(color, 1,1) == "/" then
                term.setTextColor(colors.white)
                index = index + 1
                goto continue
            else
                term.setTextColor(colors[color])
            end
        else
            if x + #word > t then term.setCursorPos(1, y + 1) end
            term.write(word)
        end

        index = index + 1
        ::continue::
    end

end

while true do
    os.pullEventRaw()

   local _, button, x, y = os.pullEvent("mouse_click")
   if button == 1 and (x > 41 and x < 51) and y == 1 then
        term.setBackgroundColor(colors.black)
        term.clear()
        os.queueEvent("terminate")
        if #arg ~= 0 and arg[2] == "true" then fs.delete(arg[2]); os.queueEvent("terminate"); end
    end

    if button == 1 and (x > 24 and x < 45) and y == 1 then
        term.clear()
        shell.run("craft-web nil true")
    end
    os.sleep(1)
end
