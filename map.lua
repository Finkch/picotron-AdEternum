--[[pod_format="raw",created="2024-07-06 21:58:37",modified="2024-07-06 23:43:58",revision=464]]
--[[
	contains functions for the map
]]

-- tile size
tw = nil
th = nil

function init_map(tile_width, tile_height)
	tw = tile_width -- tile width
	th = tile_height -- tile height
end

-- converts coordinates to tile coordinates
function ct(x, y)
	return x // tw, y // th
end

-- checks whether a flag of a given tile is set
function flag(x, y, n, tiles)
	if (not tiles) x, y = ct(x, y)
	
	-- this may need to change for other flags
	return fget(mget(x, y), n) == 1
end