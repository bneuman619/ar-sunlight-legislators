require_relative '../../db/config'

class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :congress_person
      t.datetime :tweeted_at
      t.text :content
    end
  end
end

