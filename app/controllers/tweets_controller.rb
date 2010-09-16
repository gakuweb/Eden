class TweetsController < ApplicationController
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC', :limit => 100)
    @tweets_count = Tweet.count(:all)
    @word = Word.find(:all,:order => 'count DESC')
    @tweetword = TweetWord.all
    @arrayword = Array.new(Word.count(:all)).map{ Array.new(3)}  #形態素解析結果に対してフィルター処理を施した単語を格納する２次元配列
	@count = 0 #@arrayword[]の長さを表す変数
	@max = 0 #@arrayword[][]の長さを表す変数

#指定した単語を除外する処理
#”同志社”を含む単語、数字だけの単語、アルファベットだけの単語、ひらがなのみの単語でかつバイト長が6バイト以下の単語、カタカナのみからなる単語でかつバイト長が６バイト以下の単語を除外
	@word.each do |a|
	  if a.name =~ /同志社/ || a.name =~ /[0-9+]/ || a.name =~ /[a-z+]/ || a.name =~ /[A-Z+]/ || a.name =~ /[Ａ-Ｚ]/ || a.name =~ /[ａ-ｚ]/ || a.name =~ /[あ-ん]/ && a.name.length <= 6 || a.name =~ /[ア-ン]/ && a.name.length <= 6

#フィルターにかからなかった単語を@arraywordに格納する
	  elsif a.name.length >= 6&&a.count >= 10
	  	@arrayword[@count][0] = a.id #Word DB　の主キーであるid
	    @arrayword[@count][1] = a.name #Word DB 単語の名前
	    @arrayword[@count][2] = a.count #Word DB 単語の出現回数
	    @count += 1

#後の@tweettext,@tweetuser,@tweetimageの配列を設定するために使用
	    if @max < a.count
	      @max = a.count
	    end
	  end
	end

#site上で指定した単語を含むツイート、ユーザ、アイコンを表示させるための準備
	count = 0
	arraycount = 0
	@tweettext = Array.new(@count).map{Array.new(@max)}	 #ツイートが保存される
	@tweetuser = Array.new(@count).map{Array.new(@max)}	 #ツイートの所持者が保存される
	@tweetimage = Array.new(@count).map{Array.new(@max)}	#ツイートの所持者のアイコンが保存される

#フィルターにかからなかった単語の数だけ以下を実行
	@arrayword.each do |b|
	  searchid = b[0] #Word DB の主キーをsearchidへ
	  #TweetWord DB のword_id=searchid　となるデータを検索、一致するデータ個数だけ以下を実行
	  TweetWord.find(:all,:conditions => {:word_id => searchid}).each do |c|
	    tweet = Tweet.find_by_id(c.tweet_id)
	    @tweettext[count][arraycount] = tweet.text
	    @tweetuser[count][arraycount] = tweet.user
	    @tweetimage[count][arraycount] = tweet.profile_image_url
	    arraycount +=1
	  end
	  arraycount = 0
	  count += 1
	end		
  end
end
