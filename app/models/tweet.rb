class Tweet < ActiveRecord::Base
  belongs_to :congress_person
  validates :tweet_id, :uniqueness => :true
end
