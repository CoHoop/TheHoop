class Api::UsersController < ApplicationController
  respond_to :json

  def login
    response = {
      complete: 1
    }

    uuid  = params['fb_uid']
    token = params['fb_token']
    user = User.find_or_create_by_fb_uuid(uuid)
    fb = Koala::Facebook::API.new(token)
    fb_user = fb.get_object('me')
    ap fb_user

    if user.name.blank?
      response[:complete] = 0
      # user.update_attributes()
    else
      # user.update
   end

    render json: response
  end
end
