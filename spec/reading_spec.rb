require "spec_helper"
require "reading"

describe "Reading" do

  before(:each) do
    @reading = Reading.new(CREDENTIALS['google_username'],CREDENTIALS['google_password'],CREDENTIALS['google_spreadsheet_key'])
  end
  
  it "should add a reading to the spreadsheet" do
    current_rows = @reading.count_rows
    @reading.record(Time.now,70,[70])
    @reading.count_rows.should eq current_rows+1
  end

end