# GUi (Guh I) ((Bad name, I know))

## What is GUi?
GUi is a GUI library for LOVE2D, It is designed to be easy to use, easy to understand, and easy to implement.

# Available Widgets
- Button
- Dropdown
- On/Off Switch
- Slider
- Textbox

# How to use
```lua
function love.load()
    GUi = require("path.to.GUi")

    GUi.Button("text", x, y, width, height, {colours}, {options}, callback)
    -- Colours: {offColour = {}, onColour = {}, offTextColour = {}, onTextColour = {}}
    -- Options: Options: {roundAmount = 10}

    GUi.Dropdown("text", x, y, width, height, {dropdowns}, {colours}, {options}, callback)
    -- Colours: {colour = {}, optionColour = {}, textColour = {}, hoverColour = {}}
    -- Options: {roundAmount = 0, tag = "default"}"

    GUi.OnOff("text", x, y, width, height, {colours}, {options}, callback)
    -- Colours: {offColour, onColour, offTextColour, onTextColour}
    -- Options: {roundAmount = 0}

    GUi.Slider("text", x, y, width, height, {colours}, {options}, callback)
    -- Colours: {colour = {}, valueColour = {}, knobOffColour = {}, knobDownColour = {}, knobHighlightColour = {}}
    -- Options: {roundAmount = 0, knobRoundAmount = 0, min = 0, max = 100}

    GUi.TextInput("text", x, y, width, height, {colours}, {options}, callback)
    -- Colours: {colour = {}, textColour = {}, placeholderColour = {}, hoverColour ={}} 
    -- Options: {roundAmount = 0, maxChars = 10, tag = "default}
end

function love.update(dt)
    GUi:update(dt)
end

function love.mousepressed(x, y, button)
    GUi:mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    GUi:mousemoved(x, y, dx, dy)
end

function love.mousereleased(x, y, button)
    GUi:mousereleased(x, y, button)
end

-- For mobile devices --
function love.touchpressed(id, x, y, dx, dy, pressure)
    GUi:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    GUi:touchmoved(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    GUi:touchreleased(id, x, y, dx, dy, pressure)
end

-- End mobile device functions --

function love.textinput(text)
    GUi:textinput(text)
end

function love.keypressed(key)
    GUi:keypressed(key)
end

function love.draw()
    GUi:draw()
end

```

# Get a widgets value (if applicable)
```lua
GUi:getOnOffState(name)
GUi:getSliderValue(name)
GUi:getDropdownValue(name)
GUi:getTextInputValue(name)
```

# Support for resolution Handlers (e.g. push, lovesize)
Got a resolution handler you want to make this work with?

Simply just add this line to your resolution handler to the applicable name.
```lua
GUi._RESOLUTION_HANDLER = "push" or "lovesize"
```

Got a different resolution handler? Don't worry! It's really simple to simply add your own.

```lua
GUi._RESOLUTION_HANDLER_FUNCS["your_resolution_handler"] = function(x, y)
    -- convert x and y to game position
    return x, y
end
GUI._RESOLUTION_HANDLER = "your_resolution_handler"
```

# I want *this* widget!
If you want a widget that isn't here, feel free to make a pull request, or make an issue with the widget you want. I will try to add it as soon as possible.

# I found a bug!
If you find a bug, please make an issue with the bug you found, and how to reproduce it. I will try to fix it as soon as possible.
