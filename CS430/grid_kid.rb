###############
#             #
# Expressions #
#             #
###############
module Expressions
    # Primative
    class Int
        attr_reader :value
        def initialize(value)
            @value = value
        end

        def evaluate(env)
            self
        end

        def to_s
            "#{@value}"
        end
    end

    class Float
        attr_reader :value
        def initialize(value)
            @value = value
        end

        def evaluate(env)
            self
        end

        def to_s
            "#{@value}"
        end
    end

    class Bool
        attr_reader :value
        def initialize(value)
            @value = value
        end

        def evaluate(env)
            self
        end

        def to_s
            "#{@value}"
        end
    end

    class String
        attr_reader :value
        def initialize(value)
            @value = value
        end

        def evaluate(env)
            self
        end

        def to_s
            "#{@value}"
        end
    end

    # Arithmetic Operations
    class Add
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value + right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value + right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} + #{@right.to_s}"
        end
    end

    class Sub
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value - right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value - right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} - #{@right.to_s}"
        end
    end

    class Mult
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value * right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value * right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} * #{@right.to_s}"
        end
    end

    class Div
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value / right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value / right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} / #{@right.to_s}"
        end
    end

    class Mod
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value % right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value % right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} % #{@right.to_s}"
        end
    end

    class Exp
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value ** right_value.value)
            elsif (left_value.instance_of? Int) && (right_value.instance_of? Float) || (left_value.instance_of? Float) && (right_value.instance_of? Int) || (left_value.instance_of? Float) && (right_value.instance_of? Float)
                Float.new(left_value.value ** right_value.value)
            else
                raise "Operands must be Float or Int"
            end
        end

        def to_s
            "#{@left.to_s} ** #{@right.to_s}"
        end
    end

    # Logical Operations
    class LAnd
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            if (left_value.instance_of? Bool) && (left_value.value == true)
                right_value = @right.evaluate(env)
                if (right_value.instance_of? Bool)
                    Bool.new(left_value.value && right_value.value)
                else
                    raise "Operands must be Bool"
                end
            elsif (left_value.instance_of? Bool) && (left_value.value == false)
                Bool.new(left_value.value)
            else
                raise "Operands must be Bool"
            end
        end

        def to_s
            "#{@left.to_s} && #{@right.to_s}"
        end
    end

    class LOr
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            if (left_value.instance_of? Bool) && (left_value.value == false)
                right_value = @right.evaluate(env)
                if (right_value.instance_of? Bool)
                    Bool.new(left_value.value || right_value.value)
                else
                    raise "Operands must be Bool"
                end
            elsif (left_value.instance_of? Bool) && (left_value.value == true)
                Bool.new(left_value.value)
            else
                raise "Operands must be Bool"
            end
        end

        def to_s
            "#{@left.to_s} || #{@right.to_s}"
        end
    end

    class LNot
        def initialize(operand)
            @operand = operand
        end
        
        def evaluate(env)
            operand_value = @operand.evaluate(env)
            if operand_value.instance_of? Bool
                Bool.new(!operand_value.value)
            else
                raise "Operand must be Bool"
            end
        end

        def to_s
            "!#{@operand.to_s}"
        end
    end

    # Cells
    class Lvalue
        attr_reader :left, :right
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            @left = @left.evaluate(env)
            @right = @right.evaluate(env)
            self
        end

        def to_s
            "$(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Rvalue
        attr_reader :left, :right
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            env.get_query(Rvalue.new(left_value, right_value), env).evaluate(env)
        end

        def to_s
            "@(#{@left.to_s}, #{@right.to_s})"
        end
    end

    # Bitwise Operations
    class BAnd
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value & right_value.value)
            else
                raise "Operands must be Int"
            end
        end

        def to_s
            "#{@left.to_s} & #{@right.to_s}"
        end
    end

    class BOr
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
             right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value | right_value.value)
            else
                raise "Operands must be Int"
            end
        end

        def to_s
            "#{@left.to_s} | #{@right.to_s}"
        end
    end

    class BXor
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value ^ right_value.value)
            else
                raise "Operands must be Int"
            end
        end

        def to_s
            "#{@left.to_s} ^ #{@right.to_s}"
        end
    end

    class BNot
        def initialize(operand)
            @operand = operand
        end
        
        def evaluate(env)
            operand_value = @operand.evaluate(env)
            if operand_value.instance_of? Int
                Int.new(~operand_value.value)
            else
                raise "Operand must be Int"
            end
        end

        def to_s
            "~#{@operand.to_s}"
        end
    end

    class LShift
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value << right_value.value)
            else
                raise "Operands must be Int"
            end
        end

        def to_s
            "#{@left.to_s} << #{@right.to_s}"
        end
    end

    class RShift
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Int) && (right_value.instance_of? Int)
                Int.new(left_value.value >> right_value.value)
            else
                raise "Operands must be Int"
            end
        end

        def to_s
            "#{@left.to_s} >> #{@right.to_s}"
        end
    end

    # Relational Operations
    class Equal
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.value == right_value.value)
        end

        def to_s
            "#{@left.to_s} == #{@right.to_s}"
        end
    end

    class NotEqual
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.value != right_value.value)
        end

        def to_s
            "#{@left.to_s} != #{@right.to_s}"
        end
    end

    class Less
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.value < right_value.value)
        end

        def to_s
            "#{@left.to_s} < #{@right.to_s}"
        end
    end

    class LessEqual
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.value <= right_value.value)
        end

        def to_s
            "#{@left.to_s} <= #{@right.to_s}"
        end
    end

    class Greater
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.evaluate(env).value > right_value.value)
        end

        def to_s
            "#{@left.to_s} > #{@right.to_s}"
        end
    end

    class GreaterEqual
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Bool.new(left_value.value >= right_value.value)
        end

        def to_s
            "#{@left.to_s} >= #{@right.to_s}"
        end
    end
    
    # Casting Operations
    class FloatToInt
        def initialize(operand)
            @operand = operand
        end
        
        def evaluate(env)
            operand_value = @operand.evaluate(env)
            if operand_value.instance_of? Float
                Int.new(operand_value.value.to_i)
            else
                raise "Operand must be Float"
            end
        end

        def to_s
            "int(#{@operand.to_s})"
        end
    end

    class IntToFloat
        def initialize(operand)
            @operand = operand
        end
        
        def evaluate(env)
            operand_value = @operand.evaluate(env)
            if operand_value.instance_of? Int
                Float.new(operand_value.value.to_f)
            else
                raise "Operand must be Int"
            end
        end

        def to_s
            "float(#{@operand.to_s})"
        end
    end

    # Statistical Functions
    class Max
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Lvalue) && (right_value.instance_of? Lvalue)
                x = env.get_query(left_value, env)
                for i in left_value.left.value..right_value.left.value
                    for j in left_value.right.value..right_value.right.value
                        y = env.get_query(Lvalue.new(Expressions::Int.new(left_value.left.value + i), Expressions::Int.new(left_value.right.value + j)), env)
                        if Less.new(x, y).evaluate(env).value
                            x = y
                        end
                    end
                end 
                x
            else
                raise "Operands must be Lvalue"
            end
        end

        def to_s
            "max(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Min
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Lvalue) && (right_value.instance_of? Lvalue)
                x = env.get_query(left_value, env)
                for i in left_value.left.value..right_value.left.value
                    for j in left_value.right.value..right_value.right.value
                        y = env.get_query(Lvalue.new(Expressions::Int.new(left_value.left.value + i), Expressions::Int.new(left_value.right.value + j)), env)
                        if Less.new(y, x).evaluate(env).value
                            x = y
                        end
                    end
                end 
                x
            else
                raise "Operands must be Lvalue"
            end
        end

        def to_s
            "min(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Mean
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Lvalue) && (right_value.instance_of? Lvalue)
                x = 0
                count = 0
                for i in left_value.left.value..right_value.left.value
                    for j in left_value.right.value..right_value.right.value
                        count += 1
                        x = Expressions::Add.new(env.get_query(Lvalue.new(Expressions::Int.new(left_value.left.value + i), Expressions::Int.new(left_value.right.value + j)), env), Expressions::Int.new(x)).evaluate(env).value
                    end
                end 
                Expressions::Div.new(Expressions::Int.new(x), Expressions::Int.new(count)).evaluate(env).value
            else
                raise "Operands must be Lvalue"
            end
        end

        def to_s
            "mean(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Sum
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            if (left_value.instance_of? Lvalue) && (right_value.instance_of? Lvalue)
                x = 0
                for i in left_value.left.value..right_value.left.value
                    for j in left_value.right.value..right_value.right.value
                        x += env.get_query(Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), env).evaluate(env).value
                    end
                end 
                Expressions::Int.new(x)
            else
                raise "Operands must be Lvalue"
            end
        end

        def to_s
            "sum(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Block
        def initialize(expressions)
            @exprs = expressions
        end

        def evaluate(env)
            @exprs.each { |expr| expr.evaluate(env)}
            @exprs[-1].evaluate(env)
        end

        def to_s
            result = "{\n"
            for expr in @exprs
                result += "#{expr}\n"
            end
            result += "}"
            result
        end
    end

    class Assignment
        def initialize(name, expr)
            @id =  name
            @stored = expr
        end

        def evaluate(env)
            name = @id.evaluate(env).value
            env.set_var(name, @stored.evaluate(env))
            self
        end

        def to_s
            "#{@id} = #{@stored}"
        end
    end

    class Reference
        def initialize(name)
            @id = name
        end

        def evaluate(env)
            name = @id.evaluate(env).value
            env.get_var(name)
        end

        def to_s
            "#{@id}"
        end
    end

    class Conditional
        def initialize(condition, if_block, else_block)
            @cond = condition
            @if = if_block
            @else = else_block
        end

        def evaluate(env)
            if @cond.evaluate(env).value
                @if.evaluate(env)
            else
                @else.evaluate(env)
            end
        end

        def to_s
            "if #{@cond}\n#{@if}\nelse\n#{@else}\nend"
        end
    end

    class ForEach
        def initialize(iterator, start_address, end_address, eval_block)
            @iter = iterator
            @start_add = start_address
            @end_add = end_address
            @block = eval_block
        end

        def evaluate(env)
            left_value = @start_add.evaluate(env)
            right_value = @end_add.evaluate(env)
            for i in left_value.left.value..right_value.left.value
                for j in left_value.right.value..right_value.right.value
                    name = @iter.evaluate(env).value
                    env.set_var(name, Expressions::Rvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)))
                    @block.evaluate(env)
                end
            end
            Expressions::Rvalue.new(Expressions::Int.new(i), Expressions::Int.new(j))
        end

        def to_s
            "for #{@iter} in #{@start_add}..#{@end_add}\n#{@block}end"
        end
    end
