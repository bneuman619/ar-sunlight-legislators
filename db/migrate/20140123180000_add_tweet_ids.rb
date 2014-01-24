require_relative '../config'

class AddTweetIds < ActiveRecord::Migration
  add_column :tweets, :tweet_id, :string
end
