class Reading

  require 'google_drive'

  def initialize(username, password, spreadsheet_key)
    session = GoogleDrive.login(username, password)
    @ws = session.spreadsheet_by_key(spreadsheet_key).worksheets[0]
  end

  def count_rows
    @ws.num_rows
  end

  def count_columns
    @ws.num_cols
  end

  def record(date,outside_temp,twine_temp_array)
    add_column_headings(twine_temp_array.length)
    new_row = @ws.num_rows + 1
    @ws[new_row,1] = date
    @ws[new_row,2] = outside_temp
    i = 3
    for twine_temp in twine_temp_array do
      @ws[new_row,i] = twine_temp
      i += 1
    end
    @ws.save()
  end

  private

  def add_column_headings(number_of_twines)
    @ws[1,1] = "Time"
    @ws[1,2] = "Outside Temperature"
    number_of_twines.times do |i|
      @ws[1,i+3] = "Twine ##{i+1}"
    end
  end

end