class OutsideTemp
  require 'weather-api'

  def self.current(woeid)
    Weather.lookup(woeid).condition.temp
  end

  def self.high(woeid)
    Weather.lookup(woeid).forecasts.first.high
  end

  def self.low(woeid)
    Weather.lookup(woeid).forecasts.first.low
  end

end