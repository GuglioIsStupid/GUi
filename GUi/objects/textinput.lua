local _textinput = {
    _NAME = "TextInput",
    _DESCRIPTION = "A text input object for GUi",
    _USAGE = "GUi.TextInput(placeholderTxt, x, y, width, height, {colours}, {options}, callback)\nColours: {colour, textColour, placeholderColour, hoverColour}\nOptions: {roundAmount, maxChars}",
    _PARENT = nil,
}

function _textinput.new(placeholderTxt, x, y, width, height, colours, options, callback)
    local self = setmetatable({}, {__index = _textinput})
    self.tag = options.tag or "default"
    self.placeholderTxt = placeholderTxt or "Text Input"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 50
    self.height = height or 25
    self.colour = colours and colours.colour or {0.5, 0.5, 0.5}
    self.textColour = colours and colours.textColour or {0, 0, 0}
    self.placeholderColour = colours and colours.placeholderColour or {0.5, 0.5, 0.5}
    self.hoverColour = colours and colours.hoverColour or {0.6, 0.6, 0.6}
    self.roundAmount = options and options.roundAmount or 0
    self.callback = callback
    self.hover = false
    self.input = false
    self.maxChars = options and options.maxChars or 10
    
    self.text = ""
    self.placeholder = true
    
    -- add to _PARENT._MEMBERS
    self._PARENT._MEMBERS[#self._PARENT._MEMBERS + 1] = self

    -- add to self._PARENT._TEXT_INPUTS_VALUES with tag
    self._PARENT._TEXT_INPUTS_VALUES[self.tag] = self.text
    print(self._PARENT._TEXT_INPUTS_VALUES[self.tag])
end

function _textinput:update()
    self._PARENT._TEXT_INPUTS_VALUES[self.tag] = self.text
end

function _textinput:draw()
    love.graphics.setColor(self.colour)
    if self.hover and not love.mouse.isDown(1) then
        love.graphics.setColor(self.hoverColour)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundAmount)
    if self.placeholder then
        love.graphics.setColor(self.placeholderColour)
        love.graphics.print(self.placeholderTxt, self.x + self.width / 2 - love.graphics.getFont():getWidth(self.placeholderTxt) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.placeholderTxt) / 2)
    else
        love.graphics.setColor(self.textColour)
        love.graphics.print(self.text, self.x + self.width / 2 - love.graphics.getFont():getWidth(self.text) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.text) / 2)
    end

    love.graphics.setColor(1, 1, 1)
end

function _textinput:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
            self.input = true
        else
            self.input = false
        end
    end
end

function _textinput:textinput(text)
    if self.input then
        if self.placeholder then
            self.placeholder = false
            self.text = text
        else
            if #self.text < self.maxChars then
                self.text = self.text .. text
            end
        end
    end
end

function _textinput:keypressed(key)
    if self.input then
        if key == "backspace" then
            if #self.text > 0 then
                -- if there isn't 1 char left, remove it, else set it to ""
                if #self.text ~= 1 then
                    self.text = string.sub(self.text, 1, #self.text - 1)
                else
                    self.text = ""
                    self.placeholder = true
                end
            end
        end
    end
end

function _textinput:mousemoved(x, y, dx, dy)
    if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end
end

function _textinput:mousereleased(x, y, button)
    if button == 1 then
        
    end
end

return _textinput