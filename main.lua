function love.load()
    GUi = require("GUi")

    GUi.Button("Button", 100, 100, 50, 25, 
        {offColour = {0.5, 0.5, 0.5}, onColour = {0.25, 0.25, 0.25}, highlightColour = {0.75, 0.75, 0.75},
        offTextColour = {0, 0, 0}, onTextColour = {0, 0, 0}}, {roundAmount = 2.5}, function()
            print("Pressed!")
        end
    )

    GUi.On_off("On/Off", 100, 200, 50, 25, 
        {offColour = {0.5, 0.5, 0.5}, onColour = {0.25, 0.25, 0.25}, highlightColour = {0.75, 0.75, 0.75},
        offTextColour = {0, 0, 0}, onTextColour = {0, 0, 0}}, {roundAmount = 2.5}, function(state)
            print("The button is " .. (state and "on" or "off"))
        end
    )

    GUi.Slider("Slider", 100, 300, 200, 25, 
        {knobOffColour = {0.5, 0.5, 0.5, 0.5}, knobDownColour = {0.25, 0.25, 0.25, 0.5}, knobHighlightColour = {0.75, 0.75, 0.75}, 0.75,
        colour = {0.5, 0.5, 0.5}, valueColour = {0.5, 0, 0}}, {roundAmount = 2.5, knobRoundAmount = 2.5, min = 0, max = 100, value = 50}, function(value)
            print(value)
        end
    )
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

function love.draw()
    GUi:draw()

    -- print GUi:getSliderValue("Slider")
    love.graphics.print(GUi:getSliderValue("Slider"), 100, 400)
end