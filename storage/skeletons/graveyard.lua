--[[
    retrieves and modifies skeletons

]]

include("picotron-skeleton/gravedig.lua")
include("picotron-skeleton/skin.lua")

include("lib/vec.lua")

function player_skeleton()
    local skeleton = import(fetch("storage/skeletons/player.pod"))
    skeleton.debug = false

    -- adds skin
    local skins = {}
    skins["right arm"] = TextureSkin:new(18, nil, Vec:new(0, 4))
    skins["right forearm"] = TextureSkin:new(19, nil, Vec:new(0, 4))
    skins["left arm"] = skins["right arm"]
    skins["left forearm"] = skins["right forearm"]

    skins["right leg"] = TextureSkin:new(26, nil, Vec:new(0, 4))
    skins["right foreleg"] = TextureSkin:new(27, nil, Vec:new(0, 4))
    skins["left leg"] = skins["right leg"]
    skins["left foreleg"] = skins["right foreleg"]

    skins["head"] = Skin:new(11, Vec:new(-2, -2))
    skins["core"] = Skin:new(10, Vec:new(-2, -8))

    for name, bone in pairs(skeleton.bones) do
        if (skins[name]) bone:add(skins[name])
    end

    return skeleton
end
