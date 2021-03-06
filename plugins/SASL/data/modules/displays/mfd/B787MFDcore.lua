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
function update()
    updateAll(components)
end
function draw()
    drawAll(components)
    sasl.gl.drawRectangle(638, 0, 4, 960, colourGrey)
end

components = {
    B787MFDfuel {position = {1001, 0, 279, 200}},
    B787MFDengine {position = {641, 0, 638, 960}}
}

if get(enableExperimentalDisplays) == 1 then
    components = {
        B787MFDfuel {position = {1001, 0, 279, 200}},
        B787MFDengine {position = {641, 0, 638, 960}},
        B787MFDnav {position = {0, 0, 638, 960}, clip = true},
        B787MFDcontrols {position = {0, 0, 638, 960}}
    }
end
