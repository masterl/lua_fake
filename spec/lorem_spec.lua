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
            local total_count<const> = 50

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

    describe( 'sentence', function()
        it( 'should generate the specified amount of words', function()
            local word_count<const> = 17
            local sentence<const> = Lorem.sentence( word_count )

            local count = 0
            for _ in string.gmatch( sentence, '(%a+)' ) do
                count = count + 1
            end

            assert.is.equal( word_count, count )
        end )

        it( 'each word should be a valid lorem word', function()
            local word_count<const> = 8
            local sentence<const> = Lorem.sentence( word_count )

            for k in string.gmatch( sentence, '(%a+)' ) do
                assert.is_true( array_has_value( lorem_words, k,
                                                 { ignore_case = true } ) )
            end
        end )

        it( 'should generate between 3 and 12 words by default', function()
            local sentence<const> = Lorem.sentence()

            local count = 0
            for _ in string.gmatch( sentence, '(%a+)' ) do
                count = count + 1
            end

            assert.is_true( count >= 3 and count <= 12 )
        end )

        it( 'sentence should be capitalized', function()
            local sentence<const> = Lorem.sentence()

            local first_letter<const> = string.gmatch( sentence, '%u' )()

            assert.is_equal( 1, string.len( first_letter ) )
        end )

        it( 'sentence should end on point', function()
            local sentence<const> = Lorem.sentence()

            assert.is_equal( '.', sentence:sub( -1 ) )
        end )
    end )

    describe( 'sentences', function()
        it( 'each word should be a valid lorem word', function()
            local sentences<const> = Lorem.sentences()

            for k in string.gmatch( sentences, '(%a+)' ) do
                assert.is_true( array_has_value( lorem_words, k,
                                                 { ignore_case = true } ) )
            end
        end )

        it( 'should end on point', function()
            local sentences<const> = Lorem.sentences()

            assert.is_equal( '.', sentences:sub( -1 ) )
        end )

        it( 'should generate specified amount of sentences', function()
            local amount<const> = 5
            local sentences<const> = Lorem.sentences( 5 )

            local count = 0
            for _ in string.gmatch( sentences, '[.]' ) do
                count = count + 1
            end

            assert.is_equal( amount, count )
        end )

        it( 'should generate between 2 and 6 sentences by default', function()
            local sentences<const> = Lorem.sentences()

            local count = 0
            for _ in string.gmatch( sentences, '[.]' ) do
                count = count + 1
            end

            assert.is_true( count >= 2 and count <= 6 )
        end )

        it( 'should accept a separator', function()
            local amount<const> = 7
            local sentences<const> = Lorem.sentences( 7, '+' )

            local count = 0
            for _ in string.gmatch( sentences, '[+]' ) do
                count = count + 1
            end

            assert.is.equal( amount - 1, count )
        end )

        it( 'should default separator to space', function()
            local amount<const> = 7
            local sentences<const> = Lorem.sentences( 7 )

            local count = 0
            for _ in string.gmatch( sentences, '[.][ ]' ) do
                count = count + 1
            end

            assert.is.equal( amount - 1, count )
        end )
    end )

    describe( 'paragraph', function()
        it( 'should default to between 3 and 6 sentences', function()
            local paragraph<const> = Lorem.paragraph()

            local count = 0
            for _ in string.gmatch( paragraph, '[.][ ]' ) do
                count = count + 1
            end

            assert.is_true( count >= 2 and count <= 5 )
        end )

        it( 'each word should be a valid lorem word', function()
            local paragraph<const> = Lorem.paragraph()

            for k in string.gmatch( paragraph, '(%a+)' ) do
                assert.is_true( array_has_value( lorem_words, k,
                                                 { ignore_case = true } ) )
            end
        end )

        it( 'should generate specified amount of sentences', function()
            local amount<const> = 17
            local paragraph<const> = Lorem.paragraph( amount )

            local count = 0
            for _ in string.gmatch( paragraph, '[.][ ]' ) do
                count = count + 1
            end

            assert.is.equal( amount - 1, count )
        end )
    end )
end )
