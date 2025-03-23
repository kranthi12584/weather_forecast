class GeocodingService
  # Uses LocationIQ API to convert address to ZIP code
  def self.get_zip(address)
    response = HTTParty.get("https://us1.locationiq.com/v1/search.php", query: {
      key: ENV["LOCATION_IQ_API_KEY"],
      q: address,
      format: "json",
      limit: 1
    })

    if response.success? && response.parsed_response.any?
      lat = response.parsed_response[0]["lat"]
      lon = response.parsed_response[0]["lon"]

      reverse_response = HTTParty.get("https://us1.locationiq.com/v1/reverse.php", query: {
        key: ENV["LOCATION_IQ_API_KEY"],
        lat: lat,
        lon: lon,
        format: "json"
      })

      if reverse_response.success?
        reverse_response.parsed_response.dig("address", "postcode")
      end
    end
  end
end
