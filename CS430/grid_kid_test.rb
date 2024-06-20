require_relative('grid_kid.rb')


#             #
#   Testing   #
#             #

env = Environment::Environment.new()

grid = Grid::Grid.new()

# Populate grid
val = 0
for i in 0..10
    for j in 0..10
        if (i == 1 && j == 1) 
            env.set_query(Expressions::Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), Expressions::Int.new(-1))
        elsif(i == 2 && j == 3)
            env.set_query(Expressions::Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), Expressions::Int.new(3000))
        else
            env.set_query(Expressions::Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), Expressions::Add.new(Expressions::Int.new(val), Expressions::Int.new(val)))
            val +=1
        end
    end
end

# Grid assginment
print("Grid Assignment\n")
print("(0, 0) = ")
puts env.get_query(Expressions::Lvalue.new(Expressions::Int.new(0), Expressions::Int.new(0)), env).evaluate(env)
print("\n")

# Variables
print("Variables\n")
assignment = Expressions::Assignment.new(Expressions::String.new("proportion"), Expressions::Add.new(Expressions::Int.new(3), Expressions::Int.new(5)))
print("#{assignment.evaluate(env)}\n")
ref = Expressions::Reference.new(Expressions::String.new("proportion"))
print("proportion evaluates to #{ref.evaluate(env)}\n")
print("\n")

# Block
print("Block\n")
block = Expressions::Block.new([Expressions::Assignment.new(Expressions::String.new("proportion"), Expressions::Add.new(Expressions::Int.new(3), Expressions::Int.new(5))), Expressions::Assignment.new(Expressions::String.new("rate"), Expressions::Sub.new(Expressions::Int.new(39), Expressions::Int.new(9))), Expressions::Mult.new(Expressions::Reference.new(Expressions::String.new("proportion")), Expressions::Reference.new(Expressions::String.new("rate")))])
print("#{block}")
print("#{block.evaluate(env)}\n")
print("\n")

# If
print("If\n")
if_block = Expressions::Block.new([Expressions::Int.new(1)])
else_block = Expressions::Block.new([Expressions::Int.new(0)])
cond_true = Expressions::Conditional.new(Expressions::Less.new(Expressions::Int.new(3), Expressions::Int.new(4)), if_block, else_block)
print("#{cond_true}\n")
print("#{cond_true.evaluate(env)}\n")
if_block = Expressions::Block.new([Expressions::Int.new(1)])
else_block = Expressions::Block.new([Expressions::Int.new(0)])
cond_false = Expressions::Conditional.new(Expressions::Less.new(Expressions::Int.new(4), Expressions::Int.new(3)), if_block, else_block)
print("#{cond_false}\n")
print("#{cond_false.evaluate(env)}\n")
print("\n")

# For Each
print("For Each\n")
init = Expressions::Assignment.new(Expressions::String.new("count"), Expressions::Int.new(0))
print("#{init}\n")
init.evaluate(env)
var = Expressions::String.new("value")
start_address = Expressions::Lvalue.new(Expressions::Int.new(4), Expressions::Int.new(0))
end_address = Expressions::Lvalue.new(Expressions::Int.new(4), Expressions::Int.new(3))
if_block = Expressions::Block.new([Expressions::Assignment.new(Expressions::String.new("count"), Expressions::Add.new(Expressions::Reference.new(Expressions::String.new("count")), Expressions::Int.new(1)))])
block = Expressions::Block.new([Expressions::Conditional.new(Expressions::Greater.new(Expressions::Reference.new(Expressions::String.new("value")), Expressions::Float.new(0.0)), if_block, Expressions::Block.new([Expressions::Int.new(0)]))])
for_each = Expressions::ForEach.new(var, start_address, end_address, block)
print("#{for_each}\n")
print("#{for_each.evaluate(env)}\n")
count = Expressions::Reference.new(Expressions::String.new("count"))
print("#{count.evaluate(env)}")
print("\n")

