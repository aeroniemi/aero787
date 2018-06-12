size = {637, 960}
local groundspeed = globalPropertyf("sim/flightmodel/position/groundspeed")
local tas = globalPropertyf("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
local windDirection = globalPropertyf("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
local windSpeed = globalPropertyf("sim/cockpit2/gauges/indicators/wind_speed_kts")
function draw()
    sasl.gl.drawText(fontLatoBold, 10, 862, "GS", 20, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        40,
        862,
        string.format("%1.f", get(groundspeed)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )

    sasl.gl.drawText(fontLatoBold, 70, 862, "TAS", 20, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        110,
        862,
        string.format("%1.f", get(tas)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )

    sasl.gl.drawText(
        fontLatoBold,
        10,
        832,
        string.format("%03.f", get(windDirection)) .. "°" .. " /   " .. string.format("% 3.f", get(windSpeed)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )

    sasl.gl.drawArc(310, 100, 140, 143, 0, 180, colourCyan)
    sasl.gl.drawArc(310, 100, 220, 223, 0, 180, colourCyan)
    sasl.gl.drawArc(310, 150, 680, 683, 0, 180, colourCyan)
    drawAll(components)
end
