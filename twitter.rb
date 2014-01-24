require 'twitter'
require_relative 'db/config'
require_relative 'app/models/tweet'
require_relative 'app/models/senator'
require_relative 'app/models/representative'
require_relative 'app/models/congressperson'

def start
  Twitter.configure do |config|
    config.consumer_key = 'IJbx3paMngQQXDQHZWAyg'
    config.consumer_secret = 'cGt30Ds0zX8CEYfOyoksu4OdLurpK6Fm6eeGDadtCrE'
    config.oauth_token = '409668824-6dTHEZjHdTZboOZbLYyAp8169FKon0F9Ro9nQxQo'
    config.oauth_token_secret = 'GmOJAnjfuoroV7E7XOR84q7XSMFqiiXTQByTGuX8jAK4p'
  end
end

def get_tweets(username, count=10)
  Twitter.user_timeline(username, count: 10)
end

 def add_tweets_to_db(legislator)
  tweets = get_tweets(legislator.twitter_id)
  tweets.each do |tweet|
    Tweet.create(content: tweet.text, tweet_id: tweet.attrs[:id], 
                 tweeted_at: tweet.attrs[:created_at], congress_person: legislator)
  end
end

def seed
  start
  bad_ids = []
  #ActiveRecord::Base.connection
  CongressPerson.all.select { |cp|
    cp.twitter_id != "" && !already_seeded(cp.id)
  }.each do |cp|
    begin
      add_tweets_to_db(cp)
    rescue Twitter::Error::NotFound
      bad_ids << cp.twitter_id
    rescue Twitter::Error::Unauthorized
      bad_ids << cp.twitter_id
    end
  end
end

def already_seeded(cp_id)
  Tweet.find_by(congress_person_id: cp_id) == nil
end

seed

