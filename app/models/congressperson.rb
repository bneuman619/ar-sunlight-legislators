require_relative '../../db/config'

class CongressPerson < ActiveRecord::Base
  validates :name, :uniqueness => :true
  validate :check_pn_fax
  has_many :tweets

  def last_name
    self.name.split(' ')[-1]
  end

  def check_pn_fax
    if bad_pn?(self.phone)
      errors.add(:phone, "Bad phone number")
    elsif bad_pn?(self.fax)
      errors.add(:fax, "Bad fax")
    end
  end

  def bad_pn?(num)
    (num.to_s.length < 10) && num != 0
  end

end
