local path = (...):gsub("%.init$", "") .. "."

local GUi = {
    _VERSION     = 'GUi v0.0.1', -- Pronounced "Guh I"
    _DESCRIPTION = 'A simple GUI library for LÖVE',
    _AUTHOR = "GuglioIsStupid",
    _LICENSE = [[
        MIT LICENSE

        Copyright © 2023 GuglioIsStupid

        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
        THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]],
    _MEMBERS = {},
    _OBJECTS = {},
    _SLIDERS_VALUES = {},
    _TEXT_INPUTS_VALUES = {},
    _ON_OFF_VALUES = {},
    _DROPDOWNS_VALUES = {},

    _RESOLUTION_HANDLER = "none", -- Supports: push, lovesize
    _RESOLUTION_HANDLER_FUNCS = {
        ["push"] = function(x, y) return push.toGame(x, y) end,
        ["lovesize"] = function(x, y) return lovesize.pos(x, y) end,
        ["none"] = function(x, y) return x, y end
    },

    _TRY_EXCEPT = function(t, e)
        local status, err = pcall(t)
        if not status then
            e(err)
        end
    end
}

local function init()
    GUi._OBJECTS._button = require(path .. "objects.button")
    GUi._OBJECTS._onOff = require(path .. "objects.on_off_button")
    GUi._OBJECTS._slider = require(path .. "objects.slider")
    GUi._OBJECTS._textInput = require(path .. "objects.textinput")
    GUi._OBJECTS._dropdown = require(path .. "objects.dropdown")

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
        love.graphics.setColor(1, 1, 1)
    end
end

function GUi:mousepressed(x, y, button)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousepressed then self._MEMBERS[i]:mousepressed(x, y, button) end
    end
end

function GUi:mousemoved(x, y, dx, dy)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousemoved then self._MEMBERS[i]:mousemoved(x, y, dx, dy) end
    end
end

function GUi:mousereleased(x, y, button)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].mousereleased then self._MEMBERS[i]:mousereleased(x, y, button) end
    end
end

-- Touch devices 
function GUi:touchpressed(id, x, y, dx, dy, pressure)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].touchpressed then self._MEMBERS[i]:touchpressed(id, x, y, dx, dy, pressure) end
    end
end

function GUi:touchmoved(id, x, y, dx, dy, pressure)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].touchmoved then self._MEMBERS[i]:touchmoved(id, x, y, dx, dy, pressure) end
    end
end

function GUi:touchreleased(id, x, y, dx, dy, pressure)
    local x, y = self._RESOLUTION_HANDLER_FUNCS[self._RESOLUTION_HANDLER](x, y)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].touchreleased then self._MEMBERS[i]:touchreleased(id, x, y, dx, dy, pressure) end
    end
end

function GUi:textinput(text)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].textinput then self._MEMBERS[i]:textinput(text) end
    end
end

function GUi:keypressed(key)
    for i = 1, #self._MEMBERS do
        if self._MEMBERS[i].keypressed then self._MEMBERS[i]:keypressed(key) end
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

function GUi:getTextInputValue(tag)
    --if its empty, return a space
    if self._TEXT_INPUTS_VALUES[tag] == "" or self._TEXT_INPUTS_VALUES[tag] == nil then
        return "Empty"
    end
    return self._TEXT_INPUTS_VALUES[tag]
end

function GUi:getOnOffState(tag)
    return self._ON_OFF_VALUES[tag]
end

function GUi:getDropdownValue(tag)
    return self._DROPDOWNS_VALUES[tag]
end

init()

return GUi