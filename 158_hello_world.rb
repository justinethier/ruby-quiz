def encode(str)
 #idx = 0
 #sum = str.inject(0){|sum, i|
  #sum += i[0] * (128 ** idx)
  #idx += 1
 #}
 
 sum = 0
 for i in 0...str.size
  sum *= 256
  sum += str[i]
  #puts str[i]
end
 sum
end

def decode(key)
  #len.times{|i| 
  #  cur = key % 256
  # key /= 256
  # puts cur
  #}
  result = ""
  while (key > 0)
    result << (key % 256)
    key /= 256
  end
  result.reverse
  #puts (1..12).inject([]){|result, i| 
  # result << (key % 256)
  #key /= 256 
  #}
end

#puts (encode("Hello, World!".reverse))
#puts decode(72620544259784832,12)

hello, world = "", 2645608968345021733469237830984
(hello << (world % 256); world /= 256) until world == 0
puts hello


