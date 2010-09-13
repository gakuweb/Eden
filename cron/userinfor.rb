require "rubygems"
require "twitter"
require "oauth"

=begin
consumer_key="JQ1Pga5Gfy1VlXADwkNJEA"
consumer_secret="j5irUbRJfS7kkeCSpFG2wE8iYZjppS7ax2tNINhc1U"
access_token="151763436-x7sSNLfBoYdqSvYrfpFMlzLyuv28ojg2zGnmQmOv"
access_secret="WsaNJZ1D6x1jM7whsKzDi5NupLQacXBsocUpnue2HQ"
oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
oauth.authorize_from_access(access_token, access_secret)
twitter = Twitter::Base.new(oauth)
=end
#twitter.update("ok")
friends=Twitter.friend_ids("doshisha")		#doshishaがフォローしているユーザidを抽出

1.upto(2) do |a|
	tweet=Tweets.new
	tweet=Twitter.user(friends[a])[:name]
	tweet=Twitter.user(friends[a])[:profile_image_url]
	tweet.save
end

