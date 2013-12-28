class Twine
  
  require 'time'
  require 'net/http'
  require 'uri'
  require 'json'

  def initialize(twine_id, twine_access_key)
    @twine_id = twine_id
    @twine_access_key = twine_access_key
  end

  def status(reading="all")
    need_update?
    if reading == :temperature
      read_all['temperature'] / 100
    elsif reading == :orientation
      read_all['orientation']
    elsif reading == :vibration
      read_all['vibration']
    else
      read_all
    end
  end

  def update_status
    update_now if need_update?
  end

  private

  def need_update?
    if !File.exists?("/tmp/twine.cache") || Time.parse(File.read("/tmp/twine.cache", &:readline)) < (Time.now - 15*60)
      update_now
    end
  end

  def update_now
    File.open("/tmp/twine.cache", "w+") do |f|
      f.puts Time.now
      f.puts poll_twine.to_s
    end
  end

  def poll_twine
    uri = URI.parse("https://twine.cc/#{@twine_id}/rt?cached=1&access_key=#{@twine_access_key}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return JSON.parse(response.body)['values']
  end

  def read_all
    raw_data = JSON.parse(IO.readlines("/tmp/twine.cache")[1])
    parsed_data = Array.new
    for entry in raw_data do
      parsed_data << humanize_value(entry[0])
      parsed_data << entry[1]
    end
    return Hash[*parsed_data]
  end

  def read_temperature
    self.read_all[:temperature]
  end

  def read_orientation
    self.read_all[:orientation]
  end

  def read_vibration
    self.read_all[:vibration]
  end

  def humanize_value(raw_value)
    twine_code = raw_value.gsub(@twine_id,'')
    case twine_code.to_i
    when 00
      return "firmware"
    when 01
      return "temperature"
    when 02
      return "vibration"
    when 03
      return "orientation"
    when 04
      return "vibration_event"
    when 05
      return "battery_voltage"
    when 06
      return "not_used"
    when 07
      return "update_mode"
    else
      return false
    end 
  end

end