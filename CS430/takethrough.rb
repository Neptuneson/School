def take_through(arr)
    result = []
    arr.each do |x|
        result << x
        break if yield(x)
    end
    result
end

p take_through([10, 9, 8, 7, 5]) { |x| x == 8 }
# [10, 9, 8]

p take_through(('a'..'z').to_a) { |c| "dog".include?(c) }
# ['a', 'b', 'c', 'd']

sum = 0
p take_through((1..50).to_a) { |x|
  sum += x
  sum > 10
}
# [1, 2, 3, 4, 5]

p take_through(('a'..'z').to_a) { |c| "cat".include?(c) }
# ['a', 'b', 'c', 'd']