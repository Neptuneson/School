require_relative('html.rb')

# Tests
print Html.make_tag('Gallery', {}, :selfclose)
print "\n"
print Html.make_tag("img", {src: "bernie.jpg"}, :empty)
print "\n"
print Html.make_tag('div', {id: 'root', class: 'frame'}, :sandwich)
print "\n"
print Html.make_tag('div', {id: 'root', class: 'frame', time: 20, ip: 23045672}, :selfclose)
print "\n"
print Html.make_tag('html', {id: 'root', class: 'frame', time: 20, ip: 23045672}, :sandwich)
print "\n"

# Failure if not vaild symbol
# print Html.make_tag('div', {id: 'root', class: 'frame'}, :sand)