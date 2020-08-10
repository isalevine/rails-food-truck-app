class IndexController < ApplicationController
  def main
    api_response = FoodTruckAPIClient.new.call(time: Time.now)
    food_trucks = FoodTruckDataParser.new.call(api_response: api_response)
    FoodTruckConsoleOutput.new.call(food_trucks: food_trucks)
  end
end