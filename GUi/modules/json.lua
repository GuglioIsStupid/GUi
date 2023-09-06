local _JSON = {
    _VERSION = "JSON v0.0.1 - GUi v0.0.1",
    _NAME = "JSON",
    _DESCRIPTION = "A very small and simple JSON library for Lua, doesn't decode, only encodes",
    _AUTHOR = "GuglioIsStupid",
    _LICENSE = [[
        MIT LICENSE
    ]]
}

local function init()
    function _JSON.encode(t)
        local s = "{"
        for k, v in pairs(t) do
            if type(k) == "string" then
                s = s .. "\"" .. k .. "\":"
            end
            if type(v) == "string" then
                s = s .. "\"" .. v .. "\","
            elseif type(v) == "number" then
                s = s .. v .. ","
            elseif type(v) == "boolean" then
                s = s .. tostring(v) .. ","
            elseif type(v) == "table" then
                s = s .. _JSON.encode(v) .. ","
            end
        end
        s = s:sub(1, -2)
        s = s .. "}"
        return s
    end 
end

init()

return _JSON