# Primative
print("Primative\n")
int = Expressions::Int.new(3)
print "Int: #{int} evaluates To: #{int.evaluate(env)}\n"
float = Expressions::Float.new(3.1)
print "Float: #{float} evaluates To: #{float.evaluate(env)}\n"
bool = Expressions::Bool.new(true)
print "Bool: #{bool} evaluates To: #{bool.evaluate(env)}\n"
string = Expressions::String.new("Hello World")
print "String: #{string} evaluates To: #{string.evaluate(env)}\n"
print("\n")


# Aritmetic Operations
print("Arithmetic Operations\n")
print("Addition\n")
add = Expressions::Add.new(int, int)
print "Int-Int Additon: #{add} = #{add.evaluate(env)}\n"
add = Expressions::Add.new(int, float)
print "Int-Float Additon: #{add} = #{add.evaluate(env)}\n"
add = Expressions::Add.new(float, int)
print "Float-Int Additon: #{add} = #{add.evaluate(env)}\n"
add = Expressions::Add.new(float, float)
print "Float-Float Additon: #{add} = #{add.evaluate(env)}\n"

print("Subtraction\n")
sub = Expressions::Sub.new(int, int)
print "Int-Int Subtraction: #{sub} = #{sub.evaluate(env)}\n"
sub = Expressions::Sub.new(int, float)
print "Int-Float Subtraction: #{sub} = #{sub.evaluate(env)}\n"
sub = Expressions::Sub.new(float, int)
print "Float-Int Subtraction: #{sub} = #{sub.evaluate(env)}\n"
sub = Expressions::Sub.new(float, float)
print "Float-Float Subtraction: #{sub} = #{sub.evaluate(env)}\n"

print("Multiplicaton\n")
mult = Expressions::Mult.new(int, int)
print "Int-Int Multiplication: #{mult} = #{mult.evaluate(env)}\n"
mult = Expressions::Mult.new(int, float)
print "Int-Float Multiplication: #{mult} = #{mult.evaluate(env)}\n"
mult = Expressions::Mult.new(float, int)
print "Float-Int Multiplication: #{mult} = #{mult.evaluate(env)}\n"
mult = Expressions::Mult.new(float, float)
print "Float-Float Multiplication: #{mult} = #{mult.evaluate(env)}\n"

print("Division\n")
div = Expressions::Div.new(int, int)
print "Int-Int Division: #{div} = #{div.evaluate(env)}\n"
div = Expressions::Div.new(int, float)
print "Int-Float Division: #{div} = #{div.evaluate(env)}\n"
div = Expressions::Div.new(float, int)
print "Float-Int Division: #{div} = #{div.evaluate(env)}\n"
div = Expressions::Div.new(float, float)
print "Float-Float Division: #{div} = #{div.evaluate(env)}\n"

print("Modulo\n")
mod = Expressions::Mod.new(int, int)
print "Int-Int Modulo: #{mod} = #{mod.evaluate(env)}\n"
mod = Expressions::Mod.new(int, float)
print "Int-Float Modulo: #{mod} = #{mod.evaluate(env)}\n"
mod = Expressions::Mod.new(float, int)
print "Float-Int Modulo: #{mod} = #{mod.evaluate(env)}\n"
mod = Expressions::Mod.new(float, float)
print "Float-FloatModulo: #{mod} = #{mod.evaluate(env)}\n"

print("Exponentiation\n")
exp = Expressions::Exp.new(int, int)
print "Int-Int Exponentiation: #{exp} = #{exp.evaluate(env)}\n"
exp = Expressions::Exp.new(int, float)
print "Int-Float Exponentiation: #{exp} = #{exp.evaluate(env)}\n"
exp = Expressions::Exp.new(float, int)
print "Float-Int Exponentiation: #{exp} = #{exp.evaluate(env)}\n"
exp = Expressions::Exp.new(float, float)
print "Float-Float Exponentiation: #{exp} = #{exp.evaluate(env)}\n"
print("\n")


