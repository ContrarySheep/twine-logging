require "spec_helper"
require "twine"

describe "Twine" do

  before(:each) do
    @twine = Twine.new(CREDENTIALS['twine_id'],CREDENTIALS['twine_access_key'])
  end
  
  it "should create a new instance of the Twin class" do
    Twine.new(CREDENTIALS['twine_id'],CREDENTIALS['twine_access_key'])
  end

  it "should check if the status needs updating" do
    File.open("/tmp/twine.cache", "w+") { |file| file.write(Time.now - 15*60*60) }
    @twine.update_status
    Time.parse(File.read("/tmp/twine.cache", &:readline)).should be_within(10).of(Time.now)
    File.open("/tmp/twine.cache", "w+") { |file| file.write(Time.now - 7*60) }
    @twine.update_status
    Time.parse(File.read("/tmp/twine.cache", &:readline)).should_not be_within(10).of(Time.now)
    File.delete("/tmp/twine.cache")
  end

  context "initialized with preset data" do

    before(:all) do
      File.open("/tmp/twine.cache", "w+") do |f|
        f.puts Time.now
        f.puts "[[\"#{CREDENTIALS['twine_id']}00\", \"2.0.2\"], [\"#{CREDENTIALS['twine_id']}01\", 7100], [\"#{CREDENTIALS['twine_id']}03\", \"top\"], [\"#{CREDENTIALS['twine_id']}05\", 2941750], [\"#{CREDENTIALS['twine_id']}06\", 0], [\"#{CREDENTIALS['twine_id']}07\", 0], [\"#{CREDENTIALS['twine_id']}04\", 0], [\"#{CREDENTIALS['twine_id']}02\", 0]]"
      end
    end

    it "should return the appropriate number of status objects for all" do
      @twine.status.length.should eq 8
    end

    it "should return the appropriate status objects for temperature" do
      @twine.status(:temperature).should eq 71
    end

    it "should return the appropriate status objects for orientation" do
      @twine.status(:orientation).should eq "top"
    end

    it "should return the appropriate status objects for vibration" do
      @twine.status(:vibration).should eq 0
    end

  end

end