require "spec_helper"
require "outside_temp"
require "weather-api"

describe "Outside Temp" do

  it "should return an error if there is no WOEID" do
    expect { OutsideTemp.new }.to raise_error(ArgumentError, "You must provide a valid WOEID")
  end

  it "should return an error if there is not a valid WOEID" do
    pending "The weather-api gem seems to return a no method error"
    # expect { OutsideTemp.new(8888888888) }.to raise_error(ArgumentError, "You must provide a valid WOEID")
  end

  context "using the current conditions for Deluth, MN" do

    before(:each) do
      @outside_temp = OutsideTemp.new(2394207)
      response = Weather.lookup(2394207)
      @current_temp = response.condition.temp
      @high_temp = response.forecasts.first.high
      @low_temp = response.forecasts.first.low
    end

    it "should show the current temp" do
      @outside_temp.current.should eq @current_temp
    end

    it "should show the high temp" do
      @outside_temp.high.should eq @high_temp
    end

    it "should show the low temp" do
      @outside_temp.low.should eq @low_temp
    end

  end

end