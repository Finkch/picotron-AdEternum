--[[
    creates an object out of log.lua

]]

include("finkchlib/log.lua")

Logger = {}
Logger.__index = Logger
Logger.__type = "logger"

function Logger:new(directory, file, append)
    if (not append) append = true
    local l = {
        dir = directory,
        file = file,
        append = append,
        writes = {}         -- tracks which files have been written to
    }

    setmetatable(l, Logger)
    return l
end

function Logger:__call(contents, file, append)
    
    -- gets defaults
    file = file or self.file
    append = append or self.append

    -- checks if this file has been written to so far this execution
    local first_write = false
    if (not self.writes[file]) then
        self.writes[file] = true
        first_write = true
    end

    -- builds arguments
    local args = {}
    if (append and not first_write) add(args, "-a") -- clears file on first write
    if (self.dir) add(args, "-d " .. self.dir)

    -- logs
    log(file, contents, args)
end