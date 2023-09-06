local path = (...):gsub("%.init$", "") .. "."

local GUi = {
    _VERSION     = 'GUi v0.0.1', -- Pronounced "Guh I"
    _DESCRIPTION = 'A simple GUI library for LÖVE',
    _AUTHOR = "GuglioIsStupid",
    _LICENSE = [[
        MIT LICENSE
    ]],
    _MEMBERS = {},
    _OBJECTS = {},
    _SLIDERS_VALUES = {},

    _JSON = require(path .. "modules.json")
}

local function init()
    GUi._OBJECTS._button = require(path .. "objects.button")
    GUi._OBJECTS._on_off = require(path .. "objects.on_off_button")
    GUi._OBJECTS._slider = require(path .. "objects.slider")

    -- Set functions -- Sp you can call GUi.Button() instead of GUi._button.new()
    for k, v in pairs(GUi._OBJECTS) do
        --remove _
        _k = k:gsub("^_", "")
        -- capitalise first letter
        _k = _k:gsub("^%l", string.upper)
        GUi[_k] = v.new
        print("GUi: Added " .. _k .. " to GUi", k)
        
        GUi._OBJECTS[k]._PARENT = GUi
    end
end

function GUi:draw()
    for i = 1, #self._MEMBERS do
        self._MEMBERS[i]:draw()
    end
end

function GUi:mousepressed(x, y, button)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousepressed then self._MEMBERS[i]:mousepressed(x, y, button) end
    end
end

function GUi:mousemoved(x, y, dx, dy)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousemoved then self._MEMBERS[i]:mousemoved(x, y, dx, dy) end
    end
end

function GUi:mousereleased(x, y, button)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousereleased then self._MEMBERS[i]:mousereleased(x, y, button) end
    end
end

function GUi:update(dt)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].update then self._MEMBERS[i]:update(dt) end
    end
end

function GUi:getSliderValue(tag)
    return self._SLIDERS_VALUES[tag]
end

init()

--print(GUi._JSON.encode({["balls"] = true, {1,2,3,4, ["hihi"]=false}})) -- was bored loolll

return GUi