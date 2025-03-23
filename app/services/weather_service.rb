class WeatherService
  # Fetches weather forecast for given ZIP code from WeatherAPI
  def self.get_forecast(zip_code)
    response = HTTParty.get("https://api.weatherapi.com/v1/forecast.json", query: {
      key: ENV["WEATHER_API_KEY"],
      q: zip_code,
      days: 3
    })

    if response.success?
      data = response.parsed_response
      Forecast.new(
        current_temp: data.dig("current", "temp_c"),
        high_temp: data.dig("forecast", "forecastday")[0].dig("day", "maxtemp_c"),
        low_temp: data.dig("forecast", "forecastday")[0].dig("day", "mintemp_c"),
        extended: data["forecast"]["forecastday"].map do |day|
          { date: day["date"], high: day["day"]["maxtemp_c"], low: day["day"]["mintemp_c"] }
        end
      ).as_json
    end
  end
end
