local gearsShape = require("gears.shape")

local Helper = {}

local hexColorMatch = "[a-fA-F0-9][a-fA-F0-9]"

--* Properties
Helper.roundedRectShape = function(cr, width, height)
    gearsShape.rounded_rect(
        cr, width, height, theme.border_radius
    )
end

--* Methods

-- Helper functions for modifying hex colors:
function Helper:mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(hexColorMatch)
    local channels2 = color2:gmatch(hexColorMatch)

    for _ = 1, 3 do
        local bgNumericValue = math.ceil(
          (tonumber("0x" .. channels1()) * ratio) +
            (tonumber("0x" .. channels2()) * (1 - ratio))
        )
        if bgNumericValue < 0 then bgNumericValue = 0 end
        if bgNumericValue > 255 then bgNumericValue = 255 end

        result = result .. string.format("%02x", bgNumericValue)
    end
    
    return result
end

return Helper