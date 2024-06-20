module Grid
    class GridKid
        def initialize
            @grid = []
        end

        def set(lvalue, expression)
            @grid.push({row: lvalue.left, col:lvalue.right, value: expression})
        end

        def get(lvalue)
            result = @grid.select{ |cell| cell.row == lvalue.left && cell.col == lvalue.right}
            result.value.evaluate(env)
        end
    end

    #             #
    #   Testing   #
    #             #

    grid = GridKid.new()
    
    grid.set(Expressions::Lvalue.new(1, 2), Expressions::Addition.new(Expressions::Int.new(3),Expressions::Int.new(4)))
end