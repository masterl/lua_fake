local lorem_words = require( './data/lorem_words' )

local word_count = 0

for _, _ in ipairs( lorem_words ) do
    word_count = word_count + 1
end

math.randomseed( os.time() )

local function pick_one( array, size )
    local index = math.random( 1, size )

    return array[index]
end

local function word()
    return pick_one( lorem_words, word_count )
end

local function words( count )
    local result = ''

    for _ = 1, count do
        result = result .. ' ' .. word()
    end

    return result
end

return { word = word, words = words }
