# Weather Forecast Rails Application

## Description
This application accepts an address as input, retrieves weather forecast data (current temperature, high, low, and extended forecast) for the given location using the LocationIQ API (for geocoding) and WeatherAPI (for forecast data). It caches the results for 30 minutes based on ZIP code.

## Features
- Accepts address as input parameter
- Geocoding performed via LocationIQ
- Retrieves current temperature, high/low, and 3-day extended forecast
- Caches results for 30 minutes using Redis
- Shows indicator if forecast is retrieved from cache
- Unit tests and request specs included

## Tech Stack
- Ruby on Rails
- Redis (for caching)
- HTTParty (HTTP requests)
- RSpec (testing framework)

## Setup Instructions
1. Clone this repository.
2. Add the following environment variables to your `.env` or local environment:
```
LOCATION_IQ_API_KEY=your_locationiq_api_key
WEATHER_API_KEY=your_weatherapi_key
REDIS_URL=redis://localhost:6379/1
```
3. Install dependencies:
```
bundle install
```
4. Start the Redis server:
```
redis-server
```
5. Run the Rails server:
```
rails server
```

## API Usage
### Endpoint:
```
GET /forecast?address=newyork
```
### Example Response:
```
{
  "current_temp": 5.1,
  "high_temp": 27.3,
  "low_temp": -1.7,
  "extended_forecast": [
    {
      "date": "2025-03-22",
      "high": 27.3,
      "low": -1.7
    },
    {
      "date": "2025-03-23",
      "high": 22.7,
      "low": 4.3
    },
    {
      "date": "2025-03-24",
      "high": 26.5,
      "low": 3
    }
  ],
  "from_cache": false
}
```

## Testing
Run all RSpec tests with:
```
bundle exec rspec