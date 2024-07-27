--[[
    used to make permanent alterations to a pod

]]

include("lib/tstr.lua")

include("picotron-skeleton/skeleton.lua")

-- [m]odify, [s]tore, [f]etch
-- make permanent modifications to the skeleton.
-- path is relative to AE: ex, "storage/skeletons/pods/player.pod"
function msf(obj, path)
    path = "/ram/cart/" .. path

    cd(env().path)

    obj = modify(obj)

    put(path, obj)

    return get(path)
end


function put(path, obj)
    store(path, obj:pod())
end

function get(path)
    local tbl = fetch(path)

    if (not fstat(path)) error("invalid path \"" .. path .. "\"")
    if (not tbl) error("unable to get pod at path \"" .. path .. "\"")

    return objectify(tbl)
end



-- this should be overridden or editted
function modify(obj) return obj end




-- looks through a table of types and returns the applicable object instance
function objectify(tbl)

    if (tbl.__type == "pod") then
        if (tbl.__totype == "skeleton") then
            return Skeleton:new(tbl)
        elseif (tbl.__totype == "proceduralskeleton") then
            return ProceduralSkeleton:new(tbl)
        end
    end

    logger(time() .. "\n\n" .. tstr(tbl), "depod.txt")
    error("cannot objectify unknown .__type \"" .. tostr(tbl.__type) .. "\" -> \"" .. tostr(tbl.__totype) .. "\". see 'appdata/ae/logs/depod.txt' for table readout")
end