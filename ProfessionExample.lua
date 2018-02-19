--[[
    Examples of adding or modifying professions. This should go in the lua/shared folder 
    of your mod. These are just examples showing how to create and edit, there is no 
    balance to them, and items given assume ORGM mod is loaded.

    Any of the table key/value pairs may be nil, it is not nessessary to define anything.

]]


--[[ Example of a new Sniper profession. This comes with Inconspicuous, Graceful and Brave,
    a SR-25 rifle with sling and scope attached, and spare ammo

]]
ProfessionFramework.addProfession('sniper', {
    name = "Military Sniper", -- the display name
    icon = "profession_veteran2", -- icon to use
    cost = -10, -- points available for this profession
    xp = { -- list of perks and the starting levels
        [Perks.Aiming] = 5,
        [Perks.Reloading] = 2,
        [Perks.Sneak] = 2,
        [Perks.Lightfoot] = 1,
    },
    traits = {"Inconspicuous2", "Graceful2", "Brave2"}, -- traits to add
    recipes = {}, -- no free recipies for this profession, this line can be deleted
    inventory = { -- inventory items to add
        ["ORGM.SR25"] = 1,
        ["ORGM.SR25Mag"] = 2,
        ["ORGM.Ammo_762x51mm_FMJ_Box"] = 3,
    },
    square = {}, -- items to drop on the floor on start, no items, so this line can be delete
    OnNewGame = function(player, square, profession) -- function to run OnNewGame event
        local item = player:getInventory():FindAndReturn("ORGM.SR25")
        item:attachWeaponPart(InventoryItemFactory.CreateItem("ORGM.8xScope"))
        item:attachWeaponPart(InventoryItemFactory.CreateItem("ORGM.Rifsling"))
    end,
})

--[[  Example editing the park ranger profession. Changing its cost from -4 to -6, setting perks to 
    lvl 3 (from 2) adding the outdoorsman trait, starting with a big hiking bag, lee enfield no4 rifle 
    with scope and sling attached, as well as a tent and campfire kit on the ground where he/she spawns.

]]
ProfessionFramework.addProfession('parkranger', {
    cost = -6,
    xp = {
        [Perks.Trapping] = 3,
        [Perks.PlantScavenging] = 3,
        [Perks.Woodwork] = 3,
    },
    traits = {"Outdoorsman2"},
    -- these recipes are already given to the park ranger, but defined here as a example.
    recipes = {"Make Stick Trap", "Make Snare Trap", "Make Wooden Cage Trap", "Make Trap Box", "Make Cage Trap"},
    inventory = {
        ["ORGM.LENo4"] = 1,
        ["ORGM.LENo4Mag"] = 2,
        ["ORGM.Ammo_762x51mm_FMJ_Box"] = 3,
        ["Base.NormalHikingBag"] = 1,
    },
    square = {
        ["camping.CampingTentKit"] = 1,
        ["camping.CampfireKit"] = 1,
    },
    OnNewGame = function(player, square, profession)
        local item = player:getInventory():FindAndReturn("ORGM.LENo4")
        item:attachWeaponPart(InventoryItemFactory.CreateItem("ORGM.2xScope"))
        item:attachWeaponPart(InventoryItemFactory.CreateItem("ORGM.Rifsling"))
    end,
})


--[[ Example of editing the Chef profession, simply adding starting equipment
    a set of GOOD kitchen knifes
]]
ProfessionFramework.addProfession('chef', {
    inventory = {
        ["Base.KitchenKnife"] = 6,
    },
    OnNewGame = function(player, square, profession)
        local knives = player:getInventory():FindAll("Base.KitchenKnife")
        for i=1,knives:size() do
            local knife = knives:get(i-1)
            knife:setName("Fancy Kitchen Knife")
            knife:setConditionLowerChance(10)
        end
    end,
    
})
