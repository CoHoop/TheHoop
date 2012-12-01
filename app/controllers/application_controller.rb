class ApplicationController < ActionController::Base
#  protect_from_forgery
  rescue_from ActionController::InvalidAuthenticityToken, :with => :invalid_token

  private
  def invalid_token exception
    puts 'Invalid Authenticity Token'
    puts exception
  end
end
