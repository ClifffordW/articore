
print("Articore Worldgen")
print("------------------------------")

--AddLayout first name of layout then filename

--AddRooms specify filename of the rooms

--AddRoomLayout first name of room then layout (Optional)

--AddTask

--location = "caves" or "forest"

--CreateStartLoc Location of Start, Name, location, task

--AddLevelTask specify name of task and name of the level

--ChangeSpawn  Location of start and location

--SetupTask name of task, regionid, is island, has lunacy, has sandstorm, choice, choice2, choice3 Scrapped idea

AddBiome = AddTaskSet
rooms = set_pieces

function SetWorldType(level_type)
    ol_type = level_type
    level_types =
    {

        default = "scripts/map/tasks/default_tasks",

        islands = "scripts/map/tasks/island_tasks",
    }
    
    level_type = level_types[level_type]
    
    modimport(level_type)
    
    if ol_type == "islands" then
        print("-------------------")
        print("Islands are used")
    elseif ol_type == "default" then
        print("-------------------")
        print("Mainland is used")
        
    end
    
end

function AddRooms(filename)
    
    if filename ~= "" or filename ~= nil then
        print("------------------------------")
        modimport("scripts/map/rooms/"..filename.."_rooms")
        print("Imported: "..filename.."_rooms.lua")
        filtex = filename
        
    else
        
        print("------------------------------")
        print("No rooms found.")
        
    end
end

_G = GLOBAL

require = require

if TheFrontEnd then
    TheFrontEnd = TheFrontEnd
end

STRINGS = STRINGS
GROUND = GROUND
NODE_TYPE = NODE_TYPE
KEYS = KEYS
NODE_INTERNAL_CONNECTION_TYPE = NODE_INTERNAL_CONNECTION_TYPE

Layouts = require("map/layouts").Layouts
StaticLayout = require("map/static_layout")

layouts_path = "map/static_layouts/"
local namet = nil
local locationn = nil
local filtex = nil

function AddLayout(name, filename)
    
    if name ~= nil or name ~= "" then
        print("------------------------------")
        print("Layout Name: "..name.."\nFile Name: "..filename..".lua")
        Layouts[name] = StaticLayout.Get(layouts_path..""..filename)
        
        namet = name
        
    end
    
end

function AddLevelTask(task, location)
    
    if task ~= nil or task ~= "" then
        
        AddLevelPreInitAny(function(level)
            if level.location ~= location then
                
                return
            end
            
            table.insert(level.tasks, task)
        end)
        print("------------------------------")
        
        if location == "forest" then
            locationn = "Forest"
        elseif location == "caves" then
            locationn = "Caves"
        elseif location == "" or location == nil then
            location = "forest"
            locationn = "Forest"
        end
        locationn = locationn
        
        print("Task "..task.." has been successfully added to "..locationn.." level")
        
    else
        
        print("------------------------------")
        print("No task was added.")

    end
    

end


function AddRoomLayout(room_n, layout)
    print(namet)
    if room_n ~= "" and layout ~= "" and namet ~= "" and namet ~= nil then
        AddRoomPreInit(room_n, function(room)
            if not room.contents.countstaticlayouts then
                room.contents.countstaticlayouts = {}
            end
            room.contents.countstaticlayouts[layout] = 1
        end)
        print("Added Layout "..layout.." to room: "..room_n)
        print("------------------------------")
        
        room_nc = room_n
        
    end


end

--[[function SetupTask(name, region, opt1, opt2, opt3, choice, choice2, choice3, location)
    if opt1 == true then
    opt1 = "not_mainland"
    end
 
    if opt2 == true then
    opt2 = "lunacy"
    end
 
    if opt3 == true then
    opt3 = "sandstorm"
    end
 
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    if choice ~= nil then
    choice = choice
    else
    choice = "Blank"
    end
 
 
 
    if choice2 ~= nil then
    choice2 = choice2
    else
    choice2 = "Blank"
    end
 
 
 
 
 
 
    if choice3 ~= nil then
    choice3 = choice3
    else
    choice3 = "Blank"
    end
 
 
AddTask(name, {
        locks={},
        keys_given={KEYS.MOUNTAIN_ISLAND},
        region_id = region,
        room_tags = {"RoadPoison", opt1, opt2, opt3},
        room_choices =
        {
            [choice] = 1, --number of rooms
            [choice2] = 1,
            [choice3] = 1,
 
        },
        room_bg = GROUND.IMPASSABLE,
        background_room = "Empty_Cove2", 
        cove_room_name = "BGImpassable",
        make_loop = false,
        crosslink_factor = 2,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour={r=0,g=0,b=0,a=0},
    })
 
 
 
 
 
 
 
 
 
 
 
    AddLevelTask(name, location)
 
end--]]

function CreateStartLoc(start_location, name, location, task, room)
    start_room = "start_node"
    start_task = "start_setpiece"
    
    AddStartLocation(start_location, {
        name = name,
        location = location,
        start_task = task,
        start_room = room
    })
    if location == "forest" then
        locationn = "Forest"
    elseif location == "caves" then
        locationn = "Caves"
    elseif location == "" or location == nil then
        location = "forest"
        locationn = "Forest"
    end
    print("------------------------------")
    print("Created start location " ..name.. " in "..location)

end

function ChangeSpawn(startloc, location)

    
    AddLevelPreInitAny(function(level)
        if level.location ~= location then
            
            return
        end
        
        level.overrides.start_location = startloc
        
    end)
    
    if location == "forest" then
        locationn = "Forest"
    elseif location == "caves" then
        locationn = "Caves"
    elseif location == "" or location == nil then
        location = "forest"
        locationn = "Forest"
    end
    print("Spawn has been successfully changed to "..startloc)
    
end

red_gen_imported = true
print("Worldgen version of Articore Loaded..")
print("Version 3.0.0")
print("Author: Clifford W.")
