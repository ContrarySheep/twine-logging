require "spec_helper"
require "outside_temp"
require "weather-api"

describe "Outside Temp" do
  
  before(:all) do
    response = Weather.lookup(CREDENTIALS['woeid'])
    @current_temp = response.condition.temp
    @high_temp = response.forecasts.first.high
    @low_temp = response.forecasts.first.low
  end

  it "should show the current temp" do
    OutsideTemp.current(CREDENTIALS['woeid']).should eq @current_temp
  end

  it "should show the high temp" do
    OutsideTemp.high(CREDENTIALS['woeid']).should eq @high_temp
  end

  it "should show the low temp" do
    OutsideTemp.low(CREDENTIALS['woeid']).should eq @low_temp
  end

end