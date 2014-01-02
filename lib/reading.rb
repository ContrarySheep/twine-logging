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

  def record(outside_temp,twines)
    add_column_headings(twines)

    time_rotate if !@ws[2,1].empty?

    new_row = @ws.num_rows + 1

    # Record the current time
    @ws[new_row,1] = Time.now.getlocal('-05:00').strftime('%d/%m/%Y %l:%M %p')

    # Record the current outside_temp
    @ws[new_row,2] = outside_temp.current

    # Record the current temperature of each twine
    i = 3
    for twine in twines do
      selected_twine = Twine.new(twine[1])
      @ws[new_row,i] = selected_twine.status(:temperature)
      i += 1
    end
    @ws.save
  end

  private

  def add_column_headings(twines)
    @ws[1,1] = "Time"
    @ws[1,2] = "Outside Temperature"
    i = 0
    for twine in twines do
      @ws[1,i+3] = "#{twine[1]['twine_name']}"
      i += 1
    end
  end

  def time_rotate
    first_recorded_time = Time.parse(@ws[2,1])
    forty_eight_hours_ago = Time.now - 48 * 60 * 60
    if first_recorded_time <= forty_eight_hours_ago
      for row in @ws.rows
        row_number = @ws.rows.rindex(row)
        if row_number > 0
          for column in row do
            column_number = row.rindex(column)
            @ws[row_number+1,column_number+1] = @ws[row_number+2,column_number+1]
          end
        end
      end
      @ws.save
      @ws.reload
    end
  end

end