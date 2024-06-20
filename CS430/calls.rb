teams = [["Fern", "Wilbur", "Templeton"], ["Milo", "Addie", "Doc"]]
first = teams.map { |team| team[0] }
p first

files = ["lab1", "lab3"]
all_exist = files.inject(true) do |acc, file|
    acc && File.exist?(file)
end
p all_exist


tokens = ["hi", "goodbye", "snakes"]
first_last = tokens.filter {|token| token[0] == token[token.length - 1]}
p first_last

message = "Hello World"
ascii = message.chars.map {|c| c.ord}
p ascii

entries = ["", nil, ""]
true_nil = entries.inject(false) do |acc, s|
    acc || s.nil?
end
p true_nil

asciis = [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100]
str = asciis.inject("") {|str, x| str + x.chr}
p str

xs = [5, -7, 0]
ps = xs.map do |x|
    if x > 0
        '+'
    elsif x < 0
        '-'
    else
        '0'
    end
end
p ps

names = ["Robert", "Phil", "Mark"]
burglers = ["Robert", "Phil"]
nb = names.filter {|x| !burglers.include? x}
p nb