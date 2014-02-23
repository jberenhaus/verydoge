require 'rubygems'
require 'therubyracer'
require 'v8'

ctx = V8::Context.new

ctx.load("./parser_js/lexer.js")
ctx.load("./parser_js/POSTagger.js")
ctx.load("./parser_js/lexicon.js")
ctx.load("./parser_js/shibe.js")
ctx.eval('lexWords("test");')
