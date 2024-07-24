--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-08 05:55:16",revision=635]]


-- represents the player character

include("entity.lua")

include("storage.lua")

include("finkchlib/tstr.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

-- arm sprite for texture mapping
larm = --[[pod_type="gfx"]]unpod("b64:bHo0AC0AAAArAAAA8BxweHUAQyAEEAQQHxUADg0FABIFDg0PEh4cHgwOAA4NDgAOAQ4ABg0QFvAK")
rarm = --[[pod_type="gfx"]]unpod("b64:bHo0AC4AAAAuAAAA8RJweHUAQyAIEAQRUAUPEg8VQAUPEhJAAQ4PFVABDVARDUADAIBQDw0GUBbwIw==")

function Player:new(health)

	local machine = player_state()

	local player = Entity.new(self, machine, health, 1, 12, 27)

	-- arm positions
	player.joints = {}
	player.joints["larm"] = Vec:new(3, 11)
	player.joints["rarm"] = Vec:new(8, 11)
	player.arm_length = 10
	player.arm_width = 5

	setmetatable(player, Player)
	return player
end

function Player:draw_arms()

    -- gets the position of the player's cursor
    local target = kbm.pos

    -- places the target on a circle about the player.
    -- this ensures the spread of their hands is more consistent
    local tocentre = self.pos + self.centre
    local length = 14
    local point = target - tocentre
    local target = point:normal() * length + tocentre

	local lines = 16


	
	for k, arm in pairs(self.joints) do

		-- gets the distances to each joint
		local tojoint = self.pos + arm

		-- vector that points towards the target from joint
		local totarget = target - tojoint

		-- gets the normal to the target; will be useful a few time
		local totargetnormal = totarget:normal()

		-- a vector that's the length and direction of the arm
		local tip = totargetnormal * self.arm_length

		-- where the hand ends up
		local totip = tip + tojoint

		-- select texture
		local sarm = larm
		if (k == "rarm") sarm = rarm


		if (debug_visuals) line(tojoint.x, tojoint.y, totip.x, totip.y, 8)

		local width = 4
		if (k == "rarm") width = 5

		local oo = -32
		if (k == "rarm") oo = 32

		--debug:add(totargetnormal:dir())

		-- draws the arm
		for i = 0, width * lines - 1 do -- 0 index

			local offset = Vec:new(i / lines):rotate(totip:dir())


			if (k == "larm" and i % 16 == 0) debug:add(i / lines .. " " .. tostr(offset))

			local tjo = tojoint + offset
			local tto = totip + offset

			tline3d(
				sarm, -- texture
				tjo.x + oo, tjo.y,	-- x/y 1
				tto.x + oo, tto.y,		-- x/y 2
				i / lines, 0,							-- u/v 1
				i / lines, self.arm_length				-- u/v 2
			)
		end
	end

	--[[
    -- gets absolute position to joint
    if (ttype(self.parent) == "entity") then
        self.tojoint = self.parent.pos + self.joint
    elseif (ttype(self.parent) == "appendage") then
        self.tojoint = self.parent.totip
    else
        error("unknown type for limb parent \"" .. type(self.parent) .. "\"")
    end

    -- gets a vector that points from the joint towards the target
    local totarget = self.target - self.tojoint

    -- creates the vector for the appendage
    self.tip = totarget:normal() * self.length
    self.totip = self.tip + self.tojoint
	]]
end

function Player:draw()
	
	-- back sprites
	--spr(24, self.pos.x, self.pos.y, self.left, false)

	-- main sprites
	Entity.draw(self)

	self:draw_arms()

	-- front sprites
	--spr(16, self.pos.x, self.pos.y, self.left, false)
end


-- gets player input
function Player:input()
	if (kbm:held("a")) player:accelerate(Vec:new(-0.25, 0))
	if (kbm:held("d")) player:accelerate(Vec:new(0.25, 0))
	if (kbm:held("w")) player:accelerate(Vec:new(0, -0.25))
	if (kbm:held("s")) player:accelerate(Vec:new(0, 0.25))
	if (kbm:pressed("`")) debug_visuals = not debug_visuals

	-- checks which direction the player is facing
	if (kbm:held("d") and self.acc.x > 0) then
		self.left = false
	elseif (kbm:held("a") and self.acc.x < 0) then
		self.left = true
	end
end