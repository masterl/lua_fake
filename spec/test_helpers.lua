local function array_has_value( array, value_to_find, option )
    if option and option.ignore_case then
        for _, value in ipairs( array ) do
            if value:lower() == value_to_find:lower() then
                return true
            end
        end
    else
        for _, value in ipairs( array ) do
            if value == value_to_find then
                return true
            end
        end
    end

    return false
end

return { array_has_value = array_has_value }