# Logical Operators
print("Logical Operators\n")
l_and = Expressions::LAnd.new(bool, bool)
print "Logical And: #{l_and} = #{l_and.evaluate(env)}\n"
l_or = Expressions::LOr.new(bool, bool)
print "Logical Or: #{l_or} = #{l_or.evaluate(env)}\n"
l_not = Expressions::LNot.new(bool)
print "Logical Not: #{l_not} = #{l_not.evaluate(env)}\n"
print("\n")

# Cells
print("Cells\n")
l_value = Expressions::Lvalue.new(Expressions::Int.new(3), Expressions::Int.new(4))
print "Cell: #{l_value} Lvalue: #{l_value.evaluate(env)}\n"
r_value = Expressions::Rvalue.new(Expressions::Int.new(1), Expressions::Int.new(2))
print "Cell: #{r_value} Rvalue: #{r_value.evaluate(env)}\n"
print("\n")

# Bitwise Operators
print("Bitwise Operators\n")
b_and = Expressions::BAnd.new(int, int)
print "Bitwise And: #{b_and} = #{b_and.evaluate(env)}\n"
b_or = Expressions::BOr.new(int, int)
print "Bitwise Or: #{b_or} = #{b_or.evaluate(env)}\n"
b_xor = Expressions::BXor.new(int, int)
print "Bitwise Xor: #{b_xor} = #{b_xor.evaluate(env)}\n"
b_not = Expressions::BNot.new(int)
print "Bitwise Not: #{b_not} = #{b_not.evaluate(env)}\n"
b_left_shift = Expressions::RShift.new(int, int)
print "Bitwise Left Shift: #{b_left_shift} = #{b_left_shift.evaluate(env)}\n"
b_right_shift = Expressions::LShift.new(int, int)
print "Bitwise Right Shift: #{b_right_shift} = #{b_right_shift.evaluate(env)}\n"
print("\n")

# Relational Operators
print("Relational Operators\n")
equal = Expressions::Equal.new(int, int)
print "Equal: #{equal} = #{equal.evaluate(env)}\n"
not_equal = Expressions::NotEqual.new(int, int)
print "Not Equal: #{not_equal} = #{not_equal.evaluate(env)}\n"
less = Expressions::Less.new(int, int)
print "Less: #{less} = #{less.evaluate(env)}\n"
less_equal = Expressions::LessEqual.new(int, int)
print "Less Equals: #{less_equal} = #{less_equal.evaluate(env)}\n"
greater = Expressions::Greater.new(int, int)
print "Greater: #{greater} = #{greater.evaluate(env)}\n"
greater_equal = Expressions::GreaterEqual.new(int, int)
print "Greater Equals: #{greater_equal} = #{greater_equal.evaluate(env)}\n"
print("\n")

# Casting Operators
print("Casting Operators\n")
float_to_int = Expressions::FloatToInt.new(float)
print "Float to Int: #{float_to_int} to #{float_to_int.evaluate(env)}\n"
int_to_float = Expressions::IntToFloat.new(int)
print "Float to Int: #{int_to_float} to #{int_to_float.evaluate(env)}\n"
print("\n")

# Statistical Functions
print("Statistical Functions\n")
max = Expressions::Max.new(Expressions::Lvalue.new(Expressions::Int.new(0), Expressions::Int.new(0)), Expressions::Lvalue.new(Expressions::Int.new(10), Expressions::Int.new(10)))
print "Max: #{max.evaluate(env)}\n"
min = Expressions::Min.new(Expressions::Lvalue.new(Expressions::Int.new(0), Expressions::Int.new(0)), Expressions::Lvalue.new(Expressions::Int.new(10), Expressions::Int.new(10)))
print "Min: #{min.evaluate(env)}\n"
mean = Expressions::Mean.new(Expressions::Lvalue.new(Expressions::Int.new(0), Expressions::Int.new(0)), Expressions::Lvalue.new(Expressions::Int.new(10), Expressions::Int.new(10)))
print "Mean: #{mean.evaluate(env)}\n"
sum = Expressions::Sum.new(Expressions::Lvalue.new(Expressions::Int.new(0), Expressions::Int.new(0)), Expressions::Lvalue.new(Expressions::Int.new(10), Expressions::Int.new(10)))
print "Sum: #{sum.evaluate(env)}\n"
print("\n")

