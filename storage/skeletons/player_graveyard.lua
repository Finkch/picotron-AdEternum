--[[
    retrieves and modifies skeletons

]]

include("picotron-skeleton/gravedig.lua")
include("picotron-skeleton/skin.lua")
include("picotron-skeleton/skeleton.lua")
include("picotron-skeleton/necromancer.lua")
include("picotron-skeleton/transform.lua")

include("lib/vec.lua")

function player_skeleton()
    local skeleton = import(fetch("storage/skeletons/pods/player.pod"))

    -- concerts the skeleton into one that supports procedural animation
    skeleton = ProceduralSkeleton:new(skeleton.core, skeleton.necromancer, false)

    -- maps skin onto the bones
    skeleton = addskin(skeleton)

    -- adds procedural animation to the arms
    skeleton = pn_arms(skeleton)


    return skeleton
end




function addskin(skeleton)

    -- gets a map of bone to skin
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

    -- applies the map
    for name, bone in pairs(skeleton.bones) do
        if (skins[name]) bone:add(skins[name])
    end

    return skeleton
end



-- [p]rocedural [n]ecromancer for arms
function pn_arms(skeleton)
    
    -- list of bones to obey this necromancer
    local noanim = {
        "right arm",
        "right forearm",
        "left arm",
        "left forearm"
    }


    -- creates the procedural animation for the arms
    local pnecromancer = ProceduralNecromancer:new(noanim)

    pnecromancer._get = function(self, bone)
        
        -- forearm angle is fixed
        if (bone == "right forearm" or bone == "left forearm") return Transform:new()
        
        -- gets direction to target
        local target = kbm.spos - cam.centre + Vec:new(0, 3) -- plus 3 is correction
        local totarget = target - (self.skeleton.bones[bone].joint)

        -- corrects for default position of each arm (t-pose)
        local rot = -totarget:dir()
        if (bone == "right arm") rot -= 0.25
        if (bone == "left arm") rot += 0.25

        -- returns appropriate rotation to aim towards target
        return Transform:new(
            Vec:new(),
            rot
        )
    end

    skeleton:addnecromancer(pnecromancer)

    return skeleton
end