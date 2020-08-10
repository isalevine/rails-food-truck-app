class IndexController < ApplicationController
  def main
    minutes = 60 - Time.now.min
    api_response = Rails.cache.fetch("api_response", expires_in: minutes.minutes) do
      ::FoodTruckApiClient.new.call(time: Time.now)
    end

    food_trucks = ::FoodTruckDataParser.new.call(api_response: api_response)
    @paginated_food_trucks = ::FoodTruckPaginator.new.call(food_trucks: food_trucks)
  end
end