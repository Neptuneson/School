def each_pair(items)
    i = 0
    while i <= items.length - 2
        yield(items[i], items[i + 1])
        i += 1
    end
end

xs = [3, 7, 15, 8, 0, 0, 2]
each_pair(xs) do |a, b|
    puts a, b
end

vs = [100, 99.2, 99]

xs = vs.map {|v| v / 2}

puts xs