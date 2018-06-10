size = {640, 480}

function draw()
    drawAll(components)
end

function update()
    updateAll(components)
end

--[[
0 - error
1 - VHF
2 - settings
3 - error
4 - CAB (error)
5 - GPWS (error)
6 - WXR (error)
7 - XPDR
--]]
components = {
    B787RadioErrorPage {position = {0, 0, 640, 480}},
    B787RadioLvhf {position = {0, 0, 640, 480}},
    B787RadioLxpdr {position = {0, 0, 640, 480}},
    B787RadioLsettings {position = {0, 0, 640, 480}}
}
