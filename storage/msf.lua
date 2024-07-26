--[[
    used to make permanent alterations to a pod

]]

include("lib/tstr.lua")

include("picotron-skeleton/skeleton.lua")

-- [m]odify, [s]tore, [f]etch
-- make permanent modifications to the skeleton.
-- path is relative to AE! ex, "storage/skeletons/pods/player.pod"
function msf(obj, path)

    obj  = modify(obj)

    store(path, export(obj))

    return get(path)
end

function modify(obj) return obj end         -- this should be overridden or editted

function put(path, obj)
    store(path, obj:pod())
end

function get(path)
    return unpod(fetch(path))
end


-- looks through a table of types and returns the applicable object instance
function objectify(data)

    local tbl = unpod(data)

    if (tbl.__type == "skeleton") then
        return Skeleton:new(tbl)
    elseif (tbl.__type == "proceduralskeleton") then
        return ProceduralSkeleton:new(tbl)
    else
        logger(time() .. "\n\n" .. tstr(tbl), "depod.txt")
        error("cannot objectify unknown .__type \"" .. tostr(tbl.__type) .. "\". see 'appdata/ae/logs/depod.txt' for table readout")
    end
end