end

module Environment
    class Environment
        attr_accessor :grid
        def initialize
            @grid = Grid::Grid.new()
            @vars = []
        end

        def set_var(id, expression)
            result = @vars.select{ |var| var[:id] == id}
            if result[0] == nil
                @vars.push({id: id, expr:expression})
            else
                result[0].replace({id: id, expr:expression})
            end
        end

        def get_var(id)
            result = @vars.select{ |var| var[:id] == id}
            if result[0] == nil
                raise "No variable named #{id}."
            end
            result[0][:expr]
        end

        def set_query(address, expression)
            @grid.set(address, expression)
        end

        def get_query(address, env)
            @grid.get(address, env)
        end
    end
end

module Grid
    class Grid
        def initialize
            @grid = []
        end

        def set(address, expression)
            result = @grid.select{ |cell| cell[:row] == address.left.value && cell[:col] == address.right.value}
            if result[0] == nil
                @grid.push({row: address.left.value, col:address.right.value, value: expression})
            else
                result[0].replace({row: address.left.value, col:address.right.value, value: expression})
            end
        end

        def get(address, env)
            result = @grid.select{ |cell| cell[:row] == address.left.value && cell[:col] == address.right.value}
            if result[0] == nil
                raise "No cell at (#{address.left}, #{address.right})"
            end
            result[0][:value]
        end
    end
