size = {850, 640}

local attIndImage = loadImage("images/experimentalVerticalThingy.png")
local overlayImage = loadImage("images/overlay.png")
local redTapeImage = loadImage("images/redTape.png")
local triangleImage = loadImage("images/triangle.png")
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
local roll = globalPropertyf("sim/cockpit2/gauges/indicators/roll_electric_deg_pilot")
local reqAS = globalPropertyf("sim/cockpit2/autopilot/airspeed_dial_kts_mach")
local indicatedAS = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
local altitudeAS = globalPropertyf("sim/cockpit2/autopilot/altitude_hold_ft")
local altitudeInd = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
local height = globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")
local baroInhg = globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot")
local locOffset = globalPropertyf("sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot")
local vertSpeed = globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot")
local machSpeed = globalPropertyf("sim/cockpit2/gauges/indicators/mach_pilot")
local headingAS = globalPropertyf("sim/cockpit2/autopilot/heading_mode")
local FDpitch = globalPropertyf("sim/cockpit2/autopilot/flight_director_pitch_deg")
local FDroll = globalPropertyf("sim/cockpit2/autopilot/flight_director_roll_deg")
function draw()
    sasl.gl.setClipArea(0, 0, 850, 640)
    --sasl.gl.drawRectangle(0, 0, 850, 640, colourPink)
    --to draw horizon using trig, doesn't work
    local rollView = math.tan(get(roll) / 57.2957795)
    local pitchView = get(pitch)
    local leftAlt = 320 + (get(pitch) * -6) - (rollView * 420)
    local rightAlt = 320 + (get(pitch) * -6) + (rollView * 420)
    sasl.gl.drawRectangle(0, 0, 850, 640, colourBlue)
    sasl.gl.drawConvexPolygon({0, leftAlt, 850, rightAlt, 850, 0, 0, 0}, true, 2, colourBrown)
    sasl.gl.setClipArea(240, 150, 460, 340)

    local leftLongLine = 321 + (get(pitch) * -6) - (rollView * 140)
    local rightLongLine = 321 + (get(pitch) * -6) + (rollView * 140)
    --[[
    local leftVeryShortLine = 319+(get(pitch)*-3.4)-(rollView*15)
    local rightVeryShortLine = 319+(get(pitch)*-3.4)+(rollView*15)
    local rightVeryShortLine = 319+(get(pitch)*-3.4)-(rollView*20)
    local leftShortLine = 319+(get(pitch)*-3.4)+(rollView*20)
--]]
    sasl.gl.drawWideLine(280, leftLongLine, 560, rightLongLine, 2, colourWhite)

    sasl.gl.drawWideLine(280, leftLongLine, 560, rightLongLine, 2, colourWhite)
    local offsetY = (get(pitch) * -6) + 159
    local offsetYX = (get(pitch) * -6) + 320
    --local offsetY = (get(pitch)*-3.4)+153

    --sasl.gl.drawRotatedTexture (attIndImage, -get(roll), 323, offsetY, 204, 331, colourWhite)
    sasl.gl.drawRotatedTextureCenter(attIndImage, -get(roll), 425, 320, 323, offsetY, 204, 331, colourWhite)
    sasl.gl.drawRotatedTextureCenter(attIndImage, -get(roll), 425, 320, 323, offsetY, 204, 331, colourWhite)
    sasl.gl.resetClipArea()

    -- background overlay
    --sasl.gl.drawTexture(overlayImage, 140, 72, 565, 556)
    sasl.gl.drawRectangle(140, 72, 90, 480, colourBlackHalf)
    sasl.gl.drawRectangle(145, 560, 80, 40, colourBlack)
    sasl.gl.drawRectangle(615, 560, 90, 40, colourBlack)
    if useMeters == 1 then
        sasl.gl.drawRectangle(615, 600, 90, 30, colourBlackHalf)
    end
    sasl.gl.drawRectangle(237, 585, 370, 45, colourBlackHalf)

    sasl.gl.drawWideLine(483, 585, 483, 630, 3, colourWhite)
    sasl.gl.drawWideLine(483, 585, 483, 630, 3, colourWhite)
    sasl.gl.drawWideLine(359, 585, 359, 630, 3, colourWhite)

    sasl.gl.drawRectangle(615, 72, 90, 480, colourBlackHalf)
    local requestedSpeed = math.floor(get(reqAS))
    local altitude = get(altitudeInd)
    local altitudeA = get(altitudeAS)

    local metersAltitude = string.format("%.0f", altitudeA * 0.3048)

    --
    --math.floor(get(altitudeAS))
    -- flight director
    if get(autoflightStatus) > 0 then
        local fdPitch = (get(FDpitch) - get(pitch)) * 2.4
        local fdRoll = (get(FDroll) - get(roll)) * 2.4
        sasl.gl.drawWideLine(424 + fdRoll, 227 + fdPitch, 424 + fdRoll, 427 + fdPitch, 3, colourPink)
        sasl.gl.drawWideLine(325 + fdRoll, 326 + fdPitch, 525 + fdRoll, 326 + fdPitch, 3, colourPink)
    end
    -- autoflight altitude/speed

    sasl.gl.drawText(fontLatoBold, 185, 568, requestedSpeed, 28, false, false, TEXT_ALIGN_CENTER, colourPink)
    sasl.gl.drawText(
        fontLatoBold,
        660,
        568,
        string.format("%.0f", altitudeA),
        28,
        false,
        false,
        TEXT_ALIGN_CENTER,
        colourPink
    )
    if useMeters == 1 then
        sasl.gl.drawText(fontLatoBold, 650, 607, metersAltitude, 20, false, false, TEXT_ALIGN_CENTER, colourPink)
        sasl.gl.drawText(fontLatoBold, 684, 607, "M", 20, false, false, TEXT_ALIGN_LEFT, colourCyan)
    end

    -- radio altimeter
    local radioHeight = get(height)
    if radioHeight < 2500 then
        radioHeight = string.format("%.0f", radioHeight)
        sasl.gl.drawRectangle(387, 72, 70, 40, colourBlack)
        sasl.gl.drawText(fontLatoBold, 421.5, 79, radioHeight, 35, false, false, TEXT_ALIGN_CENTER, colourWhite)
    end

    -- decision heights
    if get(decisionHeight) > 0 then
        sasl.gl.drawText(fontLatoBold, 570, 72, get(decisionHeight), 33, false, false, TEXT_ALIGN_CENTER, colourGreen)
    end

    if get(decisionBaro) == 1 then
        sasl.gl.drawText(fontLatoBold, 525, 107, "BARO", 27, false, false, TEXT_ALIGN_LEFT, colourGreen)
    end
    --QNH
    if get(baroStd) == 1 then
        sasl.gl.drawText(fontLatoBold, 660, 40, "STD", 30, false, false, TEXT_ALIGN_CENTER, colourGreen)
    end
    if get(baroHpa) == 1 then
        local pressure = string.format("%4.f", (get(baroInhg) * 33.8639))

        sasl.gl.drawText(fontLatoBlack, 660, 14, pressure .. "HPA", 23, false, false, TEXT_ALIGN_CENTER, colourWhite)
    else
        local pressure = string.format("%.2f", get(baroInhg))
        sasl.gl.drawText(fontLatoBlack, 660, 14, pressure .. " IN", 23, false, false, TEXT_ALIGN_CENTER, colourWhite)
    end
    if get(baroQfe) == 1 then
        sasl.gl.drawText(fontLatoBlack, 735, 15.5, "QFE", 20, false, false, TEXT_ALIGN_CENTER, colourGreen)
    end

    --VOR I think
    sasl.gl.drawRectangle(297, 10, 250, 36, colourBlackHalf)
    sasl.gl.drawWideLine(421, 26, 421, 46, 2, colourWhite)
    sasl.gl.drawWideLine(326, 29, 326, 43, 2, colourWhite)
    sasl.gl.drawWideLine(516, 29, 516, 43, 2, colourWhite)
    local localiser = get(locOffset) * 62 + 421
    if localiser > 545 then
        localiser = 545
    elseif localiser < 297 then
        localiser = 297
    end
    sasl.gl.drawWideLine(localiser, 29, localiser, 43, 4, colourPink)

    -- speeds
    local ias = get(indicatedAS)
    local ias2 = string.format("%1.f", math.floor(ias / 10))
    if ias < 30 then
        ias2 = 3
    end
    local iasLast = string.format("%1.f", ias)
    local iasLastMa = tonumber(tostring(math.floor(ias)):sub(-1))
    local iasLastBefore = iasLastMa - 1
    local iasLastBeforeAgain = iasLastMa - 2
    local iasLastAfter = iasLastMa + 1
    if iasLastMa == 0 then
        iasLastBefore = 9
        iasLastBeforeAgain = 8
    elseif iasLastMa == 9 then
        iasLastAfter = 1
    elseif iasLastMa == 1 then
        iasLastBeforeAgain = 9
    end
    local iasLastOffset = tonumber(tostring(math.floor(ias * 10)):sub(-1)) * 2.5

    -- Speeds to be drawn last

    -- altitude

    local altitude2 = string.format("%1.f", math.floor(altitude / 1000))
    local altitudeSecondDigit = tonumber(tostring(math.floor(altitude / 100)):sub(-1))

    local altitudeLastMa = tonumber(tostring(math.floor(altitude / 10) * 10):sub(-2))
    local altitudeLastBefore = altitudeLastMa - 10
    local altitudeLastBeforeAgain = altitudeLastMa - 20
    local altitudeLastAfter = altitudeLastMa + 10
    if altitudeLastMa == 0 then
        altitudeLastBefore = 90
        altitudeLastBeforeAgain = 80
    elseif altitudeLastMa == 90 then
        altitudeLastAfter = 10
    elseif altitudeLastMa == 10 then
        altitudeLastBeforeAgain = 90
    end
    local altitudeLastOffset = tonumber(tostring(math.floor(altitude * 10)):sub(-1)) * 2.5

    sasl.gl.setClipArea(0, 0, 850, 640)

    -- VS indicator

    sasl.gl.drawConvexPolygon({735, 150, 750, 150, 780, 230, 780, 410, 750, 490, 735, 490}, true, 0, colourBlackHalf)
    sasl.gl.drawConvexPolygon({735, 490, 720, 490, 720, 360, 735, 350}, true, 0, colourBlackHalf)
    sasl.gl.drawConvexPolygon({735, 275, 720, 265, 720, 150, 735, 150}, true, 0, colourBlackHalf)

    -- VS lines
    sasl.gl.drawWideLine(735, 320, 760, 320, 2, colourWhite)
    sasl.gl.drawWideLine(735, 350, 745, 350, 1, colourWhite)
    sasl.gl.drawWideLine(735, 380, 745, 380, 2, colourWhite)
    sasl.gl.drawWideLine(735, 410, 745, 410, 1, colourWhite)
    sasl.gl.drawWideLine(735, 440, 745, 440, 2, colourWhite)
    sasl.gl.drawWideLine(735, 455, 745, 455, 1, colourWhite)
    sasl.gl.drawWideLine(735, 470, 745, 470, 1, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 465, "6", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 435, "2", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 375, "1", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)

    sasl.gl.drawWideLine(735, 290, 745, 290, 1, colourWhite)
    sasl.gl.drawWideLine(735, 260, 745, 260, 2, colourWhite)
    sasl.gl.drawWideLine(735, 230, 745, 230, 1, colourWhite)
    sasl.gl.drawWideLine(735, 200, 745, 200, 2, colourWhite)
    sasl.gl.drawWideLine(735, 185, 745, 185, 1, colourWhite)
    sasl.gl.drawWideLine(735, 170, 745, 170, 1, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 165, "6", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 195, "2", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 733, 255, "1", 16, false, false, TEXT_ALIGN_RIGHT, colourWhite)

    local deviated = 320

    local verticalSpeed = get(vertSpeed)

    if verticalSpeed > 2000 then
        local deviation = (verticalSpeed - 2000) / 133.333333
        deviated = deviation + 440
    elseif verticalSpeed < -2000 then
    else
        local deviation = verticalSpeed / 16.6666667
        deviated = deviation + 320
    end
    --160 - 475
    sasl.gl.drawWideLine(780, 320, 745, deviated, 2, colourWhite)

    sasl.gl.setClipArea(615, 72, 90, 480)

    local AltitudeMAS = math.floor((altitude / 100)) * 100
    local AltitudeMA = tonumber(tostring(math.floor(altitude / 1000) * 1000):sub(-2))
    local AltitudeDifference = ((altitude - AltitudeMAS) * -0.6) + 310
    sasl.gl.drawWideLine(615, AltitudeDifference, 645, AltitudeDifference, 2, colourWhite)

    sasl.gl.drawWideLine(615, AltitudeDifference + 60, 645, AltitudeDifference + 60, 2, colourWhite)
    if (AltitudeMAS % 200 == 0) then
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 115,
            AltitudeMAS + 200,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 235,
            AltitudeMAS + 400,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 355,
            AltitudeMAS + 600,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
    else
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 55,
            AltitudeMAS + 100,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 175,
            AltitudeMAS + 300,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference + 295,
            AltitudeMAS + 500,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
    end

    sasl.gl.drawWideLine(615, AltitudeDifference + 120, 645, AltitudeDifference + 120, 2, colourWhite)
    sasl.gl.drawWideLine(615, AltitudeDifference + 180, 645, AltitudeDifference + 180, 2, colourWhite)
    sasl.gl.drawWideLine(615, AltitudeDifference + 240, 645, AltitudeDifference + 240, 2, colourWhite)

    sasl.gl.drawWideLine(615, AltitudeDifference - 60, 645, AltitudeDifference - 60, 2, colourWhite)
    sasl.gl.drawWideLine(615, AltitudeDifference - 120, 645, AltitudeDifference - 120, 2, colourWhite)
    sasl.gl.drawWideLine(615, AltitudeDifference - 180, 645, AltitudeDifference - 180, 2, colourWhite)
    sasl.gl.drawWideLine(615, AltitudeDifference - 240, 645, AltitudeDifference - 240, 2, colourWhite)

    if (AltitudeMAS % 200 == 0) then
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 5,
            AltitudeMAS,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 125,
            AltitudeMAS - 200,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 245,
            AltitudeMAS - 400,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 365,
            AltitudeMAS - 600,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
    else
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 65,
            AltitudeMAS - 100,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 185,
            AltitudeMAS - 300,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            650,
            AltitudeDifference - 305,
            AltitudeMAS - 500,
            20,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
    end

    sasl.gl.resetClipArea()

    -- roll angle thingy
    sasl.gl.setClipArea(270, 380, 310, 140)
    sasl.gl.drawArc(422, 324, 150, 165, 150, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 165, 135, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 175, 120, 1, colourWhite)

    sasl.gl.drawArc(422, 324, 150, 165, 110, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 165, 100, 0.75, colourWhite)

    sasl.gl.drawArc(422, 324, 150, 165, 30, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 165, 45, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 175, 60, 1, colourWhite)

    sasl.gl.drawArc(422, 324, 150, 165, 70, 0.75, colourWhite)
    sasl.gl.drawArc(422, 324, 150, 165, 80, 0.75, colourWhite)

    sasl.gl.drawRotatedTextureCenter(triangleImage, -get(roll), 422, 324, 407, 443, 30, 30, colourWhite)
    sasl.gl.resetClipArea()

    sasl.gl.setClipArea(230, 72, 10, 480)
    -- tape upper bound
    local overspeed = get(overspeedSpeed)
    local ias = get(ias)
    local maxMan = get(maxManSpeed)
    local difference = overspeed - ias
    local differenceMan = maxMan - ias
    local offsetTape = string.format("%1.f", 310 + (difference * 4))

    local offsetYellowThing = string.format("%1.f", 310 + (differenceMan * 4))
    sasl.gl.drawTexture(redTapeImage, 230, offsetTape, 10, 490)
    sasl.gl.drawWidePolyLine({239, offsetTape, 239, offsetYellowThing, 230, offsetYellowThing}, 2, colourYellow)
    -- tape lower bounds

    local underspeed = get(underspeedSpeed)
    local minMan = get(minManSpeed)
    local differenceUn = underspeed - ias
    local differenceUnMan = minMan - ias
    local offsetTapeUn = string.format("%1.f", -180 + (differenceUn * 4))
    local offsetTapeUnY = string.format("%1.f", 310 + (differenceUn * 4))

    local offsetYellowThingUn = string.format("%1.f", 310 + (differenceUnMan * 4))
    sasl.gl.drawTexture(redTapeImage, 230, offsetTapeUn, 10, 490)
    sasl.gl.drawWidePolyLine({239, offsetTapeUnY, 239, offsetYellowThingUn, 230, offsetYellowThingUn}, 2, colourYellow)
    sasl.gl.resetClipArea()

    -- speeds
    sasl.gl.setClipArea(140, 72, 90, 480)

    local SpeedMAS = math.floor((ias / 10)) * 10
    local SpeedMA = tonumber(tostring(math.floor(ias / 10) * 10):sub(-2))
    local speedDifference = ((ias - SpeedMAS) * -4) + 310
    sasl.gl.drawWideLine(210, speedDifference, 230, speedDifference, 2, colourWhite)
    sasl.gl.drawWideLine(210, speedDifference + 40, 230, speedDifference + 40, 2, colourWhite)

    sasl.gl.drawWideLine(210, speedDifference + 80, 230, speedDifference + 80, 2, colourWhite)
    if (SpeedMAS % 20 == 0) then
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 75,
            SpeedMAS + 20,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 155,
            SpeedMAS + 40,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 235,
            SpeedMAS + 60,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
    else
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 35,
            SpeedMAS + 10,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 115,
            SpeedMAS + 30,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            208,
            speedDifference + 195,
            SpeedMAS + 50,
            20,
            false,
            false,
            TEXT_ALIGN_RIGHT,
            colourWhite
        )
    end

    sasl.gl.drawWideLine(210, speedDifference + 120, 230, speedDifference + 120, 2, colourWhite)
    sasl.gl.drawWideLine(210, speedDifference + 160, 230, speedDifference + 160, 2, colourWhite)

    sasl.gl.drawWideLine(210, speedDifference + 200, 230, speedDifference + 200, 2, colourWhite)
    sasl.gl.drawWideLine(210, speedDifference + 240, 230, speedDifference + 240, 2, colourWhite)

    if SpeedMAS > 30 then
        sasl.gl.drawWideLine(210, speedDifference - 40, 230, speedDifference - 40, 2, colourWhite)
        sasl.gl.drawWideLine(210, speedDifference - 80, 230, speedDifference - 80, 2, colourWhite)
        sasl.gl.drawWideLine(210, speedDifference - 120, 230, speedDifference - 120, 2, colourWhite)
        sasl.gl.drawWideLine(210, speedDifference - 160, 230, speedDifference - 160, 2, colourWhite)
        sasl.gl.drawWideLine(210, speedDifference - 200, 230, speedDifference - 200, 2, colourWhite)
        sasl.gl.drawWideLine(210, speedDifference - 240, 230, speedDifference - 240, 2, colourWhite)

        if (SpeedMAS % 20 == 0) then
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 85,
                SpeedMAS - 20,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 165,
                SpeedMAS - 40,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 245,
                SpeedMAS - 60,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
        else
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 45,
                SpeedMAS - 10,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 125,
                SpeedMAS - 30,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
            sasl.gl.drawText(
                fontLatoBold,
                208,
                speedDifference - 205,
                SpeedMAS - 50,
                20,
                false,
                false,
                TEXT_ALIGN_RIGHT,
                colourWhite
            )
        end
    end

    sasl.gl.resetClipArea()

    -- Speeds Drawing
    -- mach
    sasl.gl.drawText(
        fontLatoBlack,
        185,
        45,
        "M " .. string.format("%2.2f", get(machSpeed)),
        23,
        false,
        false,
        TEXT_ALIGN_CENTER,
        colourWhite
    )

    sasl.gl.drawConvexPolygon(
        {135, 275, 135, 348, 200, 348, 200, 322, 210, 312, 200, 302, 200, 275, 135, 275},
        true,
        0,
        colourBlack
    )
    sasl.gl.drawConvexPolygon(
        {135, 275, 135, 348, 200, 348, 200, 322, 210, 312, 200, 302, 200, 275, 135, 275},
        false,
        2,
        colourWhite
    )
    sasl.gl.drawText(fontLatoBold, 175, 300, ias2, 27, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.setClipArea(175, 275, 20, 70)

    if ias < 30 then
        iasLastMa = 0
        iasLastAfter = 1
    end
    sasl.gl.drawText(fontLatoBold, 177, iasLastOffset + 300, iasLastMa, 27, false, false, TEXT_ALIGN_LEFT, colourWhite)
    if ias > 30 then
        sasl.gl.drawText(
            fontLatoBold,
            177,
            iasLastOffset + 275,
            iasLastBefore,
            27,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(
            fontLatoBold,
            177,
            iasLastOffset + 250,
            iasLastBeforeAgain,
            27,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
    end
    sasl.gl.drawText(
        fontLatoBold,
        177,
        iasLastOffset + 325,
        iasLastAfter,
        27,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )
    sasl.gl.resetClipArea()

    -- Altitude drawing
    sasl.gl.drawTriangle(640, 303, 629, 312, 640, 322, colourBlack)
    sasl.gl.drawConvexPolygon({640, 275, 640, 348, 730, 348, 730, 275, 640, 275}, true, 1, colourBlack)

    sasl.gl.drawConvexPolygon(
        {640, 275, 640, 302, 630, 312, 640, 322, 640, 348, 730, 348, 730, 275, 640, 275},
        false,
        2,
        colourWhite
    )

    sasl.gl.drawText(fontLatoBold, 683, 300, altitude2, 27, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    sasl.gl.drawText(fontLatoBold, 690, 301, altitudeSecondDigit, 23, false, false, TEXT_ALIGN_CENTER, colourWhite)
    sasl.gl.setClipArea(698, 275, 40, 70)
    sasl.gl.drawText(
        fontLatoBold,
        700,
        altitudeLastOffset + 301,
        string.format("%2.f", altitudeLastMa),
        23,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        700,
        altitudeLastOffset + 276,
        string.format("%2.f", altitudeLastBefore),
        23,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        700,
        altitudeLastOffset + 251,
        string.format("%2.f", altitudeLastBeforeAgain),
        23,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )
    sasl.gl.drawText(
        fontLatoBold,
        700,
        altitudeLastOffset + 326,
        string.format("%2.f", altitudeLastAfter),
        23,
        false,
        false,
        TEXT_ALIGN_LEFT,
        colourWhite
    )
    sasl.gl.resetClipArea()

    -- thing in the middle of the screen
    sasl.gl.drawConvexPolygon({416, 319, 431, 319, 431, 334, 416, 334}, true, 0, colourBlack)
    sasl.gl.drawConvexPolygon({416, 319, 431, 319, 431, 334, 416, 334}, false, 2, colourWhite)

    sasl.gl.drawRectangle(288, 319, 80, 15, colourBlack)
    sasl.gl.drawRectangle(353, 299, 15, 20, colourBlack)
    sasl.gl.drawWidePolyLine({353, 319, 353, 299, 368, 299, 368, 335, 288, 335, 288, 319, 353, 319}, 2, colourWhite)

    sasl.gl.drawRectangle(479, 319, 80, 15, colourBlack)
    sasl.gl.drawRectangle(479, 299, 15, 20, colourBlack)

    sasl.gl.drawWidePolyLine({494, 319, 559, 319, 559, 335, 479, 335, 479, 299, 494, 299, 494, 319}, 2, colourWhite)

    sasl.gl.drawTriangle(422, 475, 427, 485, 417, 485, colourWhite)

    --AUTOFLIGHT BOXES
    if headingAS == 1 then
        sasl.gl.drawText(fontLatoBold, 422, 610, "HDG HOLD", 18, false, false, TEXT_ALIGN_CENTER, colourGreen)
    end
    sasl.gl.drawText(fontLatoBold, 547, 610, "ALT HOLD", 18, false, false, TEXT_ALIGN_CENTER, colourGreen)
    local autoStatus = get(autoflightStatus)
    local autoStat = 0
    if autoStatus == 0 then
        autoStat = "MANUAL"
    elseif autoStatus == 1 then
        autoStat = "FLT DIR"
    elseif autoStatus == 1 then
        autoStat = "AP1"
    elseif autoStatus == 1 then
        autoStat = "AP2"
    end

    sasl.gl.drawText(fontLato, 422, 500, autoStat, 40, false, false, TEXT_ALIGN_CENTER, colourGreen)

    -- amusement overlays
    if verticalSpeed > 8000 or verticalSpeed < -8000 then
        sasl.gl.drawRectangle(0, 300, 850, 60, colourBlack)
        sasl.gl.drawText(
            fontLatoBold,
            425,
            320,
            "Seriously, you're fired!",
            40,
            false,
            false,
            TEXT_ALIGN_CENTER,
            colourGreen
        )
    end

    sasl.gl.resetClipArea()
    sasl.gl.resetClipArea()
end

-- 720, 150, 720, 260, 740, 270, 740, 350, 720, 360, 720, 490, 750, 490, 780, 410, 780, 230, 750, 150, 720, 150

--{720, 150, 750, 150, 780, 230, 780, 410, 750, 490, 720, 490, 720, 360 , 740, 350, 740, 270, 720, 260, 720, 150}
--[[
    local iasLast = string.format("%1.f", ias)
    local iasLastMa = tonumber(tostring(math.floor(ias)):sub(-1))
    local iasLastBefore = iasLastMa -1
    local iasLastBeforeAgain = iasLastMa -2
    local iasLastAfter = iasLastMa +1
    if iasLastMa == 0 then
            iasLastBefore = 9
            iasLastBeforeAgain = 8
    elseif iasLastMa == 9 then
        iasLastAfter = 1
    elseif iasLastMa == 1 then
        iasLastBeforeAgain = 9
    end
    local iasLastOffset = tonumber(tostring(math.floor(ias*10)):sub(-1))*2.5
    sasl.gl.drawConvexPolygon({135, 275, 135, 348, 200, 348,  200, 322, 210, 312, 200, 302,200,275, 135, 275} , true, 0, colourBlack)
    sasl.gl.drawConvexPolygon({135, 275, 135, 348, 200, 348,  200, 322, 210, 312, 200, 302,200,275, 135, 275} , false, 2, colourWhite)
    sasl.gl.drawText(fontLatoBold , 175, 300, ias2, 27, false , false , TEXT_ALIGN_RIGHT , colourWhite)
    sasl.gl.setClipArea(175, 275, 20, 70)

    --]]
