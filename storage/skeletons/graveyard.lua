--[[
    retrieves and modifies skeletons

]]

include("picotron-skeleton/gravedig.lua")
include("picotron-skeleton/skin.lua")
include("picotron-skeleton/skeleton.lua")

include("lib/vec.lua")

function player_skeleton()
    local skeleton = import(fetch("storage/skeletons/player.pod"))
    skeleton = ProceduralSkeleton:new(skeleton.core, skeleton.necromancer, false)

    -- adds skin
    local skins = {}
    skins["right arm"]      = TextureSkin:new(18, nil, Vec:new(0, 4))
    skins["right forearm"]  = TextureSkin:new(19, nil, Vec:new(0, 4))
    skins["left arm"]       = TextureSkin:new(18, nil, Vec:new(0, 4))
    skins["left forearm"]   = TextureSkin:new(19, nil, Vec:new(0, 4))

    skins["right leg"]      = TextureSkin:new(26, nil, Vec:new(0, 4))
    skins["right foreleg"]  = TextureSkin:new(27, nil, Vec:new(0, 4))
    skins["left leg"]       = TextureSkin:new(26, nil, Vec:new(0, 4))
    skins["left foreleg"]   = TextureSkin:new(27, nil, Vec:new(0, 4))

    skins["head"]           = Skin:new(11, Vec:new(-2, -2))
    skins["core"]           = Skin:new(10, Vec:new(-2, -8))

    for name, bone in pairs(skeleton.bones) do
        if (skins[name]) bone:add(skins[name])
    end


    -- removes arms from any animations
    local noanim = {
        "right arm",
        "right forearm",
        "left arm",
        "left forearm"
    }

    for name in all(noanim) do
        -- adding the bone sets its transforms to zeroes
        skeleton.necromancer:addbone(skeleton.bones[name])
    end

    return skeleton
end
