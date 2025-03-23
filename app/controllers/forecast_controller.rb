class ForecastController < ApplicationController
  # Retrieves the forecast for a given address
  def show
    unless params[:address].blank?
      address = params[:address]
      zip_code = GeocodingService.get_zip(address)

      if zip_code.nil?
        render json: { error: "Invalid address" }, status: :unprocessable_entity
        return
      end

      cached_data = CacheService.fetch(zip_code)

      if cached_data
        render json: cached_data.merge(from_cache: true)
      else
        forecast = WeatherService.get_forecast(zip_code)
        if forecast
          CacheService.store(zip_code, forecast)
          render json: forecast.merge(from_cache: false)
        else
          render json: { error: "Weather data unavailable" }, status: :service_unavailable
        end
      end
    end
  end
end
