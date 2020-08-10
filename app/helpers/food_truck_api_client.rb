# require 'net/http'

class FoodTruckApiClient
  def call(time: Time.now)
    url = URI.parse(create_query_url(time))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    if res.code == "200"
      return res.body
    else
      handle_http_error(res)
    end
  end


  private

  def create_query_url(time)
    weekday = time.strftime('%A')
    hour = time.strftime('%H:00')

    api_url = "http://data.sfgov.org/resource/bbb8-hzi6.json"
    query = "?$where=dayofweekstr = '#{weekday}' AND start24 <= '#{hour}' AND end24 > '#{hour}'"

    return api_url + query
  end

  def handle_http_error(res)
    if res.code == "202"  # retry
      self.call
    else
      error = JSON.parse(res.body)["message"]
      ErrorHandler.call(
        error_text: "Error in FoodTruckAPIClient: Call to API failed, returning the HTTP status code #{res.code} and the following error message: #{error}",
        error_occurred: true
      )
    end
  end
end
