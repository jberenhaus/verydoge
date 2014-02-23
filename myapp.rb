require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'translate.rb'
require '../account_info'

include AccountInfo
translated = ""
set :bind, '0.0.0.0' 
set :port, '8080'
get '/' do
  message = params[:Body]
  senderState = params[:FromState]
  sender = params[:From] 
  myNumber = params[:To]
  sCountry = params[:FromCountry] #Sender Country
  #begin stackoverflow code
  original_file = './web_log'
  new_file = original_file + '.new'
  if !File.exist?(original_file)
    File.open(original_file, 'w')
  end
  File.open(new_file, 'w') do |fo|
    currTime = `date`
    fo.puts "From: #{senderState}\n"
    fo.puts "Time: #{currTime}"
    fo.puts "Message: #{message}\n"
    currTime = `date`
    fo.puts "\nTo: #{senderState}\n"
    fo.puts "Time: #{currTime}"
    translated = translate(message)
    fo.puts "Message: #{translated}"
    File.foreach(original_file) do |li|
	fo.puts li
    end

    File.rename(original_file, (original_file + '.old'))
    File.rename(new_file, original_file)

    if sCountry == "CA"
	File.foreach('counter') do |i|
    		@client = Twilio::REST::Client.new AccountInfo::SID, AccountInfo::TOKEN
		puts "http://verydoge.org/dogepics/doge#{(i.chomp.to_i)-1}.jpg"
		message = @client.account.messages.create(:body => "",
        		:to => sender,
			:from => myNumber,
			:media_url => "http://verydoge.org/dogepics/doge#{(i.chomp.to_i)-1}.jpg")
		puts message.to 
	end
    else
    	twiml = Twilio::TwiML::Response.new do |r|
    		r.Message translated
    	end
    twiml.text
    end
  end
end
