function draw()
    if get(leftRadioPage) == 0 or get(leftRadioPage) > 7 then
        sasl.gl.drawText(
            fontLatoBold,
            320,
            210,
            "An Error has occured",
            60,
            false,
            false,
            TEXT_ALIGN_CENTER,
            colourYellow
        )
        drawAll(components)
    end
end
