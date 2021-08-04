local function array_has_value( array, value_to_find )
    for _, value in ipairs( array ) do
        if value == value_to_find then
            return true
        end
    end

    return false
end

return { array_has_value = array_has_value }
