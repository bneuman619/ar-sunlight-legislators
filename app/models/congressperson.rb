require_relative '../../db/config'

class CongressPerson < ActiveRecord::Base
  validates :name, :uniqueness => :true
  validates :phone, :format => { :with => /\d{10,}/ }
  validates :fax, :format => { :with => /\d{10,}/ }

  def last_name
    self.split(' ')[-1]
  end
end
