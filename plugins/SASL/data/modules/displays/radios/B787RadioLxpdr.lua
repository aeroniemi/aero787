size = {640, 480}

local xpdrCode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_code")

local value1 = string.format("%04.f", get(xpdrCode))

----------------------------------------------------------------------------------
-- xpdr editor
----------------------------------------------------------------------------------
function LR1hand()
    value1 = "- - - - "
    local keyNo = 0
    local value = 0
    function onKeyDown(component, char)
        if keyNo < 4 then
            if tonumber(string.char(char)) ~= nil then
                value = string.char(char)
                --print(string.char(char))
                keyNo = keyNo + 1
                if keyNo == 1 then
                    value1 = value .. value1:sub(3)
                elseif keyNo < 5 then
                    value1 = value1:sub(0, keyNo) .. value .. value1:sub(keyNo + 2)
                    if keyNo == 4 then
                        set(xpdrCode, tonumber(value1))
                    end
                end
            end
        end
    end
end

if get(leftRadioPage) == 7 then
    sasl.registerCommandHandler(LR1, 1, LR1hand)
end
function draw()
    if get(leftRadioPage) == 7 then
        --sasl.gl.drawText(fontLatoBold, 16, 18, "<L<>R", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        --sasl.gl.drawText(fontLatoBold, 16, 114, "<", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 16, 218, "<IDENT", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 16, 314, "<" .. value1, 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLato, 49, 358, "XPDR CODE", 28, false, false, TEXT_ALIGN_LEFT, colourCyan)
        --sasl.gl.drawText(fontLatoBold, 592, 350, "CAPT TCAS", 28, false, false, TEXT_ALIGN_RIGHT, colourCyan)
        sasl.gl.drawText(fontLatoBold, 320, 420, "TRANSPONDER", 40, false, false, TEXT_ALIGN_CENTER, colourWhite)

    --sasl.gl.drawText(fontLatoBold, 624, 18, "132.350>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 114, "BELOW>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 210, "NORM>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 306, "ABOVE>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    end
end
