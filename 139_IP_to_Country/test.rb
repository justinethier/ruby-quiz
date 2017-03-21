require 'IP_to_Country.rb'
=begin
anchor = Time.now
puts linear_search(convert_ip_str_to_num("213.161.77.145"))
puts Time.now - anchor

anchor = Time.now
puts binary_search(convert_ip_str_to_num("213.161.77.145"))
puts Time.now - anchor

anchor = Time.now
puts binary_seek(convert_ip_str_to_num("213.161.77.145"))
puts Time.now - anchor

#print convert_ip_str_to_num("1.2.3.4")
=end

puts binary_seek(convert_ip_str_to_num("69.147.114.210")) # Yahoo
puts binary_seek(convert_ip_str_to_num("66.35.250.150")) # slashdot
puts binary_seek(convert_ip_str_to_num("87.242.93.250")) # all of mp3
puts binary_seek(convert_ip_str_to_num("213.161.77.145")) #england.com
puts binary_seek(convert_ip_str_to_num("212.100.232.194")) # russia.com
