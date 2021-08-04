-- LuaFormatter off
local lorem = {
    words       = require( './data/lorem_words' ),
    total_count = 0
}
-- LuaFormatter on

for _, _ in ipairs( lorem.words ) do
    lorem.total_count = lorem.total_count + 1
end

math.randomseed( os.time() )

local function pick_one( array, size )
    local index = math.random( 1, size )

    return array[index]
end

local function capitalize( str )
    return str:gsub( '^%l', string.upper )
end

local function word()
    return pick_one( lorem.words, lorem.total_count )
end

local function words( count )
    local result = word()

    for _ = 2, count do
        result = result .. ' ' .. word()
    end

    return result
end

local function sentence( word_count )
    if word_count == nil then
        word_count = math.random( 3, 12 )
    end

    return capitalize( words( word_count ) ) .. '.'
end

local function sentences( count, separator )
    local result = sentence()

    if count == nil then
        count = math.random( 2, 6 )
    end

    if separator == nil then
        separator = ' '
    end

    for _ = 2, count do
        result = result .. separator .. sentence()
    end

    return result
end

-- LuaFormatter off
return {
    word = word,
    words = words,
    sentence = sentence,
    sentences = sentences
}
-- LuaFormatter on
