class FoodTruckPaginator
  def call(food_trucks: [])
    handle_zero_results_error if food_trucks.empty?

    sorted_food_trucks = sort_food_trucks(food_trucks)
    paginated_food_trucks = paginate_food_trucks(sorted_food_trucks)
    return paginated_food_trucks
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
end
