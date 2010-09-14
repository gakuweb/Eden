require "rubygems"
require "twitter"

=begin
require "oauth"
consumer_key="JQ1Pga5Gfy1VlXADwkNJEA"
consumer_secret="j5irUbRJfS7kkeCSpFG2wE8iYZjppS7ax2tNINhc1U"
access_token="151763436-x7sSNLfBoYdqSvYrfpFMlzLyuv28ojg2zGnmQmOv"
access_secret="WsaNJZ1D6x1jM7whsKzDi5NupLQacXBsocUpnue2HQ"
oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
oauth.authorize_from_access(access_token, access_secret)
twitter = Twitter::Base.new(oauth)
=end

friends=Twitter.friend_ids("doshisha")		#doshishaがフォローしているユーザidを抽出

count=0
#DB(Tweet)に”ユーザネーム”と”アイコンのurl”と”最新tweet”と”tweetのid”を保存する
friends.each do |person|
	tweet=Tweet.new
	user_infor=Twitter.user(person)
	tweet.user=user_infor[:name]
	tweet.profile_image_url=user_infor[:profile_image_url]
	tweet.text=user_infor[:status][:text]
	tweet.status_id=user_infor[:status][:id]
	tweet.save
	count=count+1
	if count==10
		break
	end
end
