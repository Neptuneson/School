require 'curses'
require_relative('grid_kid.rb')

include Curses

$size_x = 25
$size_y = 45

init_screen
start_color
noecho

env = Environment::Environment.new()

env_arr = []

for i in 0..$size_y
    for j in 0..$size_x
        cell_env = Environment::Environment.new()
        cell_env.grid = env.grid()
        env_arr.push({row: i, col:j, cell_env: cell_env})

    end
end

for i in 0..$size_y
    for j in 0..$size_x
        #Expressions::Add.new(Expressions::Int.new(i), Expressions::Int.new(i*j+1)) for testing
        env.set_query(Expressions::Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), Expressions::Add.new(Expressions::Int.new(i), Expressions::Int.new(i*j+1)))
    end
end

def draw_menu(menu, env, active_index_x=nil, active_index_y=nil)
    for i in 0..$size_y
        for j in 0..$size_x
            val = env.get_query(Expressions::Lvalue.new(Expressions::Int.new(i), Expressions::Int.new(j)), env).evaluate(env).evaluate(env)
            menu.setpos(i + 2, 11 * (j + 1))
            menu.attrset((i == active_index_x && j == active_index_y) ? A_STANDOUT : A_NORMAL)
            menu.addstr "#{val}"
        end
    end
    menu.refresh
end
  
position_x = 0
position_y = 0

main = Window.new(Curses.lines, Curses.cols, 0, 0)
grid_view = main.subwin(Curses.lines - $size_x - 4, Curses.cols, 0, 0)
cell_view = main.subwin(10, 60, 50, 0)
editor = main.subwin(10, Curses.cols - 60, 50, 60)

main.setpos(Curses.lines - $size_x + 6, 0)
main.addstr "Grid view options:"
main.setpos(Curses.lines - $size_x + 7, 0)
main.addstr "Press 'x' to exit program."
main.setpos(Curses.lines - $size_x + 8, 0)
main.addstr "Press 'e' to enter cell view mode."
main.setpos(Curses.lines - $size_x + 9, 0)
main.addstr "Press 'w' to go up a cell."
main.setpos(Curses.lines - $size_x + 10, 0)
main.addstr "Press 'a' to go left a cell."
main.setpos(Curses.lines - $size_x + 11, 0)
main.addstr "Press 's' to go down a cell."
main.setpos(Curses.lines - $size_x + 12, 0)
main.addstr "Press 'd' to go right a cell."

main.setpos(Curses.lines - $size_x + 6, 50)
main.addstr "Cell view options:"
main.setpos(Curses.lines - $size_x + 7, 50)
main.addstr "Press 'e' to enter editor mode."
main.setpos(Curses.lines - $size_x + 8, 50)
main.addstr "Press 'x' to exit cell view mode."

main.setpos(Curses.lines - $size_x + 6, 100)
main.addstr "Editor options:"
main.setpos(Curses.lines - $size_x + 7, 100)
main.addstr "Press '`' to exit editor mode and submit changes."



grid_view.box('|', '-')
cell_view.box('|', '-')
editor.box('|', '-')

main.keypad(true)
mousemask(ALL_MOUSE_EVENTS)

refresh

draw_menu(main, env, position_x, position_y)

while ch = main.getch
  case ch
    when 'w'
        position_x -= 1
    when 's'
        position_x += 1
    when 'a'
        position_y -= 1
    when 'd'
        position_y += 1
    when 'x'
        exit
    when 'e'
        value = env.get_query(Expressions::Lvalue.new(Expressions::Int.new(position_x), Expressions::Int.new(position_y)), env_arr.select{ |cell| cell[:row] == position_x && cell[:col] == position_y}[0][:cell_env])
        if !(value.instance_of? Expressions::String)
            cell_view.setpos(5,30)
            cell_view.addstr "=#{value}"
            cell_view.setpos(1,1)
            cell_view.addstr "Cell @ (#{position_y}, #{position_x})"
            editor.setpos(5,30)
            editor.addstr "=#{value}"
        else
            cell_view.setpos(5,30)
            cell_view.addstr "#{value}"
            cell_view.setpos(1,1)
            cell_view.addstr "Cell @ (#{position_y}, #{position_x})"
            editor.setpos(5,30)
            editor.addstr "#{value}"
        end
        cell_view.refresh
        editor.refresh
        while input_ch = main.getch
            case input_ch
                when 'x'
                    editor.clear
                    editor.box('|', '-')
                    editor.refresh
                    cell_view.clear
                    cell_view.box('|', '-')
                    cell_view.refresh
                    break
                when 'e'
                    editor.setpos(1,1)
                    editor.addstr "Editing..."
                    editor.refresh
                    input = ""
                    while input_ch = main.getch
                        case input_ch
                            when '`'
                                if input[0] == '='
                                    begin
                                        lexer =  Lexer::Lexer.new(input[1..-1])
                                        tokens = lexer.lex
                                        parser = Parser::Parser.new(tokens)
                                        ast = parser.expression
                                        env.set_query(Expressions::Lvalue.new(Expressions::Int.new(position_x), Expressions::Int.new(position_y)), ast)
                                        draw_menu(main, env, position_x, position_y)
                                        editor.clear
                                        editor.box('|', '-')
                                        editor.setpos(5,30)
                                        editor.addstr "#{input}"
                                        editor.refresh
                                    rescue StandardError => e
                                        editor.clear
                                        editor.box('|', '-')
                                        editor.setpos(5,30)
                                        editor.addstr "#{e.message}"
                                        editor.refresh
                                    end
                                else
                                    env.set_query(Expressions::Lvalue.new(Expressions::Int.new(position_x), Expressions::Int.new(position_y)), Expressions::String.new(input))
                                    draw_menu(main, env, position_x, position_y)
                                    editor.clear
                                    editor.box('|', '-')
                                    editor.setpos(5,30)
                                    editor.addstr "#{input}"
                                    editor.refresh
                                end
                                break
                            else
                                editor.clear
                                editor.box('|', '-')
                                input << input_ch
                                editor.setpos(5,30)
                                editor.addstr "#{input}"
                                editor.refresh
                                editor.setpos(1,1)
                                editor.addstr "Editing..."
                                editor.refresh
                        end
                    end
            end
        end
  end

  position_x = $size_y if position_x < 0
  position_x = 0 if position_x > $size_y
  position_y = $size_x if position_y < 0
  position_y = 0 if position_y > $size_x
  draw_menu(main, env, position_x, position_y)
end