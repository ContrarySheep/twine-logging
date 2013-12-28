require "spec_helper"
require "twine"

describe "Twine" do

  before(:all) do
    @twines = CREDENTIALS['twines']
  end

  it "should return an error if the twine credentials are missing" do
    expect { Twine.new }.to raise_error(ArgumentError, "You must provide valid twine credentials")
  end

  it "should return the first twine's name" do
    twine = Twine.new(@twines.values.first)
    twine.name.should eq @twines.values.first['twine_name']
  end

  it "should return the first twine's access key" do
    twine = Twine.new(@twines.values.first)
    twine.access_key.should eq @twines.values.first['twine_access_key']
  end

  it "should return the first twine's id" do
    twine = Twine.new(@twines.values.first)
    twine.id.should eq @twines.values.first['twine_id']
  end

  it "should return the first twines status hash with 8 readings" do
    twine = Twine.new(@twines.values.first)
    twine.status.length.should eq 8
  end

  it "should return the first twines temperature in the status hash" do
    twine = Twine.new(@twines.values.first)
    twine.status(:temperature).should_not eq nil
  end

  it "should return the first twines orientation in the status hash" do
    twine = Twine.new(@twines.values.first)
    twine.status(:orientation).should_not eq nil
  end

  it "should return the first twines vibration in the status hash" do
    twine = Twine.new(@twines.values.first)
    twine.status(:vibration).should_not eq nil
  end

end