size = {600, 600}

local backgroundImage = loadImage("main/background.png")

function draw()
    sasl.gl.drawTexture(backgroundImage, 0, 0, 600, 600)
    drawAll(components)
end
