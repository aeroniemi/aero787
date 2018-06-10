size = {638, 960}
local arrowImage = loadImage("images/arrowMfd.png")
local tat = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")
local egt = globalPropertyfa("sim/cockpit2/engine/indicators/EGT_deg_C")
local n1 = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent")
local n2 = globalPropertyfa("sim/cockpit2/engine/indicators/N2_percent")
local oilPress = globalPropertyfa("sim/cockpit2/engine/indicators/oil_pressure_psi")
local oilTemp = globalPropertyfa("sim/cockpit2/engine/indicators/oil_temperature_deg_C")
local oilQty = globalPropertyfa("sim/flightmodel/engine/ENGN_oil_quan")
function draw()
    local airTemp = 0
    if get(tat) < 0 then
        airtemp = string.format("%02.f", get(tat))
    else
        airTemp = "+" .. string.format("%02.f", get(tat))
    end

    sasl.gl.drawText(fontLatoBold, 35, 940, "TAT", 25, false, false, TEXT_ALIGN_LEFT, colourCyan)

    --sasl.gl.drawArc(100, 800, 0, 75, -225, 4, colourCyan)
    local egtn = get(egt)
    local n1n = get(n1)
    local n2n = get(n2)

    sasl.gl.drawText(fontLatoBold, 95, 940, airTemp .. "c", 25, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 95, 940, airTemp .. "c", 25, false, false, TEXT_ALIGN_LEFT, colourWhite)

    -- EGT
    local egt1angle = egtn[1] * -1 / 4
    local egt2angle = egtn[2] * -1 / 4
    sasl.gl.drawWidePolyLine({101, 681, 186, 681, 186, 721, 101, 721, 101, 681}, 2, colourWhite)
    sasl.gl.drawWidePolyLine({301, 681, 386, 681, 386, 721, 301, 721, 301, 681}, 2, colourWhite)
    --EN1
    sasl.gl.drawArc(100, 680, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(100, 680, 0, 75, 0, egt1angle, colourGrey)
    sasl.gl.drawText(
        fontLatoBold,
        176,
        690,
        string.format("%02.f", egtn[1]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawWideLine(
        100,
        680,
        100 + (75 * math.cos(egt1angle * 0.0174533)),
        680 + (75 * math.sin(egt1angle * 0.0174533)),
        2,
        colourWhite
    )
    --EN2
    sasl.gl.drawArc(300, 680, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(300, 680, 0, 75, 0, egt2angle, colourGrey)
    sasl.gl.drawText(
        fontLatoBold,
        376,
        690,
        string.format("%02.f", egtn[2]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawWideLine(
        300,
        680,
        300 + (75 * math.cos(egt2angle * 0.0174533)),
        680 + (75 * math.sin(egt2angle * 0.0174533)),
        2,
        colourWhite
    )
    --N2
    local n21angle = n2n[1] * -1 * 2.2166
    local n22angle = n2n[2] * -1 * 2.2166
    local n21horz = math.cos(n21angle * 0.0174533)
    local n21vert = math.sin(n21angle * 0.0174533)
    --EN1
    sasl.gl.drawWidePolyLine({101, 511, 186, 511, 186, 551, 101, 551, 101, 511}, 2, colourWhite)
    sasl.gl.drawWidePolyLine({301, 511, 386, 511, 386, 551, 301, 551, 301, 511}, 2, colourWhite)
    sasl.gl.drawArc(100, 510, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(100, 510, 0, 75, 0, n21angle, colourGrey)
    sasl.gl.drawWideLine(
        100,
        510,
        100 + (75 * math.cos(n21angle * 0.0174533)),
        510 + (75 * math.sin(n21angle * 0.0174533)),
        2,
        colourWhite
    )

    sasl.gl.drawText(
        fontLatoBold,
        176,
        520,
        string.format("%02.1f", n2n[1]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    --EN2
    sasl.gl.drawArc(300, 510, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(300, 510, 0, 75, 0, n22angle, colourGrey)
    sasl.gl.drawWideLine(
        300,
        510,
        300 + (75 * math.cos(n22angle * 0.0174533)),
        510 + (75 * math.sin(n22angle * 0.0174533)),
        2,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        376,
        520,
        string.format("%02.1f", n2n[2]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )

    --n1
    local n11angle = n1n[1] * -1 * 2.2166
    local n12angle = n1n[2] * -1 * 2.2166
    local n1Expected = get(engineExpN1)
    local n1ExpectedAngle = 180
    --n1Expected * -1 * 2.2
    --EN1
    sasl.gl.drawWidePolyLine({101, 851, 186, 851, 186, 891, 101, 891, 101, 851}, 2, colourWhite)
    sasl.gl.drawWidePolyLine({301, 851, 386, 851, 386, 891, 301, 891, 301, 851}, 2, colourWhite)

    sasl.gl.drawArc(100, 850, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(100, 850, 0, 75, 0, n11angle, colourGrey)
    sasl.gl.drawText(
        fontLatoBold,
        176,
        860,
        string.format("%02.1f", n1n[1]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        176,
        900,
        string.format("%02.1f", n1Expected),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourGreen
    )
    sasl.gl.drawWideLine(
        100,
        850,
        100 + (75 * math.cos(n11angle * 0.0174533)),
        850 + (75 * math.sin(n11angle * 0.0174533)),
        2,
        colourWhite
    )

    sasl.gl.drawWideLine(
        100 + (75 * math.cos(135 * 0.0174533)),
        850 + (75 * math.sin(135 * 0.0174533)),
        100 + (90 * math.cos(135 * 0.0174533)),
        850 + (90 * math.sin(135 * 0.0174533)),
        2,
        colourRed
    )
    sasl.gl.drawWideLine(
        100 + (60 * math.cos(140 * 0.0174533)),
        850 + (60 * math.sin(140 * 0.0174533)),
        100 + (75 * math.cos(140 * 0.0174533)),
        850 + (75 * math.sin(140 * 0.0174533)),
        2,
        colourYellow
    )
    --local n1ExpHorizontal = 100 + (78 * math.cos((n11angle / 2) * 0.0174533))
    --local n1ExpVertical = 850 + (78 * math.sin((n11angle / 2) * 0.0174533))
    --sasl.gl.drawWidePolyLine({n1horz2, 855, n1horz1, 850, n1horz2, 845}, 2, colourPink)
    --sasl.gl.drawRotatedTextureCenter(arrowImage, 0, 100, 850, n1ExpHorizontal, n1ExpVertical, 10, 10, colourGreen)
    --sasl.gl.drawRotatedTextureCenter(number id, number angle , number rx, number ry, number x, number y, number width , number height , Color color)
    --EN2

    sasl.gl.drawArc(300, 850, 75, 77, 0, -225, colourWhite)
    sasl.gl.drawArc(300, 850, 0, 75, 0, n12angle, colourGrey)
    sasl.gl.drawText(
        fontLatoBold,
        376,
        860,
        string.format("%02.1f", n1n[2]),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        376,
        900,
        string.format("%02.1f", n1Expected),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourGreen
    )

    sasl.gl.drawWideLine(
        300,
        850,
        300 + (75 * math.cos(n12angle * 0.0174533)),
        850 + (75 * math.sin(n12angle * 0.0174533)),
        2,
        colourWhite
    )
    sasl.gl.drawWideLine(
        300 + (75 * math.cos(135 * 0.0174533)),
        850 + (75 * math.sin(135 * 0.0174533)),
        300 + (90 * math.cos(135 * 0.0174533)),
        850 + (90 * math.sin(135 * 0.0174533)),
        2,
        colourRed
    )
    sasl.gl.drawWideLine(
        300 + (60 * math.cos(140 * 0.0174533)),
        850 + (60 * math.sin(140 * 0.0174533)),
        300 + (75 * math.cos(140 * 0.0174533)),
        850 + (75 * math.sin(140 * 0.0174533)),
        2,
        colourYellow
    )
    sasl.gl.drawText(fontLatoBold, 192, 780, "N", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 208, 770, "1", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)

    sasl.gl.drawText(fontLatoBold, 200, 600, "EGT", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 192, 440, "N", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 208, 430, "2", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)

    sasl.gl.drawWidePolyLine({65, 360, 135, 360, 135, 400, 65, 400, 65, 360}, 2, colourWhite)
    sasl.gl.drawText(fontLatoBold, 70, 370, "6.3", 30, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 200, 370, "FF", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawWidePolyLine({335, 360, 265, 360, 265, 400, 335, 400, 335, 360}, 2, colourWhite)
    sasl.gl.drawText(fontLatoBold, 270, 370, "6.3", 30, false, false, TEXT_ALIGN_LEFT, colourWhite)

    local oilPres = get(oilPress)
    local oilPresLeft = oilPres[1]
    local oilPresRight = oilPres[2]
    sasl.gl.drawWidePolyLine({75, 320, 135, 320, 135, 280, 75, 280, 75, 320}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        125,
        290,
        string.format("%02.f", oilPresLeft),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawText(fontLatoBold, 200, 320, "OIL", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 200, 290, "PRESS", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawWidePolyLine({330, 320, 265, 320, 265, 280, 330, 280, 330, 320}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        325,
        290,
        string.format("%02.f", oilPresRight),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawWideLine(145, 340, 145, 260, 2, colourWhite)
    sasl.gl.drawWideLine(142, 260, 155, 260, 2, colourRed)
    sasl.gl.setClipArea(140, 255, 130, 90)
    sasl.gl.drawTriangle(145, 260 + oilPresLeft, 155, 265 + oilPresLeft, 155, 255 + oilPresLeft, colourWhite)

    sasl.gl.drawWideLine(255, 340, 255, 260, 2, colourWhite)
    sasl.gl.drawWideLine(258, 260, 245, 260, 2, colourRed)
    sasl.gl.drawTriangle(245, 255 + oilPresRight, 245, 265 + oilPresRight, 255, 260 + oilPresRight, colourWhite)
    sasl.gl.resetClipArea()
    local oilTem = get(oilTemp)
    local oilTemLeft = oilTem[1] / 5
    local oilTemRight = oilTem[2] / 5
    sasl.gl.drawWidePolyLine({75, 220, 135, 220, 135, 180, 75, 180, 75, 220}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        128,
        190,
        string.format("%02.f", oilTemLeft),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawText(fontLatoBold, 200, 220, "OIL", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 200, 190, "TEMP", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawWidePolyLine({330, 220, 265, 220, 265, 180, 330, 180, 330, 220}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        323,
        190,
        string.format("%02.f", oilTemRight),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawWideLine(145, 239, 145, 160, 2, colourWhite)
    sasl.gl.drawWideLine(142, 240, 155, 240, 2, colourRed)
    sasl.gl.drawWideLine(146, 230, 155, 230, 2, colourYellow)
    sasl.gl.setClipArea(140, 155, 130, 90)
    sasl.gl.drawTriangle(145, 160 + oilTemLeft, 155, 165 + oilTemLeft, 155, 155 + oilTemLeft, colourWhite)

    sasl.gl.drawWideLine(255, 239, 255, 160, 2, colourWhite)
    sasl.gl.drawWideLine(258, 240, 245, 240, 2, colourRed)
    sasl.gl.drawWideLine(254, 230, 245, 230, 2, colourYellow)
    sasl.gl.drawTriangle(245, 155 + oilTemRight, 245, 165 + oilTemRight, 255, 160 + oilTemRight, colourWhite)
    sasl.gl.resetClipArea()

    local oilQuty = get(oilQty)
    local oilQutyLeft = oilQuty[1] * 100
    local oilQutyRight = oilQuty[2] * 100
    sasl.gl.drawWidePolyLine({75, 140, 135, 140, 135, 100, 75, 100, 75, 140}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        128,
        110,
        string.format("%02.f", oilQutyLeft),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )
    sasl.gl.drawText(fontLatoBold, 200, 110, "OIL QTY", 28, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawWidePolyLine({330, 140, 265, 140, 265, 100, 330, 100, 330, 140}, 2, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        323,
        110,
        string.format("%02.f", oilQutyRight),
        30,
        false,
        false,
        TEXT_ALIGN_RIGHT,
        colourWhite
    )

    --sasl.gl.setClipArea(0, 0, 300, 200)
    --sasl.gl.drawRectangle(0, 0, 300, 200, colourWhite)
    --[[local offsetY = (get(pitch)*-2)-100
    local ias = math.floor(get(indicatedAS))
    local altitude = 35000 
    --math.floor(get(altitudeAS))
    sasl.gl.drawRotatedTexture (attIndImage, get(roll), 0, offsetY, 600, 400, colourWhite)
    sasl.gl.drawTexture(overlayImage, 60, 38, 180, 150)
    sasl.gl.drawText(fontLatoBold , 72, 167, ias, 10, false , false , TEXT_ALIGN_CENTER , colourGrey)
    sasl.gl.drawText(fontLatoBold , 228, 169, altitude, 8, false , false , TEXT_ALIGN_CENTER , colourGrey)
    
    end
--]]
    --sasl.gl.setRenderTarget(pfdDisplayTx, true)
    ----------------------------------------------------------------------------------
    -- Clock timer
    ----------------------------------------------------------------------------------
    --sasl.gl.drawRectangle(0, 0, 638, 960, colourCyan)

    drawAll(components)
end