end


###############
#             #
#    Lexer    #
#             #
###############
module Lexer
    class Lexer
        def initialize(source)
            @source = source
        end

        def lex
            @i = 0
            @j = 0
            @token_so_far = ''
            @tokens = []

            while @i < @source.length
                if has('+')
                    capture
                    emit_token(:plus)
                elsif has('-')
                    capture
                    emit_token(:minus)
                elsif has('#')
                    capture
                    emit_token(:ref)
                elsif has('\\')
                    capture
                    emit_token(:break)
                elsif has('%')
                    capture
                    emit_token(:assign)
                elsif has('{')
                    capture
                    emit_token(:left_bracket)
                elsif has('}')
                    capture
                    emit_token(:right_bracket)
                elsif has('(')
                    capture
                    emit_token(:left_parenthesis)
                elsif has(')')
                    capture
                    emit_token(:right_parenthesis)
                elsif has('*')
                    capture
                    if has('*')
                        capture
                        emit_token(:exponent)
                    else
                        emit_token(:multipy)
                    end
                elsif has('/')
                    capture
                    emit_token(:divide)
                elsif has('%')
                    capture
                    emit_token(:modulo)
                elsif has('$')
                    capture
                    emit_token(:l_value)
                elsif has('@')
                    capture
                    emit_token(:r_value)
                elsif has('&')
                    capture
                    if has('&')
                        capture
                        emit_token(:logical_and)
                    else
                        emit_token(:bitwise_and)
                    end
                elsif has('|')
                    capture
                    if has('|')
                        capture
                        emit_token(:logical_or)
                    else
                        emit_token(:bitwise_or)
                    end
                elsif has('^')
                    capture
                    emit_token(:bitwise_xor)
                elsif has('~')
                    capture
                    emit_token(:bitwise_not)
                elsif has('!')
                    capture
                    if has('=')
                        capture
                        emit_token(:not_equal)
                    else
                        emit_token(:logical_not)
                    end
                elsif has('=')
                    capture
                    if has('=')
                        capture
                        emit_token(:equal)
                    else
                        emit_token(:assignment)
                    end
                elsif has('<')
                    capture
                    if has('<')
                        capture
                        emit_token(:left_shift)
                    elsif has('=')
                        capture
                        emit_token(:less_than_or_equal)
                    else
                        emit_token(:less_than)
                    end
                elsif has('>')
                    capture
                    if has('>')
                        capture
                        emit_token(:right_shift)
                    elsif has('=')
                        capture
                        emit_token(:greater_than_or_equal)
                    else
                        emit_token(:greater_than)
                    end
                elsif has_digit
                    while has_digit
                        capture
                    end
                    if has('.')
                        capture
                        while has_digit
                            capture
                        end
                        emit_token(:float_literal)
                    else
                        emit_token(:integer_literal)
                    end
                elsif has('i')
                    done = false
                    capture
                    if has('n')
                        capture
                        if has('t')
                            done = true
                            capture
                            emit_token(:int)
                        else
                            done = true
                            emit_token(:in)
                        end
                    elsif has('f')
                        done = true
                        capture
                        emit_token(:if)
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has('t')
                    done = false
                    capture
                    if has('r')
                        capture
                        if has('u')
                            capture
                            if has('e')
                                done = true
                                capture
                                emit_token(:boolean_literal)
                            end
                        end
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has('f')
                    done = false
                    capture
                    if has('a')
                        capture
                        if has('l')
                            capture
                            if has('s')
                                capture
                                if has('e')
                                    done = true
                                    capture
                                    emit_token(:boolean_literal)
                                end
                            end
                        end
                    elsif has('l')
                        capture
                        if has('o')
                            capture
                            if has('a')
                                capture
                                if has('t')
                                    done = true
                                    capture
                                    emit_token(:float)
                                end
                            end
                        end
                    elsif has('o')
                        capture
                        if has('r')
                            done = true
                            capture
                            emit_token(:for)
                        end
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has('m')
                    done = false
                    capture
                    if has('a')
                        capture
                        if has('x')
                            done = true
                            capture
                            emit_token(:max)
                        end
                    elsif has('i')
                        capture
                        if has('n')
                            done = true
                            capture
                            emit_token(:min)
                        end
                    elsif has('e')
                        capture
                        if has('a')
                            capture
                            if has('n')
                                done = true
                                capture
                                emit_token(:mean)
                            end
                        end
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has('s')
                    done = false
                    capture
                    if has('u')
                        capture
                        if has('m')
                            done = true
                            capture
                            emit_token(:sum)
                        end
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has('e')
                    done = false
                    capture
                    if has('l')
                        capture
                        if has('s')
                            capture
                            if has('e')
                                done = true
                                capture
                                emit_token(:else)
                            end
                        end
                    elsif has('n')
                        capture
                        if has('d')
                            done = true
                            capture
                            emit_token(:end)
                        end
                    end
                    if !done
                        while has_letter
                            capture
                        end
                        emit_token(:string_literal)
                    end
                elsif has_letter
                    while has_letter
                        capture
                    end
                    emit_token(:string_literal)
                elsif has(',')
                    capture
                    emit_token(:comma)
                else
                    @j += 1
                    @token_so_far = ''
                end
            end
            @tokens
        end

        def has(character)
            @j < @source.length && @source[@j] == character
        end

        def has_letter
            @j < @source.length && 'a' <= @source[@j] && @source[@j] <= 'z'
        end

        def has_digit
            @j < @source.length && '0' <= @source[@j] && @source[@j] <= '9'
        end

        def capture
            @token_so_far += @source[@j]
            @j += 1
        end

        def emit_token(type)
            @tokens << {type: type, source: @token_so_far, start: @i, end:@j}
            @i = @j
            @token_so_far = ''
        end
    end
