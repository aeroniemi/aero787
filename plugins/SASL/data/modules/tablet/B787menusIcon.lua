size = {250, 63}

local backgroundImage = loadImage("main/background.png")
local iconImage = loadImage("main/iconDark1.png")

function draw()
    --sasl.gl.drawTexture(backgroundImage, 0, 0, 60, 60)
    sasl.gl.drawTexture(iconImage, 0, 0, 250, 63)
    drawAll(components)
end
