class Json < ApplicationRecord
  belongs_to :api
end

#we know this shouldnt be here ¯\(°_o)/¯
class String
  def is_json?
    begin
      !!JSON.parse(self)
    rescue
      false
    end
  end
end
