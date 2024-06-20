module Html
    def self.make_tag(element, attributes, symbol)
        tag = ""
        tag << "<#{element}"
        attributes.each do |key, value|
            tag << " #{key}=\"#{value}\""
        end
        if symbol == :empty
            tag << ">"
        elsif symbol == :sandwich
            tag << "></#{element}>"
        elsif symbol == :selfclose
            tag << " \\>"
        else
            raise Exception
        end
        tag
    end
end