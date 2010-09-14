require "rubygems"
require "rubytter"
require "open3"

#引数で与えられた文章を形態素解析する
def mecab(text)
  ret=[]
  Open3.popen3("/usr/local/bin/mecab") do |stdin,stdout,stderr|
    stdin.puts text
    stdin.close
    stdout.each do |line|
      ret.push line
	end
  end
  ret.pop
  return ret
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

search_word_doshisha