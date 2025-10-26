local tower = peripheral.wrap("radio_tower_0")
local modem = peripheral.wrap("back")

if tower ~= nil and modem == nil then
    local function trim(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
    end

    while true do
        local _, _, msg, _ = os.pullEvent("radio_message")

        local cmd, port, path, freq = msg:match("^(%S+)%s+(%d+)%s+(.+)%s+(%d+)$")
        port = trim(port)
        cmd = trim(cmd)
        path = trim(path)
        freq = trim(freq)

        tower.setFrequency(tonumber(freq))
        if port ~= tostring(os.getComputerID()) then
            goto continue
        else
            if cmd == "GET" then
                if fs.exists(path) then
                    local cmlFile = fs.open(path, "r") 
                    tower.broadcast(cmlFile.readAll())
                    tower.setFrequency(0)
                else
                    tower.broadcast("Error: File doesn't exist")
                    tower.setFrequency(0)
                end
            end
        end

        ::continue::
    end
elseif modem ~= nil and tower == nil then
    rednet.open("back")
    while true do
        local cwComputer, path, method = rednet.receive()

        if method == "GET" then
            local cmlFile = fs.open(path, "r")
            if cmlFile == nil then rednet.send(tonumber(cwComputer), "File could not be accessed or found", "404") end
            rednet.send(tonumber(cwComputer), cmlFile.readAll(), "200")
        end
    end
end