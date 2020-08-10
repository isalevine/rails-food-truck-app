require 'colorize'

class FoodTruckConsoleOutput
  def call(food_trucks: [])
    handle_zero_results_error if food_trucks.empty?

    sorted_food_trucks = sort_food_trucks(food_trucks)
    paginated_food_trucks = paginate_food_trucks(sorted_food_trucks)
    print_paginated_output(paginated_food_trucks)
  end


  private 

  def handle_zero_results_error
    ErrorHandler.call(
      error_text: "Error in FoodTruckConsoleOutput: No open food trucks were found using the current time. Please try again later!",
      error_occurred: false
    )
  end

  def sort_food_trucks(food_trucks)
    food_trucks.sort_by {|food_truck| food_truck[:name]}
  end

  def paginate_food_trucks(food_trucks)
    paginated_food_trucks = []
    food_trucks.each_slice(10) {|trucks| paginated_food_trucks << trucks}
    return paginated_food_trucks
  end

  def print_paginated_output(paginated_food_trucks)
    paginated_food_trucks.each_with_index do |food_trucks, index|
      output = "NAME".colorize(:blue) + " ADDRESS".colorize(:magenta)

      food_trucks.each do |food_truck|
        output += " #{food_truck[:name]}".colorize(:blue) 
        output += " #{food_truck[:address]}".colorize(:magenta)
      end

      puts output
  
      if more_pages_to_display?(paginated_food_trucks, index)
        print "Press enter to display the next #{paginated_food_trucks[index + 1].length} food trucks"
        gets
      end
    end
  end

  def more_pages_to_display?(paginated_food_trucks, index)
    index < paginated_food_trucks.length - 1
  end
end
