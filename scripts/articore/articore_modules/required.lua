
local function KleiID()
    return TheNet:GetUserID()
end

local function CurrentScreen(redux, screen)
    return redux and "screens/redux/"..screen or "screens/"..screen
end

local cliff_funcs = {
    KleiID = KleiID,
    CurrentScreen = CurrentScreen
}

return cliff_funcs
















