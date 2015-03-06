module UsersHelper
  def change_year(year, date)
    Date.new(date).change(year: year)
  end
end
