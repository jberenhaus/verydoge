require 'v8'
gem "therubyracer"

def test()
	cxt = V8::Context.new
  cxt.eval(file, "parser_js/lexer.js")
  cxt.eval(createShibe(sortWords(lexWords()), getPhrases()))
end


def translate(input)
    return input+"!"
end

#test test test
