require 'curses'

include Curses

class Grapher
    def initialize()
        @functions = []
    end

    def render_axes(width, height)
        setps(height / 2, 0)
        (0...width).each do |x|
            setpos(0, x)
            addch('-')
        end
    end

    def reder_functions(width, height)
    end

    def render(width, height)
        render_axes(width, height)
        reder_functions(width, height)
    end
end

grapher = Grapher.new

init_screen
grapher.render(cols, lines)
getch
