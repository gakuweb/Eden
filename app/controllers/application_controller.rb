require "rubygems"
require "rubytter"
require "oauth"

class ApplicationController < ActionController::Base
  protect_from_forgery

  def consumer
      	OAuth::Consumer.new("H4KnHwbWKSEw6ZOwyIP16A","z1T22Kt0qzjnu4GY8QOUJ7RaidxYCBiEPF6LPLzyYI",{ :site=> "http://twitter.com"}
  	)
  end


end
