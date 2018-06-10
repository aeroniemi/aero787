size = {640, 480}

local com1Act = globalPropertyi("sim/cockpit2/radios/actuators/com1_frequency_hz_833")
local com1Stby = globalPropertyi("sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833")
local com2Act = globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_hz_833")
local com2Stby = globalPropertyi("sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")
local value5 = string.format("%3.3f", get(com1Stby) / 1000)
local value7 = string.format("%3.3f", get(com2Stby) / 1000)
----------------------------------------------------------------------------------
-- com1 editor
----------------------------------------------------------------------------------
function LR5hand()
    value5 = "- - - . - - -"
    local keyNo = 0
    local value = 0
    function onKeyDown(component, char)
        if keyNo < 6 then
            if tonumber(string.char(char)) ~= nil then
                value = string.char(char)
                --print(string.char(char))
                keyNo = keyNo + 1
                if keyNo == 1 then
                    value = 1
                    value5 = 1 .. value5:sub(3)
                elseif keyNo == 2 then
                    --value5 = meg .. value5:sub(2*keyNo)
                    value5 = 1 .. value .. value5:sub(3)
                elseif keyNo == 3 then
                    value5 = value5:sub(0, 2) .. value .. value5:sub(6)
                elseif keyNo < 7 then
                    value5 = value5:sub(0, keyNo) .. value .. value5:sub(keyNo + 3)
                    if keyNo == 6 then
                        set(com2Stby, tonumber(value7) * 1000)
                    end
                end
            end
        end
    end
end
----------------------------------------------------------------------------------
-- com2 editor
----------------------------------------------------------------------------------
function LR7hand()
    value7 = "- - - . - - -"
    local keyNo = 0
    local value = 0
    function onKeyDown(component, char)
        if keyNo < 6 then
            if tonumber(string.char(char)) ~= nil then
                value = string.char(char)
                --print(string.char(char))
                keyNo = keyNo + 1
                if keyNo == 1 then
                    value = 1
                    value7 = 1 .. value7:sub(3)
                elseif keyNo == 2 then
                    --value5 = meg .. value5:sub(2*keyNo)
                    value7 = 1 .. value .. value7:sub(3)
                elseif keyNo == 3 then
                    value7 = value7:sub(0, 2) .. value .. value7:sub(6)
                elseif keyNo < 7 then
                    value7 = value7:sub(0, keyNo) .. value .. value7:sub(keyNo + 3)
                    if keyNo == 6 then
                        set(com2Stby, tonumber(value7) * 1000)
                    end
                end
            end
        end
    end
end

function draw()
    if get(leftRadioPage) == 1 then
        sasl.registerCommandHandler(LR5, 1, LR5hand)
        sasl.registerCommandHandler(LR7, 1, LR7hand)
    end
    if get(leftRadioPage) == 1 then
        sasl.gl.drawText(fontLatoBold, 16, 28, "<STORE ACTIVE", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(
            fontLatoBold,
            16,
            122,
            "<" .. string.format("%3.3f", get(com2Act) / 1000),
            40,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(fontLatoBold, 16, 218, "<DATA", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(
            fontLatoBold,
            16,
            314,
            "<" .. string.format("%3.3f", get(com1Act) / 1000),
            40,
            false,
            false,
            TEXT_ALIGN_LEFT,
            colourWhite
        )
        sasl.gl.drawText(fontLatoBold, 49, 358, "ACTIVE", 28, false, false, TEXT_ALIGN_LEFT, colourCyan)
        sasl.gl.drawText(fontLatoBold, 592, 358, "STBY", 28, false, false, TEXT_ALIGN_RIGHT, colourCyan)
        sasl.gl.drawText(fontLatoBold, 266, 420, "VHF", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)

        sasl.gl.drawText(fontLatoBold, 300, 314, "- L -", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        --sasl.gl.drawText(fontLatoBold, 300, 218, "- C -", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 300, 122, "- R -", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)

        --sasl.gl.drawText(fontLatoBold, 624, 26, "132.350>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 624, 122, value7 .. ">", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        --sasl.gl.drawText(fontLatoBold, 624, 218, "132.350>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 624, 314, value5 .. ">", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    end
end
