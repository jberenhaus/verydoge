input = ""
flag = 1
count = 20
align = "left"
header = "<h1>Text 6137063643 (CA) or 6313193643 (US)</h1>"
divleft = "<div class='l' style=\"text-align:left\">"
divright = "<div class='r' style=\"text-align:right\">"
input = "<link href='style.css' rel='stylesheet' type='text/css' />"
#input = "#{input}<h1>Very doge</h1>"
File.open('./web_log', 'r').each_line { |readline|	
	if count > 0 
		if flag == 1 #if it is the first time, it should match From
			input = "#{header}#{divright}<pre>#{input}#{readline}"
			flag = 0
	        elsif /From:.+$/.match(readline) #if it matches "From:"
			count = count-1
			input = "#{input}</pre></div>#{divright}<pre>#{readline}"
		elsif /To:.+$/.match(readline) #if it matches "To:"
			count = count-1
			input = "#{input}</pre></div>#{divleft}<pre>#{readline}"
		else
			input = "#{input}#{readline}"
		end
	elsif (!/From:.+$/.match(readline) && !/To:.+$/.match(readline))
		input = "#{input}#{readline}"
	else
		break	
	end
}
input = "#{input}</pre>"
File.open('/var/www/index.html','w'){ |writeFile|
	writeFile.write("#{input}")
}
