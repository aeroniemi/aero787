size = {279, 200}
local fuelImage = loadImage("images/fuel.png")

local sat = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")
local totalFuel = globalPropertyf("sim/flightmodel/weight/m_fuel_total")
local grossWt = globalPropertyf("sim/flightmodel/weight/m_total")
local fuelQty = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity")
function draw()
    --sim/cockpit2/temperature/outside_air_temp_degc -SAT
    --sim/flightmodel/weight/m_total - gweight
    --sim/flightmodel/weight/m_fuel_total
    --sim/cockpit2/fuel/fuel_quantity
    local airTemp = 0
    if get(sat) < 0 then
        airtemp = string.format("%02.f", get(sat))
    else
        airTemp = "+" .. string.format("%02.f", get(sat))
    end
    if get(sat) < 0 then
        fueltemp = string.format("%02.f", get(sat))
    else
        fuelTemp = "+" .. string.format("%02.f", get(sat))
    end
    local gross = 0
    local Fuel = 0
    local FuelL = 0
    local FuelR = 0
    local FuelC = 0
    local FuelQuty = get(fuelQty)
    if get(imperial) == 1 then
        gross = string.format("%.1f", get(grossWt) / 1000)
        fuel = string.format("%.1f", get(totalFuel) / 1000)
    else
        gross = string.format("%.1f", get(grossWt) * 0.45359237 / 1000)
        fuel = string.format("%.1f", get(totalFuel) * 0.45359237 / 1000)
        fuelL = string.format("%.1f", FuelQuty[1] / 1000)
        fuelC = string.format("%.1f", (FuelQuty[3] + FuelQuty[4]) / 1000)
        fuelR = string.format("%.1f", FuelQuty[2] / 1000)
    end
    sasl.gl.drawRectangle(0, 0, 319, 165, colourGrey)
    sasl.gl.drawWidePolyLine({0, 0, 0, 165, 319, 165}, 2, colourWhite)
    sasl.gl.drawTexture(fuelImage, 38, 100, 203, 62)
    if get(imperial) == 1 then
    else
        sasl.gl.drawText(fontLatoBold, 5, 68, "GROSS WT", 20, false, false, TEXT_ALIGN_LEFT, colourCyan)
        sasl.gl.drawRectangle(25, 35, 55, 25, colourBlack)
        sasl.gl.drawText(fontLatoBold, 78, 40, gross, 20, false, false, TEXT_ALIGN_RIGHT, colourWhite)

        sasl.gl.drawRectangle(209, 35, 55, 25, colourBlack)
        sasl.gl.drawText(fontLatoBold, 261, 40, fuel, 20, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 274, 68, "TOTAL FUEL", 20, false, false, TEXT_ALIGN_RIGHT, colourCyan)
        sasl.gl.drawRectangle(224, 5, 50, 25, colourBlack)
        sasl.gl.drawText(fontLatoBold, 274, 10, fuelTemp .. "C", 20, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 214, 20, "FUEL", 17, false, false, TEXT_ALIGN_RIGHT, colourCyan)
        sasl.gl.drawText(fontLatoBold, 214, 5, "TEMP", 15, false, false, TEXT_ALIGN_RIGHT, colourCyan)

        sasl.gl.drawText(fontLatoBold, 5, 13, "SAT", 15, false, false, TEXT_ALIGN_LEFT, colourCyan)
        sasl.gl.drawRectangle(35, 5, 50, 25, colourBlack)
        sasl.gl.drawText(fontLatoBold, 35, 10, airTemp .. "C", 20, false, false, TEXT_ALIGN_LEFT, colourWhite)

        sasl.gl.drawText(fontLatoBold, 135, 58, "KGS X", 18, false, false, TEXT_ALIGN_CENTER, colourWhite)
        sasl.gl.drawText(fontLatoBold, 135, 38, "1000", 18, false, false, TEXT_ALIGN_CENTER, colourWhite)

        sasl.gl.drawText(fontLatoBold, 88, 119, fuelL, 18, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 190, 119, fuelR, 18, false, false, TEXT_ALIGN_LEFT, colourWhite)

        sasl.gl.drawText(fontLatoBold, 139, 119, fuelC, 18, false, false, TEXT_ALIGN_CENTER, colourWhite)
    end

    drawAll(components)
end
