class UsersListPDF < Prawn::Document 

  def initialize(options={}, &block)
    super 
    @table_headers = ["User name", ""]
  end
  
  def to_pdf users
    header

    common_styles = {border_color: "666666", text_color: "666666", border_width: 1}    
    table(table_data(users), header: true, column_widths: column_width, position: :center, :cell_style => common_styles) do 
      row(0).text_color = "428BCA"
      row(0).align = :center
    end

    footer

    render
  end
  
  def table_headers=(header_users)
    @table_headers = ["User Name"]
    header_users.each do |user|
      @table_headers << "#{user.first_name.capitalize} #{user.last_name[0]}."
    end
  end


  private

    def header
      #image image_tag "Light-IT.png" 
      text "Users list", align: :center, size: 24, color: "428BCA"
      move_down 20
    end

    def footer
      move_down 10
      text "Light IT, #{Date.today.strftime("%Y-%m-%d")}", align: :right, size: 8, color: "666666" 
    end

    def column_width
      width = 540
      count = @table_headers.length - 1
      if count > 0 
        [200] + [(width - 200)/count] * count
      else
        [200]
      end
    end

    def table_data(users)
      data = [@table_headers] 
      empty_columns = [""] * (@table_headers.length - 1)
      users.each do |user|
        data << (["#{user.first_name.capitalize} #{user.last_name.capitalize}"] + empty_columns)     
      end
      data
    end


end
