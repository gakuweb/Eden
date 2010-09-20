class TweetsController < ApplicationController
  before_filter :tweet_count

  def index
    @words = []
    words = Word.find(:all,:order => 'count DESC', :conditions => ['count >= ?', 10])
    words.each do |word|
      next unless is_meaningful(word)
      @words.push(word)
    end

    @tweets = params[:word] ?
      Word.find(:first, :conditions => ['name = ?', params[:word]]).tweets.find(:all, :order =>:posted_at, :limit => 10) :
      Tweet.find(:all, :order => :posted_at, :limit => 10)

      token = OAuth::AccessToken.new(self.consumer,session[:oauth_token],session[:oauth_verifier])
 		  rubytter = OAuthRubytter.new(token)
 		  twitter_user_information = rubytter.user(session[:user_id])
 		  @twitter_user_photo_url = twitter_user_information[:profile_image_url]
 		  @twitter_user_screen_name = twitter_user_information[:screen_name]
  end

  def is_meaningful(word)
    if word.name.length < 6   ||
      word.name =~ /同志社/   ||
      word.name =~ /\d+/      ||
      word.name =~ /[a-z]+/   ||
      word.name =~ /[A-Z]+/   ||
      word.name =~ /[Ａ-Ｚ]+/ ||
      word.name =~ /[ａ-ｚ]+/ ||
      word.name =~ /[あ-ん]+/ && word.name.length <= 6 ||
      word.name =~ /[ア-ン]+/ && word.name.length <= 6 # ひらがな/カタカナのみの2文字の単語を排除
      return false
    else
      return true
    end
  end

  def tweet_count
    @tweet_count = Tweet.count(:all)
  end

  def oauth
    request_token=consumer.get_request_token(:oauth_callback => "http://#{request.host_with_port}/tweets/callback")
    session[:request_token]=request_token.token
 	  session[:request_token_secret]=request_token.secret
 	  redirect_to request_token.authorize_url
  end

  def callback
    begin
  	  consumer = self.consumer
  	  request_token = OAuth::RequestToken.new(consumer,session[:request_token],session[:request_token_secret])
  	  access_token = request_token.get_access_token({},
  	  :oauth_token => params[:oauth_token],
  	  :oauth_verifier => params[:oauth_verifier])
  	  response=consumer.request(:get,"/account/verify_credentials.json",
  	  access_token,{:scheme => :query_string}
  	  )
  	case response
  	  when Net::HTTPSuccess
  		  @user_info = JSON.parse(response.body)
  		  unless @user_info["screen_name"]
  			  flash[:notice] = "Authentication failed"
  			  redirect_to :action => :index
  		  end
  		
  		else
  		 RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
  		 flash[:notice] = "Authentication failed"
  		 redirect_to :action => :index
  		 return
  		end
  		session[:request_token] = nil
  		session[:request_token_secret] = nil
  		session[:oauth] = true
  		session[:oauth_token] = access_token.token
  		session[:oauth_verifier] = access_token.secret
  		session[:user_id] = access_token.params[:user_id]
  		access_time = Time.now
    	redirect_to :action => :index
    	rescue OAuth::Unauthorized
    		redirect_to :action => :index
    	end
  end

  def logout
    session[:oauth] = false
    session[:oauth_token] = nil
    session[:oauth_verifier] = nil
    redirect_to :action => :index
  end

  def tweet
    if session[:oauth]
      token = OAuth::AccessToken.new(self.consumer,session[:oauth_token],session[:oauth_verifier])
 			rubytter = OAuthRubytter.new(token)
    end
  end
end
