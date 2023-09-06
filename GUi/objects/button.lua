local _button = {
    _NAME = "Button",
    _DESCRIPTION = "A button object for GUi",
    _USAGE = "GUi.Button(text, x, y, width, height, {colours}, {options}, callback)\nColours: {offColour, onColour, offTextColour, onTextColour}\nOptions: {roundAmount}",
    _PARENT = nil,
}

function _button.new(text, x, y, width, height, colours, options, callback)
    local self = setmetatable({}, {__index = _button})
    self.text = text or "Button"
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
    self.hover = false
    
    -- add to _PARENT._MEMBERS
    self._PARENT._MEMBERS[#self._PARENT._MEMBERS + 1] = self
end

function _button:draw()
    if self.hover and not love.mouse.isDown(1) then
        love.graphics.setColor(self.highlightColour)
    else
        if love.mouse.isDown(1) and self.hover then
            love.graphics.setColor(self.downColour)
        else
            love.graphics.setColor(self.offColour)
        end
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundAmount)
   
    if love.mouse.isDown(1) and self.hover then
        love.graphics.setColor(self.onTextcolour)
    else
        love.graphics.setColor(self.offTextcolour)
    end
    love.graphics.print(self.text, self.x + self.width / 2 - love.graphics.getFont():getWidth(self.text) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.text) / 2)
end

function _button:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
            self.callback(self.state)
        end
    end
end

function _button:mousemoved(x, y, dx, dy)
    if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end
end

function _button:mousereleased(x, y, button)
    if button == 1 then
        
    end
end

return _button