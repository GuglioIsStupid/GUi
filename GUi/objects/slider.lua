local _slider = {
    _NAME = "Slider",
    _DESCRIPTION = "A slider object for GUi",
    _USAGE = "GUi.Slider(tag, x, y, width, height, {colours}, {options}, callback)\nColours: {colour, valueColour, knobOffColour, knobDownColour, knobHighlightColour}\nOptions: {roundAmount, knobRoundAmount, min, max}",
    _PARENT = nil,
}

function _slider.new(tag, x, y, width, height, colours, options, callback)
    local self = setmetatable({}, {__index = _slider})

    self.tag = tag or "Slider"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 50
    self.height = height or 25

    self.knobOffColour = colours and colours.knobOffColour or {0.5, 0.5, 0.5, 1}
    self.knobDownColour = colours and colours.knobDownColour or {0.25, 0.25, 0.25, 1}
    self.knobHighlightColour = colours and colours.knobHighlightColour or {0.75, 0.75, 0.75, 1}
    self.colour = colours and colours.colour or {0.5, 0.5, 0.5}
    self.valueColour = colours and colours.valueColour or {0.5, 0, 0}

    self.roundAmount = options and options.roundAmount or 0
    self.knobRoundAmount = options and options.knobRoundAmount or 0

    self.callback = callback or function() end
    self.hover = false
    self.dragging = false
    self.value = 0
    self.min = options and options.min or 0
    self.max = options and options.max or 100
   
    -- add to _PARENT._MEMBERS
    self._PARENT._MEMBERS[#self._PARENT._MEMBERS + 1] = self

    -- add to self._PARENT._SLIDERS_VALUES with tag
    self._PARENT._SLIDERS_VALUES[self.tag] = self.value
end

function _slider:update()
    self._PARENT._SLIDERS_VALUES[self.tag] = self.value
end

function _slider:draw()
    love.graphics.setColor(self.colour)
    love.graphics.rectangle("fill", self.x, self.y + self.height / 2 - self.height / 4, self.width, self.height / 2, self.roundAmount)

    love.graphics.setColor(self.valueColour)
    if self.value ~= self.min then
        love.graphics.rectangle("fill", self.x, self.y + self.height / 2 - self.height / 4, self.width * (self.value / self.max), self.height / 2, self.roundAmount)
    end
    if self.hover and not love.mouse.isDown(1) then
        love.graphics.setColor(self.knobHighlightColour)
    else
        if self.dragging then
            love.graphics.setColor(self.knobDownColour)
        else
            love.graphics.setColor(self.knobOffColour)
        end
    end
    love.graphics.rectangle("fill", self.x + self.width * (self.value / self.max) - self.height / 2, self.y, self.height, self.height, self.knobRoundAmount)

    love.graphics.setColor(1, 1, 1)
end

function _slider:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x + self.width * (self.value / self.max) - self.height / 2 and x <= self.x + self.width * (self.value / self.max) + self.height / 2 and y >= self.y and y <= self.y + self.height then
            self.dragging = true
        end
    end
end

function _slider:mousemoved(x, y, dx, dy)
    if x >= self.x + self.width * (self.value / self.max) - self.height / 2 and x <= self.x + self.width * (self.value / self.max) + self.height / 2 and y >= self.y and y <= self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end

    if self.dragging then
        self.value = math.floor((x - self.x) / self.width * self.max)
        if self.value < self.min then self.value = self.min end
        if self.value > self.max then self.value = self.max end
        self.callback(self.value)
    end
end

function _slider:mousereleased(x, y, button)
    if button == 1 then
        self.dragging = false
    end
end

return _slider