require_relative '../../db/config'

class CongressPerson << ActiveRecord::Base
  validates :name, :uniqueness => true
  validates :phone, :format => { :with => /\d{10,}/ }
end
