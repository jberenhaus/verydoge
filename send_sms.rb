
require 'rubygems'
require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/user/account
account_sid = 'AC4ab30cfa9feec350516e9ee23a5fc8b3'
auth_token = '785e02c8a0737101a2a146e0eaf17660'
@client = Twilio::REST::Client.new account_sid, auth_token

message = @client.account.sms.messages.create(:body => "Jenny please?! I love you <3",
    :to => "+14103005000",     # Replace with your phone number
    :from => "+16313193643")   # Replace with your Twilio number
puts message.sid

