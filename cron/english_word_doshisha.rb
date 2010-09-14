require "rubygems"
require "rubytter"

#doshishaを含むツイートを抽出
def search_word_Doshisha
	rubytter=Rubytter.new
	tweets=rubytter.search("doshisha")
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

search_word_Doshisha