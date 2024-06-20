module Model
    class Color
        attr_reader :r, :g, :b

        def initialize(r, g, b)
            @r = r
            @g = g
            @b = b
        end

        def evaluate(env)
            self
        end

        def to_s
            "#{@r} #{@g} #{@b}"
        end
    end

    class Add
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @righ.evaluate(env)
            Color.new(
                [0, left_value.r + right_value.r].max,
                [0, left_value.g + right_value.g].max,
                [0, left_value.b + right_value.b].max
            )
        end
    end

    class Subtract
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @righ.evaluate(env)
            Color.new(
                [0, left_value.r - right_value.r].max,
                [0, left_value.g - right_value.g].max,
                [0, left_value.b - right_value.b].max
            )
        end
    end

    class Complement
        def initialize(operand)
            @operand = operand
        end

        def evaluate(env)
            operand_value = @operand.evaluate(env)
            Color.new(
                1 - operand_value.r,
                1 - operand_value.g,
                1 - operand_value.b,
            )
        end
    end

red = Color.new(1,0,0)
flipRed = Complement.new(red)
blue = Color.new(0, 0, 1)
sum = Add.new(flipRed, blue)
end


class Lexer
    def initialize(source)
        @source = source
    end

    def lex
        @i = 0
        @token_so_far = ''
        @tokens = []

        while @i < @source.length
            if has('+')
                capture
                emit_token(:plus)
            elsif has('-')
                capture
                emit_token(:hyphen)
            elsif has('~')
                capture
                emit_token(:tilde)
            elsif has('(')
                capture
                emit_token(:left_parenthesis)
            elsif has(')')
                capture
                emit_token(:right_parenthesis)
            elsif has_letter
                while has_letter
                    capture
                end
                emit_token(:id)
            else
                @i += 1
                @token_so_far = ''
            end
        end

        @tokens
    end

    def has(character)
        @i < @source.length && @source[@i] == character
    end

    def has_letter
        @i < @source.length && 'a' <= @source[@i] && @source[@i] <= 'z'
    end

    def capture
        @token_so_far += @source[@i]
        @i += 1
    end

    def emit_token(type)
        @tokens << {type: type, source: @token_so_far}
        @token_so_far = ''
    end
end

lexer = Lexer.new('red + blue')
tokens = lexer.lex
puts tokens

class Parser
    def initialize(tokens)
        @tokens = tokens
        @i = 0
    end

    def has(type)
        @i < @tokens.length && @tokens[@i][:type] == type
    end

    def advance
        token = @tokens[@i]
        @i += 1
        token
    end

    def expr
        additive
    end

    def additive
        left = unary
        while has(:plus)
            advance
            right = unary
            left = Model::Add.new(left, right)
        end
        left
    end

    def unary
        atom
    end

    def atom
        if has(:left_parenthesis)
            advance
            e = expr
            if has(:right_parenthesis)
                advance
            else
                raise "Missing right parenthesis."
            end
            e
        elsif has(:id)
            id_token = advance
            if id_token[:source] == 'red'
                Model::Color.new(1,0,0)
            elsif id_token[:source] == 'blue'
                Model::Color.new(0,0,1)
            elsif id_token[:source] == 'cyan'
                Model::Color.new(0,1,1)
            else
                raise "Unokn color #{id_token[:source]}"
            end
        else
            raise "Bad token #{@tokens[@i][:type]}"
        end
    end
end

parser = Parser.new(tokens)
ast = parser.expr
puts ast