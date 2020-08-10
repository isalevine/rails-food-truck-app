class IndexController < ApplicationController
  def main
    paginated_food_trucks ||= get_food_trucks
    @current_page = params[:page].to_i || 0     # handle receiving params[:page] that is higher than paginated_food_trucks.length - 1

    if @current_page < paginated_food_trucks.length - 1
      @next_trucks_length = paginated_food_trucks[@current_page + 1].length
    else
      @next_trucks_length = 0
    end

    @current_food_trucks = paginated_food_trucks[@current_page]
  end


  private

  def get_food_trucks
    minutes = 60 - Time.now.min
    api_response = Rails.cache.fetch("api_response", expires_in: minutes.minutes) do
      ::FoodTruckApiClient.new.call(time: Time.now)
    end

    food_trucks = ::FoodTruckDataParser.new.call(api_response: api_response)
    paginated_food_trucks = ::FoodTruckPaginator.new.call(food_trucks: food_trucks)
    return paginated_food_trucks
  end
end
