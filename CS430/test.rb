class UndoValue
    def initialize(value)
      @value = value
      @prev = []
    end
    
    def value
      @value
    end
    
    def value=(x)
      @prev << @value
      @value = x
    end
    
    def undo
      @value = @prev.pop
    end
  end

a = UndoValue.new(3)
puts a.value
a.value=(4)
puts a.value
a.value=(5)
puts a.value
a.undo
puts a.value
a.undo
puts a.value

