input = ""
flag = 1
count = 10
align = "left"
divleft = "<div style=\"text-align:left\">"
divright = "<div style=\"text-align:right\">"
File.open('/root/sample_log', 'r').each_line { |readline|	
	if count > 0 
		if flag == 1 #if it is the first time, it should match From
			input = "#{divright}<pre>#{input}#{readline}"
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
	end
}
input = "#{input}</pre>"
File.open('/var/www/index.html','w'){ |writeFile|
	writeFile.write("#{input}")
}
