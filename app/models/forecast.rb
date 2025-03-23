class Forecast
  attr_reader :current_temp, :high_temp, :low_temp, :extended

  # Initializes forecast object with temperature details and extended forecast
  def initialize(current_temp:, high_temp:, low_temp:, extended: [])
    @current_temp = current_temp
    @high_temp = high_temp
    @low_temp = low_temp
    @extended = extended
  end

  # Returns hash representation of forecast object
  def as_json(*_args)
    {
      current_temp: current_temp,
      high_temp: high_temp,
      low_temp: low_temp,
      extended_forecast: extended
    }
  end
end