end


###############
#             #
#    Parser   #
#             #
###############
module Parser
    class Parser
        def initialize(tokens)
            @tokens = tokens
            @i = 0
            @j = 0
            @k = 0
        end

        def has(type)
            @i < @tokens.length && @tokens[@i][:type] == type
        end

        def advance
            token = @tokens[@i]
            @i += 1
            @j = token[:start]
            @k = token[:end]
            token
        end

        # Order expression -> logical -> bitwise -> equality -> relational -> shift -> additive -> multiplictive -> unary -> atom
        def expression
            logical
        end

        def logical
            left = bitwise
            while has(:logical_and) || has(:logical_or)
                if has(:logical_and)
                    advance
                    right = bitwise
                    left = Expressions::LAnd.new(left, right)
                else
                    advance
                    right = bitwise
                    left = Expressions::LOr.new(left, right)
                end
            end
            left
        end

        def bitwise
            left = equality
            while has(:bitwise_and) || has(:bitwise_or) || has(:bitwise_xor)
                if has(:bitwise_and)
                    advance
                    right = equality
                    left = Expressions::BAnd.new(left, right)
                elsif has(:bitwise_or)
                    advance
                    right = equality
                    left = Expressions::BOr.new(left, right)
                else
                    advance
                    right = equality
                    left = Expressions::BXor.new(left, right)
                end
            end
            left
        end

        def equality
            left = relational
            while has(:equal) || has(:not_equal)
                if has(:equal)
                    advance
                    right = relational
                    left = Expressions::Equal.new(left, right)
                else
                    advance
                    right = relational
                    left = Expressions::NotEqual.new(left, right)
                end
            end
            left
        end

        def relational
            left = shift
            while has(:less_than_or_equal) || has(:greater_than_or_equal) || has(:less_than) || has(:greater_than)
                if has(:less_than_or_equal)
                    advance
                    right = shift
                    left = Expressions::LessEqual.new(left, right)
                elsif has(:greater_than_or_equal)
                    advance
                    right = shift
                    left = Expressions::GreaterEqual.new(left, right)
                elsif has(:less_than)
                    advance
                    right = shift
                    left = Expressions::Less.new(left, right)
                else
                    advance
                    right = shift
                    left = Expressions::Greater.new(left, right)
                end
            end
            left
        end

        def shift
            left = additive
            while has(:right_shift) || has(:left_shift)
                if has(:right_shift)
                    advance
                    right = additive
                    left = Expressions::RShift.new(left, right)
                else
                    advance
                    right = additive
                    left = Expressions::LShift.new(left, right)
                end
            end
            left
        end

        def additive
            left = multiplicative
            while has(:plus) || has(:minus)
                if has(:plus)
                    advance
                    right = multiplicative
                    left = Expressions::Add.new(left, right)
                else
                    advance
                    right = multiplicative
                    left = Expressions::Sub.new(left, right)
                end
            end
            left
        end

        def multiplicative
            left = unary
            while has(:multipy) || has(:divide) || has(:modulo) || has(:exponent)
                if has(:multipy)
                    advance
                    right = unary
                    left = Expressions::Mult.new(left, right)
                elsif has(:divide)
                    advance
                    right = unary
                    left = Expressions::Div.new(left, right)
                elsif has(:modulo)
                    advance
                    right = unary
                    left = Expressions::Mod.new(left, right)
                else
                    advance
                    right = unary
                    left = Expressions::Exp.new(left, right)
                end
            end
            left
        end

        def unary
            right = ""
            if has(:bitwise_not)
                while has(:bitwise_not)
                    advance
                    right = atom
                    right = Expressions::BNot.new(right)
                end
            elsif has(:logical_not)
                while has(:logical_not)
                    advance
                    right = atom
                    right = Expressions::LNot.new(right)
                end
            else
                right = atom
            end
            right
        end

        def atom
            id_token = advance
            if id_token[:type] == :integer_literal
                Expressions::Int.new(id_token[:source].to_i)
            elsif id_token[:type] == :float_literal
                Expressions::Float.new(id_token[:source].to_f)
            elsif id_token[:type] == :string_literal
                Expressions::String.new(id_token[:source].to_s)
            elsif id_token[:type] == :if
                if has(:left_parenthesis)
                    advance
                    cond = expression
                    if has(:right_parenthesis)
                        advance
                        if_block = expression
                        advance
                        if has(:else)
                            advance
                            else_block = expression
                            advance
                            if has(:end)
                                advance
                                Expressions::Conditional.new(cond, if_block, else_block)
                            else
                                raise "Missing end"
                            end
                        else
                            raise "Missing else clause"
                        end
                    else
                        raise "Missing ')' for condition"
                    end
                else
                    raise "Missing '(' for condition"
                end

            elsif id_token[:type] == :for
                id_token = advance
                if id_token[:type] == :string_literal
                    var = Expressions::String.new(id_token[:source].to_s)
                    if has(:in)
                        advance
                        start_address = expression
                        end_address = expression
                        block = expression
                        advance
                        if has(:end)
                            advance
                            Expressions::ForEach.new(var, start_address, end_address, block)
                        else
                            raise "Missing end"
                        end
                    else
                        raise "Missing in"
                    end
                else
                    raise "Missing looping var"
                end
            elsif id_token[:type] == :ref
                id_token = advance
                if id_token[:type] == :string_literal
                    Expressions::Reference.new(Expressions::String.new(id_token[:source].to_s))
                end
            elsif id_token[:type] == :assign
                id_token = advance
                if id_token[:type] == :string_literal
                    name = Expressions::String.new(id_token[:source].to_s)
                    if has(:assignment)
                        advance
                        expr = expression
                        Expressions::Assignment.new(name, expr)
                    end
                end
            elsif id_token[:type] == :left_bracket
                exprs = []
                while !has(:right_bracket)
                    expr = expression
                    exprs.push(expr)
                end
                Expressions::Block.new(exprs)
            elsif id_token[:type] == :boolean_literal
                if id_token[:source].downcase == "true"
                    Expressions::Bool.new(true)
                else
                    Expressions::Bool.new(false)
                end
            elsif id_token[:type] == :r_value
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Rvalue.new(expr_a, expr_b)
            elsif id_token[:type] == :l_value
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Lvalue.new(expr_a, expr_b)
            elsif id_token[:type] == :max
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Max.new(expr_a, expr_b)
            elsif id_token[:type] == :min
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Min.new(expr_a, expr_b)
            elsif id_token[:type] == :mean
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Mean.new(expr_a, expr_b)
            elsif id_token[:type] == :sum
                if has(:left_parenthesis)
                    advance
                    expr_a = expression
                    if has(:comma)
                        advance
                        expr_b = expression
                        if has(:right_parenthesis)
                            advance
                        else
                            raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                        end
                    else
                        raise "Missing comma. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::Sum.new(expr_a, expr_b)
            elsif id_token[:type] == :int
                if has(:left_parenthesis)
                    advance
                    expr = expression
                    if has(:right_parenthesis)
                        advance
                    else
                        raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::FloatToInt.new(expr)
            elsif id_token[:type] == :float
                if has(:left_parenthesis)
                    advance
                    expr = expression
                    if has(:right_parenthesis)
                        advance
                    else
                        raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                    end
                else
                    raise "Missing left parenthesis. start: #{@j} end: #{@k}"
                end
                Expressions::IntToFloat.new(expr)
            elsif id_token[:type] == :left_parenthesis
                expr = expression
                if has(:right_parenthesis)
                    advance
                else
                    raise "Missing right parenthesis. start: #{@j} end: #{@k}"
                end
                expr
            else
                raise "Bad token #{@tokens[@i][:type]} start: #{@j} end: #{@k}"
            end
        end
    end
end