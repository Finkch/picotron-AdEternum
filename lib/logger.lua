--[[
    creates an object out of log.lua

]]

include("finkchlib/log.lua")

Logger = {}
Logger.__index = Logger
Logger.__type = "logger"

function Logger:new(file, directory, append)
    local l = {
        file = file,
        dir = directory,
        append = append,
        first_write = true
    }

    setmetatable(l, Logger)
    return l
end

function Logger:__call(contents)
    file = file or self.file
    local args = {}

    if (self.append and not first_write) add(args, "-a") -- clears file on first write
    if (self.dir) add(args, "-d " .. self.dir)

    log(file, contents, args)

    first_write = false
end