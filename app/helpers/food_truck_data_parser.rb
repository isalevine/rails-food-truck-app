require 'json'

class FoodTruckDataParser
  def call(api_response: "")
    begin
      food_truck_data = JSON.parse(api_response)
      food_trucks = format_food_trucks(food_truck_data)
      return food_trucks

    rescue JSON::ParserError
      handle_json_parser_error(api_response)
    end
  end


  private

  def format_food_trucks(food_truck_data)
    food_truck_data.map do |food_truck|
      formatted_food_truck = {
        name: set_food_truck_name(food_truck),
        address: set_food_truck_address(food_truck)
      }
    end
  end

  def set_food_truck_name(food_truck)
    if !food_truck["applicant"] || food_truck["applicant"].strip == ""
      return "NO NAME PROVIDED"
    else
      return format_text(food_truck["applicant"])
    end
  end

  def set_food_truck_address(food_truck)
    if !food_truck["location"] || food_truck["location"].strip == ""
      return "NO ADDRESS PROVIDED"
    else
      return format_text(food_truck["location"])
    end
  end

  def format_text(text)
    text.split(" ")
        .map{|word| word.capitalize}
        .join(" ")
  end

  def handle_json_parser_error(api_response)
    ErrorHandler.call(
      error_text: "Error in FoodTruckJSONParser: Error parsing API response as JSON. Here is the raw response passed to `JSON.parse`: #{api_response}",
      error_occurred: true
    )
  end
end