# Failure Checks
#f_add = Expressions::Add.new(4,5)
#print "Additon: #{f_add} = #{f_add.evaluate(env)}\n"

#float_to_int = Expressions::FloatToInt.new(int)
#print "Float to Int: #{float_to_int} to #{float_to_int.evaluate(env)}\n"

#f_max = Expressions::Max.new(Expressions::Lvalue.new(0, 0), Expressions::Lvalue.new(20, 20))
#print "Max: #{f_max.evaluate(env)}\n"

# Check that lexer works on tokens
print("Lexer\n")
lexer = Lexer::Lexer.new('tru567.87><=+-*/%**maxminmeansum&&||!&|^~<<>>=!=<>=truefalse2345hello()intfloat=$if#for=else\\%{}end')
tokens = lexer.lex
puts tokens
print("\n")

# Not Legal checks that all tokens are taken
print("Lexer Formatted\n")
lexer =  Lexer::Lexer.new('!5 + time - 7 == 8*3+3-5-4/4+4+5*7**3*8%5*2<<6>>7==6<=4>=5<5>5!=6&&7||8&7|9^7+int(5.6+7)+float(5-7)+!5+~true+@(5,6)+$(5,6)+max($(5,7),$(7,8))')
tokens = lexer.lex
puts tokens
print("\n")

# Not Legal evaluation but check tokens work
print("Parser Formatted\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
puts ast
print("\n")

# Fail evaluation
#ast.evaluate(env) #enable for fail test

# Not Legal checks that all tokens are taken
lexer =  Lexer::Lexer.new('min(3,4')
tokens = lexer.lex
parser = Parser::Parser.new(tokens)
#ast = parser.expression #comment out here
print("\n")

print("Legal Lexer Ints Only\n")
lexer =  Lexer::Lexer.new('7 * 5 + 7 >> 7 << 5 / 2 ** 2 - 7 + ~1 % 5 & 8 | 9 - int(5.1)')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Ints Only\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Bools Only\n")
lexer =  Lexer::Lexer.new('true && !false || true')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Bools Only\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Floats\n")
lexer =  Lexer::Lexer.new('5.4 + 6.7 - float(3)')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Floats\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Relational\n")
lexer =  Lexer::Lexer.new('5 == 7')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Relational\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Rvalue\n")
lexer =  Lexer::Lexer.new('@(1, 2)')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Rvalue\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Lvalue\n")
lexer =  Lexer::Lexer.new('$(1, 2)')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal Lvalue\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Legal Lexer Change of order\n")
lexer =  Lexer::Lexer.new('7 * (5 + 6) == 77')
tokens = lexer.lex
puts tokens
print("\n")

print("Parser Legal change of order\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Cells\n")
lexer = Lexer::Lexer.new('max($(0,0),$(3,3))')
tokens = lexer.lex
puts tokens
print("\n")

print("Cells\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("Var\n")
lexer = Lexer::Lexer.new('{%proportion = @(2, 4) + 1 %amount = sum($(5, 8), $(9, 8)) #proportion * #amount}')
tokens = lexer.lex
puts tokens
print("\n")

print("Var\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("If\n")
lexer = Lexer::Lexer.new('if (@(2, 1) > @(2, 0)){1}else{0}end')
tokens = lexer.lex
puts tokens
print("\n")

print("If\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")

print("For\n")
lexer = Lexer::Lexer.new('{%count = 0 for value in $(4, 0)..$(4, 3){if (#value > 0.0) {%count = #count + 1}else{0}end} end}')
tokens = lexer.lex
puts tokens
print("\n")

print("For\n")
parser = Parser::Parser.new(tokens)
ast = parser.expression
print("#{ast} evaluates to #{ast.evaluate(env)}\n")
print("\n")
