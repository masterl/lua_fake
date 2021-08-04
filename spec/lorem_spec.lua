insulate( 'Lorem generators', function()
    local Lorem = require( 'src/lorem' )
    local lorem_words = require( 'src/data/lorem_words' )
    local test_helpers = require( 'spec/test_helpers' )
    local array_has_value = test_helpers.array_has_value

    describe( 'word', function()
        local word

        setup( function()
            word = Lorem.word()
        end )

        it( 'should return a word', function()
            assert.is_true( type( word ) == 'string' )
            assert.are.equals( string.match( word, '%a+' ), word )
        end )

        it( 'the word should be a lorem one', function()
            assert.is_true( array_has_value( lorem_words, word ) )
        end )

        it( 'should pick words randomly', function()
            local values = {}
            local total_count = 50

            for _ = 1, total_count do
                table.insert( values, Lorem.word() )
            end

            local equal_words = 1
            for i = 2, total_count do
                if values[i] == values[1] then
                    equal_words = equal_words + 1
                end
            end

            assert.is_not.equal( equal_words, total_count )
        end )
    end )

    describe( 'words', function()
        local words
        local word_count

        before_each( function()
            word_count = math.random( 2, 10 )
            words = Lorem.words( word_count )
        end )

        it( 'should generate the specified amount of words', function()
            local count = 0
            for _ in string.gmatch( words, '(%a+)' ) do
                count = count + 1
            end

            assert.is.equal( word_count, count )
        end )

        it( 'each word should be a valid lorem word', function()
            for k in string.gmatch( words, '(%a+)' ) do
                assert.is_true( array_has_value( lorem_words, k ) )
            end
        end )
    end )
end )
