require 'rubygems'
require 'v8'
require 'doge'

def translate(input)
  cxt = V8::Context.new
  cxt.load("parser_js/lexer.js")
  cxt.load("parser_js/POSTagger.js")
  cxt.load("parser_js/lexicon.js_")
  cxt.load("parser_js/shibe.js")
  cxt['input'] = input
#  cxt['lex'] = cxt.eval('lexWords(in)')
#  cxt['sortLex'] = ctx.eval('sortWords(lex)')
#  cxt['phrases'] = ctx.eval('getPhrases()')
#  text = cxt.eval('createShibe(shortLex, phrases)')
  text = cxt.eval('createShibe(sortWords(lexWords(input)), getPhrases())')
  puts text
  lines = text.split("\n")
	File.foreach('counter') do |i|
		Doge.new do
		  lines.each { |x |
		  	wuff(x.chomp)
		  }
		end.image.write("/var/www/dogepics/doge#{i.chomp}.jpg")
	end
	File.open 'counter', 'r+' do |file|
		num = file.gets.to_i
		file.rewind
		file.puts num.next
	end
  return text
end
