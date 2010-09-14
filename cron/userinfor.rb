require "rubygems"
require "twitter"
require "rubytter"

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

#同志社を含むツイートを抽出
def search_word_doshisha
	rubytter=Rubytter.new
	tweets=rubytter.search("同志社")
	tweets.each do |person|
		tweet = Tweet.new	
		tweet.text = person.text
		tweet.user = person.user.screen_name
		tweet.profile_image_url = person.user.profile_image_url 		
		tweet.posted_at= person.created_at
	    tweet.status_id = person.id
		tweet.save
	end
end

search_doshisha_tweet
search_word_doshisha