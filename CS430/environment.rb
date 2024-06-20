require_relative 'grid'

module Environment
    class Environment
        def initialize
            @grid = grid::Grid.new()
        end

        def set_query(lvalue, expression)
            @grid.set(lvalue, expression)
        end

        def get_query(lvalue)
            @grid.get(lvalue)
        end
    end
end