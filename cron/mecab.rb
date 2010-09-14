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

tweets=Tweet.all #Tweet DBに保存されている情報を取得

tweets.each do |a|
  ret=mecab(a.text)#解析結果を格納する
  ret.each do |b|
    if b=~/.+名詞.+/#品詞が名詞の場合の処理
      b=b.split(/名詞/)
      nomen=b[0]   #品詞が名詞である単語をnomenに格納
      
      #word　DB　に登録する
      word=Word.new
      word.word_name=nomen
      word.word_status_id=a.status_id
      word.count=1
      
      #tweetword DB に保存
      #新規保存の場合
      if word.save
        tweetword=TweetWord.new
        tweetword.tweet_id=a.id
        tweetword.word_id=word.id
        tweetword.save
      
      #既存する場合
      else 
        aaaa=Word.find_by_word_name(nomen)
        tweetword=TweetWord.new
        tweetword.tweet_id=a.id
        tweetword.word_id=aaaa.id
        tweetword.save
        aaaa.count=aaaa.count+1
        aaaa.save
      end      
    end
  end
end