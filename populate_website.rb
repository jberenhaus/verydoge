input = ""
flag = 1
count = 20
countup = 0
align = "left"
header = "<meta http-equiv=\"Pragma\" content=\"no-cache\">
<h1>Text (613) 706-DOGE(3643) (CA) or (631) 319-DOGE(3643) (US)</h1>\n
<h6>Dogecoin address = DFC1C4cBF1HLWpuFzvvTvRuzafyH8TVRCN"
divleft = "<div class='l'>"
divright = "<div class='r'>"
input = "<link href='style.css' rel='stylesheet' type='text/css' />"
#input = "#{input}<h1>Very doge</h1>"
File.open('./web_log', 'r').each_line { |readline|	
	File.foreach('counter') do |i|
		if count > 0 
			if flag == 1 #if it is the first time, it should match From
				input = "#{header}#{divright}<pre>#{input}#{countup+1})<br/>#{readline}"
				flag = 0
	    elsif /From:.+$/.match(readline) #if it matches "From:"
				count = count-1
				input = "#{input}</pre></div>#{divright}<pre>#{countup+1})<br/>#{readline}"
				
			elsif /To:.+$/.match(readline) #if it matches "To:"
				count = count-1
				input = "#{input}</pre></div>#{divleft}<pre>#{countup+1})<br/><img src=\"dogepics/doge#{i.chomp.to_i-countup-1}.jpg\"><br/><a href='dogepics/doge#{i.chomp.to_i-countup-1}.jpg'>Download Link</a>\n"
				countup = countup + 1
			else
				input = "#{input}#{readline}"
			end
		elsif (!/From:.+$/.match(readline) && !/To:.+$/.match(readline))
			#input = "#{input}</pre>"
			break
		else
			break	
		end
	end
}
input = "#{input}</pre></div>#{divleft}Made by <a href='https://twitter.com/JBerenhaus'>@JBerenhaus</a>, <a href='https://twitter.com/j__eng'>@j__eng</a>, and <a href='https://twitter.com/wattstopher'>@wattstopher</a> at <a href='http://www.mchacks.io'>McHacks 2014</a></div>"
File.open('/var/www/index.html','w'){ |writeFile|
	writeFile.write("#{input}")
}
