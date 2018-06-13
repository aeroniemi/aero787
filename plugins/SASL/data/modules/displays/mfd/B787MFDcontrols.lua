size = {637, 960}
local longButtonImage = loadImage("images/twoWidthButton.png")
local longButtonInvertedImage = loadImage("images/twoWidthButtonInverted.png")
local shortButtonImage = loadImage("images/arrowWidthButton.png")
local shortButtonInvertedImage = loadImage("images/arrowWidthButtonInverted.png")
function draw()
    drawAll(components)
    if mfdLeft == 1 then
        sasl.gl.drawTexture(longButtonInvertedImage, 10, 900, 242, 60)
        sasl.gl.drawTexture(longButtonImage, 252, 900, 242, 60)
    elseif mfdLeft == 2 then
        sasl.gl.drawTexture(longButtonImage, 10, 900, 242, 60)
        sasl.gl.drawTexture(longButtonInvertedImage, 252, 900, 242, 60)
    end
    sasl.gl.drawTexture(shortButtonImage, 529, 900, 93, 60)
    sasl.gl.drawText(fontLato, 131, 917, "MAP", 35, false, false, TEXT_ALIGN_CENTER, colourWhite)
    sasl.gl.drawText(fontLato, 383, 917, "PLAN", 35, false, false, TEXT_ALIGN_CENTER, colourWhite)
    sasl.gl.drawText(fontLato, 575, 933, "MENU", 25, false, false, TEXT_ALIGN_CENTER, colourWhite)
    if mfdLeftMenu1 == 0 then
        sasl.gl.drawTriangle(575, 920, 585, 910, 565, 910, colourWhite)
    else
        sasl.gl.drawRectangle(499, 400, 131, 500, colourGrey)
        sasl.gl.drawTriangle(575, 910, 585, 920, 565, 920, colourWhite)
    end
end

function onMouseDown(component, x, y, button, parentX, parentY)
    -- set MAP mode
    if button == MB_LEFT and x >= 10 and x <= 252 and y >= 900 and y <= 960 then
        mfdLeft = 1
    end
    -- set PLAN mode
    if button == MB_LEFT and x > 252 and x <= 504 and y >= 900 and y <= 960 then
        mfdLeft = 2
    end
    -- set MENU mode
    if button == MB_LEFT and x >= 529 and x <= 632 and y >= 900 and y <= 960 then
        if mfdLeftMenu1 == 1 then
            mfdLeftMenu1 = 0
        else
            mfdLeftMenu1 = 1
        end
    end
    return true
end
