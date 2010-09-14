require "rubygems"
require "twitter"

#アカウント同志社が発言したものを抽出
def search_doshisha_tweet
	timeline=Twitter.timeline("doshisha")		#doshishaのタイムラインを取得する
	timeline.each do |doshisha|
		tweet=Tweet.new
		tweet.text= doshisha[:text]
		tweet.status_id= doshisha[:id]
		tweet.user=doshisha[:user][:screen_name]
		tweet.profile_image_url=doshisha[:user][:profile_image_url]
		tweet.posted_at=doshisha[:created_at]
		tweet.save
	end
end

search_doshisha_tweet
