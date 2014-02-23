require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'translate_old.rb'

translated = ""
set :bind, '0.0.0.0' 
set :port, '8080'
get '/' do
  message = params[:Body]
  sender = params[:FromState]
  #begin stackoverflow code
  original_file = './web_log'
  new_file = original_file + '.new'
  if !File.exist?(original_file)
    File.open(original_file, 'w')
  end
  File.open(new_file, 'w') do |fo|
    fo.puts "From: #{sender}\n"
    fo.puts "Message: #{message}\n"
    fo.puts "\nTo: #{sender}\n"
    translated = translate(message)
    fo.puts "Message: #{translated}"
    File.foreach(original_file) do |li|
      fo.puts li
    end
  end
  File.rename(original_file, (original_file + '.old'))
  File.rename(new_file, original_file)

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message translated
  end
  twiml.text
end
