size = {850, 320}
local ndImage = loadImage("images/pfdNd.png")
local hslImage = loadImage("images/headingSelectLine.png")
local hdg = globalPropertyf("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot")
local autoHdg = globalPropertyf("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot")
local groundspeed = globalPropertyf("sim/flightmodel/position/groundspeed")
local tas = globalPropertyf("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
local windDirection = globalPropertyf("sim/cockpit2/gauges/indicators/wind_heading_deg_mag")
local windSpeed = globalPropertyf("sim/cockpit2/gauges/indicators/wind_speed_kts")
function draw()
    sasl.gl.resetClipArea()

    sasl.gl.drawText(fontLatoBold, 10, 292, "GS", 20, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        40,
        292,
        string.format("%1.f", get(groundspeed)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )

    sasl.gl.drawText(fontLatoBold, 70, 292, "TAS", 20, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(
        fontLatoBold,
        110,
        292,
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
        262,
        string.format("%03.f", get(windDirection)) .. "°" .. " /   " .. string.format("% 3.f", get(windSpeed)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )

    sasl.gl.setClipArea(0, 50, 850, 270)

    -- the ark

    --[[
    sasl.gl.drawArc(420, 80, 205, 215,0, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,5, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,10, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,15, 0.75, colourWhite)s
    sasl.gl.drawArc(420, 80, 205, 215,20, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,25, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,30, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,35, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,40, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,45, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,50, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,55, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,60, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,65, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,70, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,75, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,80, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,85, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,90, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,95, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,100, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,105, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,110, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,115, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,120, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,125, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,130, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,135, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,140, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,145, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,150, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,155, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,160, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,165, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,170, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,175, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 200, 215,180, 0.75, colourWhite)
    sasl.gl.drawArc(420, 80, 205, 215,185, 0.75, colourWhite)

    sasl.gl.drawRotatedText(fontLatoBold, 420, 80, 420, 80,0, "ffefefew3", 20, false, false, TEXT_ALIGN_CENTER, colourWhite)
--]]
    sasl.gl.drawRotatedTexture(ndImage, -get(hdg), 205, -135, 430, 430, colourWhite)
    sasl.gl.drawRotatedTextureCenter(hslImage, (-get(hdg)) + get(autoHdg), 420, 80, 400, 80, 40, 215, colourWhite)
    sasl.gl.drawRotatedTextureCenter(hslImage, (-get(hdg)) + get(autoHdg), 420, 80, 400, 80, 40, 215, colourWhite)

    sasl.gl.drawWidePolyLine(
        {420, 80, 400, 40, 440, 40, 420, 80, 420, 295, 430, 315, 410, 315, 420, 295},
        2,
        colourWhite
    )
    sasl.gl.resetClipArea()
    sasl.gl.drawText(fontLatoBold, 270, 10, "SEL HDG", 20, false, false, TEXT_ALIGN_LEFT, colourPink)
    sasl.gl.drawText(
        fontLatoBold,
        350,
        10,
        string.format("%03.f", get(autoHdg)),
        26,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourPink
    )
    sasl.gl.drawText(fontLatoBold, 470, 10, "MAG", 26, false, false, TEXT_ALIGN_LEFT, colourWhite)
end
