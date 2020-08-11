class FoodTruckApiClient
  def call(time: Time.now)
    handle_time_error(time) if !validate_time(time)

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

  def validate_time(time)
    return true if time.is_a?(DateTime)
    return false
  end

  def handle_time_error(time)
    raise "Error in FoodTruckApiClient: Parsing time argument for search query failed, time argument was: #{time}"
  end

  # TODO: How can I mock a failed API call to test this error handling with RSpec?
  def handle_http_error(res)
    if res.code == "202"  # retry
      self.call
    else
      raise "Error in FoodTruckApiClient: Call to API failed, returning the HTTP status code #{res.code} and the following error message: #{error}"
    end
  end
end
