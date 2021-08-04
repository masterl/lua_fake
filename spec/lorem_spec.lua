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
end )
