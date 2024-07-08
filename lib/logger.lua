--[[
    creates an object out of log.lua

]]

include("finkchlib/log.lua")

Logger = {}
Logger.__index = Logger
Logger.__type = "logger"

function Logger:new(directory, file, append)
    local l = {
        dir = directory,
        file = file,
        append = append,
        first_write = true
    }

    setmetatable(l, Logger)
    return l
end

function Logger:__call(contents, file, append)
    file = file or self.file
    append = append or self.append
    local args = {}

    if (append and not first_write) add(args, "-a") -- clears file on first write
    if (self.dir) add(args, "-d " .. self.dir)

    log(file, contents, args)

    first_write = false
end