CONSUMER_KEY    = "3UKpPByx3WxnuKUByK53Yw"
CONSUMER_SECRET = "BjKHnnAOSs8mrgfXbHbCqTJPq4Swom3q7BIIWG00Rs"
ACCESS_TOKEN    = "31145622-R7rA5BNJNIvu1s4RiAeAKePkXdjijlIfdDJxuh1U7"
ACCESS_SECRET   = "BOqUUymhB09XKI7R2NYdAhbRBSTjPdFcrhaaUuPM"

def create_rubytter
  consumer = OAuth::Consumer.new(
    CONSUMER_KEY,
    CONSUMER_SECRET,
    :site => 'http://api.twitter.com'
  )
  token = OAuth::AccessToken.new(
    consumer,
    ACCESS_TOKEN,
    ACCESS_SECRET
  )
  OAuthRubytter.new(token)
end

def save_timeline(screen_name, param)
  start_page = param[:page] || 1
  (start_page..10).each do |i|
    puts i
    param[:page] = i
    timeline = Twitter.timeline(screen_name, param)
    timeline.each do |t|
      tweet = Tweet.new
      tweet.text              = t[:text]
      tweet.status_id         = t[:id]
      tweet.user              = t[:user][:screen_name]
      tweet.profile_image_url = t[:user][:profile_image_url]
      tweet.posted_at         = t[:created_at]
      if tweet.save
        puts tweet.user
      else
        puts "failed."
      end
    end
    sleep 3
  end
end

def save_tweets(keyword, param)
  rubytter = create_rubytter

  start_page = param[:page] || 1
  (start_page..10).each do |i|
    puts i
    param[:page] = i
    tweets = rubytter.search(keyword, param)
    tweets.each do |t|
      tweet = Tweet.new
      tweet.text              = t.text
      tweet.user              = t.user.screen_name
      tweet.profile_image_url = t.user.profile_image_url
      tweet.posted_at         = t.created_at
      tweet.status_id         = t.id
      if tweet.save
        puts tweet.user
      else
        puts "failed."
      end
    end
    sleep 3
  end
end


screen_name = "doshisha"
keywords = ["同志社", "Doshisha"]
query = {
  :rpp  => "100"
}
keywords.each do |keyword|
  #save_timeline(screen_name, query)
  save_tweets(keyword, query)
end
