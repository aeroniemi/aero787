size = {1280, 960}

local attIndImage = loadImage("images/horiz.png")
local overlayImage = loadImage("images/overlay.png")
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
local roll = globalPropertyf("sim/cockpit2/gauges/indicators/roll_electric_deg_pilot")
local indicatedAS = globalPropertyf("sim/flightmodel/position/indicated_airspeed")
local altitudeAS = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")

local clockImage = loadImage("images/clock.png")

local zuluHours = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
local zuluMinutes = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
local zuluSeconds = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_seconds")

local elapsedHours = globalPropertyi("sim/cockpit2/clock_timer/elapsed_time_hours")
local elapsedMinutes = globalPropertyi("sim/cockpit2/clock_timer/elapsed_time_minutes")
local elapsedSeconds = globalPropertyi("sim/cockpit2/clock_timer/elapsed_time_seconds")

local dateYear = 18
local dateMonth = globalPropertyi("sim/cockpit2/clock_timer/current_month")
local dateDay = globalPropertyi("sim/cockpit2/clock_timer/current_day")

local xpdrCode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_code")
local com1 = globalPropertyi("sim/cockpit2/radios/actuators/com1_frequency_hz")

function draw()
    --sasl.gl.setClipArea(0, 0, 300, 200)
    --sasl.gl.drawRectangle(0, 0, 300, 200, colourWhite)
    --[[local offsetY = (get(pitch)*-2)-100
    local ias = math.floor(get(indicatedAS))
    local altitude = 35000 
    --math.floor(get(altitudeAS))
    sasl.gl.drawRotatedTexture (attIndImage, get(roll), 0, offsetY, 600, 400, colourWhite)
    sasl.gl.drawTexture(overlayImage, 60, 38, 180, 150)
    sasl.gl.drawText(fontLatoBold , 72, 167, ias, 10, false , false , TEXT_ALIGN_CENTER , colourPink)
    sasl.gl.drawText(fontLatoBold , 228, 169, altitude, 8, false , false , TEXT_ALIGN_CENTER , colourPink)
    
    end
--]]
    --sasl.gl.setRenderTarget(pfdDisplayTx, true)
    ----------------------------------------------------------------------------------
    -- Clock timer
    ----------------------------------------------------------------------------------

    local utcHours = get(zuluHours)
    local utcMinutes = get(zuluMinutes)
    local utcSeconds = get(zuluSeconds)
    if utcHours < 10 then
        utcHours = "0" .. utcHours
    end
    if utcMinutes < 10 then
        utcMinutes = "0" .. utcMinutes
    end
    if utcSeconds < 10 then
        utcSeconds = "0" .. utcSeconds
    end
    local zuluTime = utcHours .. ":" .. utcMinutes .. ":" .. utcSeconds .. "z"
    ----------------------------------------------------------------------------------
    -- date
    ----------------------------------------------------------------------------------
    local month = get(dateMonth)
    local day = get(dateDay)
    local date = day .. " " .. "MAY" .. " " .. dateYear

    ----------------------------------------------------------------------------------
    -- timer
    ----------------------------------------------------------------------------------
    local runningHours = get(elapsedHours)
    local runningMinutes = get(elapsedMinutes)
    local runningSeconds = get(elapsedSeconds)
    local timerTime = 0
    if runningMinutes < 10 then
        runningMinutes = "0" .. runningMinutes
    end
    if runningSeconds < 10 then
        runningSeconds = "0" .. runningSeconds
    end
    if runningHours == 0 then
        timerTime = runningMinutes .. ":" .. runningSeconds
    elseif runningHours < 10 then
        runningHours = "0" .. runningHours
        timerTime = runningHours .. ":" .. runningMinutes .. ":" .. runningSeconds
    else
        timerTime = runningHours .. ":" .. runningMinutes .. ":" .. runningSeconds
    end
    ----------------------------------------------------------------------------------
    -- XPDR code
    ----------------------------------------------------------------------------------
    local transCode = string.format("%04d", get(xpdrCode))

    ----------------------------------------------------------------------------------
    --Com1 code
    ----------------------------------------------------------------------------------
    local com1Code = string.format("%6.2f", get(com1) / 100)

    ----------------------------------------------------------------------------------
    -- other things that need getting
    ----------------------------------------------------------------------------------
    local tail = get(tailNumber)
    local selCode = get(selcalCode)
    local flightNo = get(flightNumber)

    ----------------------------------------------------------------------------------
    -- other stuff
    ----------------------------------------------------------------------------------
    sasl.gl.setClipArea(0, 0, 1280, 980)
    sasl.gl.drawRectangle(0, 0, 1280, 960, colourWhite)
    sasl.gl.drawRectangle(0, 352, 426, 354, colourBlack)
    sasl.gl.drawRectangle(0, 0, 426, 348, colourBlack)
    sasl.gl.drawRectangle(0, 710, 426, 250, colourGrey)

    sasl.gl.drawRectangle(430, 0, 850, 320, colourBlack)
    sasl.gl.drawText(fontLatoBold, 14, 930, "FLT #", 16, false, false, TEXT_ALIGN_LEFT, colourCyan)
    sasl.gl.drawText(fontLatoBold, 14, 895, "MIC", 16, false, false, TEXT_ALIGN_LEFT, colourCyan)
    sasl.gl.drawText(fontLatoBold, 14, 860, "XPDR", 16, false, false, TEXT_ALIGN_LEFT, colourCyan)
    sasl.gl.drawText(fontLatoBold, 14, 825, "SELCAL", 16, false, false, TEXT_ALIGN_LEFT, colourCyan)
    sasl.gl.drawText(fontLatoBold, 14, 790, "TAIL #", 16, false, false, TEXT_ALIGN_LEFT, colourCyan)

    sasl.gl.drawText(fontLatoBlack, 80, 929, flightNo, 24, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 80, 893, com1Code, 22, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 170, 893, "VHF L", 14, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 80, 858, transCode, 22, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 80, 823, selCode, 22, false, false, TEXT_ALIGN_LEFT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 80, 788, tail, 22, false, false, TEXT_ALIGN_LEFT, colourWhite)

    sasl.gl.drawText(fontLatoBold, 80, 755, "UTC TIME", 14, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 80, 728, zuluTime, 24, false, false, TEXT_ALIGN_CENTER, colourWhite)

    sasl.gl.drawText(fontLatoBold, 213, 755, "DATE", 14, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 213, 728, date, 24, false, false, TEXT_ALIGN_CENTER, colourWhite)

    sasl.gl.drawText(fontLatoBold, 346, 755, "ELAPSED TIME", 14, false, false, TEXT_ALIGN_CENTER, colourCyan)
    sasl.gl.drawText(fontLatoBold, 346, 728, timerTime, 24, false, false, TEXT_ALIGN_CENTER, colourWhite)

    sasl.gl.drawTexture(clockImage, 279, 800, 134, 134)
    sasl.gl.drawArc(346, 867, 55, 67, 0, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 30, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 60, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 90, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 120, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 150, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 180, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 210, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 240, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 270, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 300, 2, colourWhite)
    sasl.gl.drawArc(346, 867, 55, 67, 330, 2, colourWhite)

    sasl.gl.drawArc(346, 867, 45, 67, -((get(elapsedSeconds) / 60) * 360) + 90, 2, colourWhite)
    drawAll(components)
    sasl.gl.resetClipArea()
end

components = {
    B787PFDhorizon {position = {430, 320, 850, 640}},
    B787PFDnav {position = {430, 0, 850, 320}}
}
