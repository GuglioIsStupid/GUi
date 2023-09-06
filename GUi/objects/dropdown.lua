local _dropdown = {
    _NAME = "Dropdown",
    _DESCRIPTION = "A text input object for GUi",
    _USAGE = "GUi.Dropdown(text, x, y, width, height, selects, {colours}, {options}, callback)\nColours: {colour, optionColour, textColour, hoverColour}\nOptions: {roundAmount}",
    _PARENT = nil,
}

function _dropdown.new(text, x, y, width, height, selects, colours, options, callback)
    local self = setmetatable({}, {__index = _dropdown})
    self.tag = options and options.tag or "default"
    self.text = text or "Dropdown"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 50
    self.height = height or 25
    
    self.selects = selects or {"Option 1", "Option 2", "Option 3"}
    self.select = 0 -- display text instead of index

    self.colour = colours and colours.colour or {0.5, 0.5, 0.5}
    self.optionColour = colours and colours.optionColour or {0.5, 0.5, 0.5}
    self.textColour = colours and colours.textColour or {0, 0, 0}
    self.hoverColour = colours and colours.hoverColour or {0.6, 0.6, 0.6}
    
    self.roundAmount = options and options.roundAmount or 0
    self.callback = callback or function() end

    self.hover = false
    self.open = false
    self.selected = false

    -- add to _PARENT._MEMBERS
    self._PARENT._MEMBERS[#self._PARENT._MEMBERS + 1] = self

    -- add to self._PARENT._DROPDOWNS_VALUES with tag
    self._PARENT._DROPDOWNS_VALUES[self.text] = {index = self.select, string = self.selects[self.select] or "None"}
end

function _dropdown:update()
    self._PARENT._DROPDOWNS_VALUES[self.text] = {index = self.select, string = self.selects[self.select] or "None"}
end

function _dropdown:draw()
    love.graphics.setColor(self.colour)
    if self.hover and not love.mouse.isDown(1) then
        love.graphics.setColor(self.hoverColour)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundAmount)
    love.graphics.setColor(self.textColour)
    if self.select == 0 then
        love.graphics.print(self.text, self.x + self.width / 2 - love.graphics.getFont():getWidth(self.text) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.text) / 2)
    else
        love.graphics.print(self.selects[self.select], self.x + self.width / 2 - love.graphics.getFont():getWidth(self.selects[self.select]) / 2, self.y + self.height / 2 - love.graphics.getFont():getHeight(self.selects[self.select]) / 2)
    end

    if self.open then
        for i = 1, #self.selects do
            love.graphics.setColor(self.optionColour)
            if self.hover and not love.mouse.isDown(1) then
                love.graphics.setColor(self.hoverColour)
            end
            love.graphics.rectangle("fill", self.x, self.y + self.height * i, self.width, self.height, self.roundAmount)
            love.graphics.setColor(self.textColour)
            love.graphics.print(self.selects[i], self.x + self.width / 2 - love.graphics.getFont():getWidth(self.selects[i]) / 2, self.y + self.height * i + self.height / 2 - love.graphics.getFont():getHeight(self.selects[i]) / 2)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function _dropdown:mousepressed(x, y, button)
    if button == 1 then
        if self.open then
            for i = 1, #self.selects do
                if x >= self.x and x <= self.x + self.width and y >= self.y + self.height * i and y <= self.y + self.height * i + self.height then
                    self.select = i
                    self.open = false
                    self.selected = true
                    self.callback(self.select)
                end
            end
        end

        if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
            self.open = not self.open
        else
            self.open = false
        end
    end
end

function _dropdown:mousemoved(x, y, dx, dy)
    if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self.hover = true
    else
        self.hover = false
    end
end

function _dropdown:mousereleased(x, y, button)
    if button == 1 then
        
    end
end

return _dropdown 