class OutsideTemp
  require 'weather-api'

  def initialize(woeid = nil)
    if woeid
      @weather_response = Weather.lookup(woeid)
    else
      raise ArgumentError, "You must provide a valid WOEID"
    end
  end

  def current
    @weather_response.condition.temp
  end

  def high
    @weather_response.forecasts.first.high
  end

  def low
    @weather_response.forecasts.first.low
  end

end