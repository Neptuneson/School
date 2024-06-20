module Expressions

    # Primative
    class Integer
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

    class Boolean
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
    class Addition
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value + right_value.value)
        end

        def to_s
            "#{@left.to_s} + #{@right.to_s}"
        end
    end

    class Subtraction
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value - right_value.value)
        end

        def to_s
            "#{@left.to_s} - #{@right.to_s}"
        end
    end

    class Multiplication
        def initialize(left, right)
            @left = left
            @right = right
        end

        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value * right_value.value)
        end

        def to_s
            "#{@left.to_s} * #{@right.to_s}"
        end
    end

    class Division
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value / right_value.value)
        end

        def to_s
            "#{@left.to_s} / #{@right.to_s}"
        end
    end

    class Modulo
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value % right_value.value)
        end

        def to_s
            "#{@left.to_s} % #{@right.to_s}"
        end
    end

    class Exponentiation
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Integer.new(left_value.value ** right_value.value)
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
            if (@left.instance_of? Boolean) && (@right.instance_of? Boolean)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Boolean.new(left_value.value && right_value.value)
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
            if (@left.instance_of? Boolean) && (@right.instance_of? Boolean)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Boolean.new(left_value.value && right_value.value)
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
            if @left.instance_of? Boolean
                operand_value = @operand.evaluate(env)
                Boolean.new(!operand_value.value)
            end
        end

        def to_s
            "!#{@operand.to_s}"
        end
    end

    # Cells
    class Lvalues
        attr_reader :left, :right
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            
        end

        def to_s
            "(#{@left.to_s}, #{@right.to_s})"
        end
    end

    class Rvalues
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            environment.get_query
        end

        def to_s
            "(#{@left.to_s}, #{@right.to_s})"
        end
    end

    # Bitwise Operations
    class BAnd
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Integer) && (@right.instance_of? Integer)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Integer.new(left_value.value & right_value.value)
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
            if (@left.instance_of? Integer) && (@right.instance_of? Integer)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Integer.new(left_value.value | right_value.value)
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
            if (@left.instance_of? Integer) && (@right.instance_of? Integer)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Integer.new(left_value.value ^ right_value.value)
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
            if @operand.instance_of? Integer
                operand_value = @operand.evaluate(env)
                Integer.new(~operand_value.value)
            end
        end

        def to_s
            "~#{@operand.to_s}"
        end
    end

    class LeftShift
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Integer) && (@right.instance_of? Integer)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Integer.new(left_value.value << right_value.value)
            end
        end

        def to_s
            "#{@left.to_s} << #{@right.to_s}"
        end
    end

    class RightShift
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Integer) && (@right.instance_of? Integer)
                left_value = @left.evaluate(env)
                right_value = @right.evaluate(env)
                Integer.new(left_value.value >> right_value.value)
            end
        end

        def to_s
            "#{@left.to_s} >> #{@right.to_s}"
        end
    end

    # Relational Operations
    class Equals
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Boolean.new(left_value.value == right_value.value)
        end

        def to_s
            "#{@left.to_s} == #{@right.to_s}"
        end
    end

    class NotEquals
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Boolean.new(left_value.value != right_value.value)
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
            Boolean.new(left_value.value < right_value.value)
        end

        def to_s
            "#{@left.to_s} < #{@right.to_s}"
        end
    end

    class LessEquals
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            left_value = @left.evaluate(env)
            right_value = @right.evaluate(env)
            Boolean.new(left_value.value <= right_value.value)
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
            Boolean.new(left_value.value > right_value.value)
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
            Boolean.new(left_value.value >= right_value.value)
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
            if @operand.instance_of? Float
                operand_value = @operand.evaluate(env)
                Integer.new(operand_value.value.to_i)
            end
        end

        def to_s
            "#{@operand.to_s}"
        end
    end

    class IntToFloat
        def initialize(operand)
            @operand = operand
        end
        
        def evaluate(env)
            if @operand.instance_of? Integer
                operand_value = @operand.evaluate(env)
                Float.new(operand_value.value.to_f)
            end
        end

        def to_s
            "#{@operand.to_s}"
        end
    end

    # Statistical Functions
    class Max
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)(env)
            if (@left.instance_of? Lvalue) && (@right.instance_of? Lvalue)
                x = env.get_query(@left)
                for i in 0..@right.left
                    for j in 0..@right.right
                        y = env.get_query(Lvalue.new(@left.left + i, @left.right + j))
                        if x < y
                            x = y
                        end
                    end
                end 
                x
            end
        end

        def to_s
        end
    end

    class Min
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Lvalue) && (@right.instance_of? Lvalue)

            end
        end

        def to_s
        end
    end

    class Mean
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Lvalue) && (@right.instance_of? Lvalue)

            end
        end

        def to_s
        end
    end

    class Sum
        def initialize(left, right)
            @left = left
            @right = right
        end
        
        def evaluate(env)
            if (@left.instance_of? Lvalue) && (@right.instance_of? Lvalue)

            end
        end

        def to_s
        end
    end

    #             #
    #   Testing   #
    #             #

    # Primative
    int = Integer.new(3)
    print "Integer: #{int} evaluate(env)s To: #{int.evaluate(env)}\n"
    float = Float.new(3.1)
    print "Float: #{float} evaluate(env)s To: #{float.evaluate(env)}\n"
    bool = Boolean.new(true)
    print "Boolean: #{bool} evaluate(env)s To: #{bool.evaluate(env)}\n"
    string = String.new("Hello World")
    print "String: #{string} evaluate(env)s To: #{string.evaluate(env)}\n"

    # Aritmetic Operations
    add = Addition.new(int, int)
    print "Additon: #{add} = #{add.evaluate(env)}\n"
    sub = Subtraction.new(int, int)
    print "Subtraction: #{sub} = #{sub.evaluate(env)}\n"
    mult = Multiplication.new(int, int)
    print "Multiplication: #{mult} = #{mult.evaluate(env)}\n"
    div = Division.new(int, int)
    print "Division: #{div} = #{div.evaluate(env)}\n"
    mod = Modulo.new(int, int)
    print "Modulo: #{mod} = #{mod.evaluate(env)}\n"
    exp = Exponentiation.new(int, int)
    print "Exponentiation: #{exp} = #{exp.evaluate(env)}\n"

    # Logical Operators
    l_and = LAnd.new(bool, bool)
    print "Logical And: #{l_and} = #{l_and.evaluate(env)}\n"
    l_or = LOr.new(bool, bool)
    print "Logical And: #{l_or} = #{l_or.evaluate(env)}\n"
    l_not = LNot.new(bool)
    print "Logical And: #{l_not} = #{l_not.evaluate(env)}\n"

    # Cells
    # l_value = Lvalues.new(Integer.new(1), int)
    # print "Cell: #{l_value} Lvalue: #{l_value.evaluate(env)}\n"
    # r_value = Rvalues.new(Integer.new(1), int)
    # print "Cell: #{r_value} Rvalue: #{r_value.evaluate(env)}\n"

    # Bitwise Operators
    b_and = BAnd.new(int, int)
    print "Bitwise And: #{b_and} = #{b_and.evaluate(env)}\n"
    b_or = BOr.new(int, int)
    print "Bitwise Or: #{b_or} = #{b_or.evaluate(env)}\n"
    b_xor = BXor.new(int, int)
    print "Bitwise Xor: #{b_xor} = #{b_xor.evaluate(env)}\n"
    b_not = BNot.new(int)
    print "Bitwise Not: #{b_not} = #{b_not.evaluate(env)}\n"
    b_left_shift = RightShift.new(int, int)
    print "Bitwise Left Shift: #{b_left_shift} = #{b_left_shift.evaluate(env)}\n"
    b_right_shift = LeftShift.new(int, int)
    print "Bitwise Right Shift: #{b_right_shift} = #{b_right_shift.evaluate(env)}\n"

    # Relational Operators
    equals = Equals.new(int, int)
    print "Equals: #{equals} = #{equals.evaluate(env)}\n"
    not_equals = NotEquals.new(int, int)
    print "Not Equals: #{not_equals} = #{not_equals.evaluate(env)}\n"
    less = Less.new(int, int)
    print "Less: #{less} = #{less.evaluate(env)}\n"
    less_equals = LessEquals.new(int, int)
    print "Less Equals: #{less_equals} = #{less_equals.evaluate(env)}\n"
    greater = Greater.new(int, int)
    print "Greater: #{greater} = #{greater.evaluate(env)}\n"
    greater_equals = GreaterEqual.new(int, int)
    print "Greater Equals: #{greater_equals} = #{greater_equals.evaluate(env)}\n"

    # Casting Operators
    float_to_int = FloatToInt.new(float)
    print "Float to Int: #{float_to_int} to #{float_to_int.evaluate(env)}\n"
    float_to_int = FloatToInt.new(int)
    print "Float to Int: #{float_to_int} to #{float_to_int.evaluate(env)}\n"
    int_to_float = IntToFloat.new(int)
    print "Float to Int: #{int_to_float} to #{int_to_float.evaluate(env)}\n"

    # Statistical Functions
    max = 
    print "Max: \n"
    min =
    print "Min: \n"
    mean =
    print "Mean: \n"
    sum =
    print "Sum: \n"

    # Failure Checks
    #f_add = Addition.new(4,5)
    #print "Additon: #{f_add} = #{f_add.evaluate(env)}\n"
end