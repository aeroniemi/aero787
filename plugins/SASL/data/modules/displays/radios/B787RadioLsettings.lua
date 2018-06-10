size = {640, 480}

local xpdrCode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_code")

local value1 = get(flightNumber)
local value2 = get(selcalCode)

----------------------------------------------------------------------------------
-- xpdr editor
----------------------------------------------------------------------------------
function LR1hand()
    value1 = "- - -"
    local keyNo = 0
    local value = 0
    function onKeyDown(component, char)
        if keyNo < 8 then
            if char == 13 then
                set(flightNumber, value1)
            elseif tonumber(string.char(char)) ~= nil then
                value = string.upper(string.char(char))
                print(value)
                keyNo = keyNo + 1
                if keyNo == 1 then
                    value1 = value .. value1:sub(3)
                elseif keyNo < 9 then
                    value1 = value1:sub(0, keyNo - 1) .. value .. value1:sub(keyNo + 2)
                    if keyNo == 8 then
                        set(flightNumber, value1)
                    end
                end
            end
        end
    end
end
function LR5hand()
    value2 = "- - - -"
    local keyNo = 0
    local value = 0
    function onKeyDown(component, char)
        if keyNo < 4 then
            if not string.char(char):match("%W") and tonumber(string.char(char)) == nil then
                value = string.upper(string.char(char))

                keyNo = keyNo + 1
                if keyNo == 1 then
                    value2 = value .. value2:sub(3)
                elseif keyNo == 2 then
                    value2 = value2:sub(0, 1) .. value .. "-" .. value2:sub(4)
                elseif keyNo == 3 then
                    value2 = value2:sub(0, 3) .. value .. value2:sub(5)
                elseif keyNo == 4 then
                    value2 = value2:sub(0, 4) .. value
                    set(selcalCode, value2)
                end
            end
        end
    end
end

--[[ if keyNo == 4 then
    set(xpdrCode, tonumber(value1))
end--]]
if get(leftRadioPage) == 2 then
    sasl.registerCommandHandler(LR1, 1, LR1hand)
    sasl.registerCommandHandler(LR5, 1, LR5hand)
end
function draw()
    if get(leftRadioPage) == 2 then
        --sasl.gl.drawText(fontLatoBold, 16, 18, "<L<>R", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        --sasl.gl.drawText(fontLatoBold, 16, 114, "<", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        --sasl.gl.drawText(fontLatoBold, 16, 218, "<IDENT", 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLatoBold, 16, 314, "<" .. value1, 40, false, false, TEXT_ALIGN_LEFT, colourWhite)
        sasl.gl.drawText(fontLato, 49, 358, "FLIGHT NO", 28, false, false, TEXT_ALIGN_LEFT, colourCyan)
        --sasl.gl.drawText(fontLatoBold, 592, 350, "CAPT TCAS", 28, false, false, TEXT_ALIGN_RIGHT, colourCyan)
        sasl.gl.drawText(fontLatoBold, 320, 420, "FLIGHT SETTINGS", 40, false, false, TEXT_ALIGN_CENTER, colourWhite)
        sasl.gl.drawText(fontLatoBold, 624, 314, value2 .. ">", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
        sasl.gl.drawText(fontLato, 624, 358, "SELCAL", 28, false, false, TEXT_ALIGN_RIGHT, colourCyan)
    --sasl.gl.drawText(fontLatoBold, 624, 18, "132.350>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 114, "BELOW>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 210, "NORM>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    --sasl.gl.drawText(fontLatoBold, 624, 306, "ABOVE>", 40, false, false, TEXT_ALIGN_RIGHT, colourWhite)
    end
end
