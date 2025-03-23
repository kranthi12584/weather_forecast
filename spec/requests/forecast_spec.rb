require "rails_helper"

describe "Forecast API", type: :request do
  it "returns forecast data with cache indicator (API hit)" do
    allow(GeocodingService).to receive(:get_zip).and_return("12345")
    allow(CacheService).to receive(:fetch).and_return(nil)
    allow(WeatherService).to receive(:get_forecast).and_return({ current_temp: 25, high_temp: 30, low_temp: 20, extended_forecast: [] })

    get "/forecast", params: { address: "Some address" }, headers: { "ACCEPT" => "application/json" }

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body["current_temp"]).to eq(25)
    expect(body["from_cache"]).to eq(false)
  end

  it "returns forecast data from cache" do
    cached_data = { current_temp: 22, high_temp: 28, low_temp: 18, extended_forecast: [] }
    allow(GeocodingService).to receive(:get_zip).and_return("54321")
    allow(CacheService).to receive(:fetch).and_return(cached_data)

    get "/forecast", params: { address: "Cached address" }, headers: { "ACCEPT" => "application/json" }

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body["current_temp"]).to eq(22)
    expect(body["from_cache"]).to eq(true)
  end

  it "returns error message for invalid address" do
    allow(GeocodingService).to receive(:get_zip).and_return(nil)

    get "/forecast", params: { address: "Invalid Address" }

    expect(response.body).to include("Invalid address")
  end

  it "returns error message if weather data unavailable" do
    allow(GeocodingService).to receive(:get_zip).and_return("67890")
    allow(CacheService).to receive(:fetch).and_return(nil)
    allow(WeatherService).to receive(:get_forecast).and_return(nil)

    get "/forecast", params: { address: "Unavailable data address" }

    expect(response.body).to include("Weather data unavailable")
  end
end
