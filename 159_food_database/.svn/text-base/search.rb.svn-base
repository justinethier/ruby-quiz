require 'rubygems'
require 'text'
include Text::Levenshtein

class FoodDatabase
  
  def load(filename)
    @db = []
    
    fp = File.new(filename, "r")
    for line in fp.readlines
      @db << line.split("^")
      
      # TODO: Strip "~" chars from string input
    end
    fp.close
  end
  
  # TODO: use weight field (see doc for conversion info)
  def nutrient_report(food, weight=100)
    return if @db == nil
    
    min_dist = nil
    matching_item = nil
    
    food_terms = food.split(" ")
    
    # Generate list of candidate items, using 
    # an exact text match to narrow the search
    candidates = []
    for item in @db
      for term in food_terms
        if item[1].upcase.include?(term.upcase)
          candidates << item 
          break
        end
      end
    end
    
    # Attempt to find the closest match from the list of candidates
    for item in candidates
      #dist = distance(item[1].upcase, food.upcase)
      dist = food_terms.inject(0){|sum, t| sum + distance(item[1].upcase, t.upcase)}

      if min_dist == nil or dist < min_dist
        matching_item = item 
        min_dist = dist
      end
    end
    
    print_item(matching_item, weight) if matching_item != nil
  end
  
  # Convert a nutrient value from 100g-based to value based on given weight,
  # per N = (V * W) / 100 equation on page 19 of the PDF documentation
  def convert_by_weight(val, weight)
    return (val.to_f * weight) / 100.0
  end
  
  def print_item(item, weight)
    puts "         Food: " + item[1]
    puts "       Weight: " + weight.to_s
    puts "        Water: " + convert_by_weight(item[2], weight).to_s
    puts "      Protein: " + convert_by_weight(item[4], weight).to_s
    puts "Carbohydrates: " + convert_by_weight(item[7], weight).to_s
    puts "         Fats: " + (convert_by_weight(item[42], weight) +
                              convert_by_weight(item[43], weight) +
                              convert_by_weight(item[44], weight)).to_s
  end
end

db = FoodDatabase.new
db.load("ABBREV.txt")

if ARGV.size > 1
  db.nutrient_report(ARGV[0], ARGV[1].to_i)
else
  db.nutrient_report(ARGV[0])
end