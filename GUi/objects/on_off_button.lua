local _on_off = {
    _NAME = "On/Off Button",
    _DESCRIPTION = "An on/off button object for GUi",
    _PARENT = nil,
}

function _on_off.new(text, x, y, width, height, colours, options, callback)
    local self = setmetatable({}, {__index = _on_off})
    self.text = text or "On/Off"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 50
    self.height = height or 25
    self.offColour = colours and colours.offColour or {0.5, 0.5, 0.5}
    self.downColour = colours and colours.onColour or {0.25, 0.25, 0.25}
    self.highlightColour = highlightColour or {0.75, 0.75, 0.75}
    self.offTextcolour = colours and colours.onTextColour or {0, 0, 0}
    self.onTextcolour = colours and colours.offTextColour or {0, 0, 0}

    self.roundAmount = options and options.roundAmount or 0

    self.callback = callback
    self.state = false
    self.hover = false
    
    -- add to _PARENT._MEMBERS
    self._PARENT._MEMBERS[#self._PARENT._MEMBERS + 1] = self

    -- add to self._PARENT._ON_OFF_VALUES with tag
    self._PARENT._ON_OFF_VALUES[self.text] = self.state
end

function _on_off:draw()
    if self.hover and not love.mouse.isDown(1) then
        if not self.state then
            love.graphics.setColor(self.highlightColour)
        else
            love.graphics.setColor(self.highlightColour[1]/2, self.highlightColour[2]/2, self.highlightColour[3]/2)
        end
    else
        if self.state then
            love.graphics.setColor(self.downColour)
        else
            love.graphics.setColor(self.offColour)
        end
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundAmount)

    if self.state then
        love.graphics.setColor(self.onTextcolour)
    else
        love.graphics.setColor(self.offTextcolour)
    end
    love.graphics.print(self.text, self.x + self.width / 2 - love.graphics.getFont():getWidth(self.text) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.text) / 2)
end

function _on_off:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
            self.state = not self.state
            self._PARENT._ON_OFF_VALUES[self.text] = self.state
            self.callback(self.state)
        end
    end
end

function _on_off:mousemoved(x, y, dx, dy)
    if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end
end

function _on_off:mousereleased(x, y, button)
    if button == 1 then
        
    end
end

return _on_off