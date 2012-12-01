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

    if user.name.blank?
      response[:complete] = 0
      update_user_with_fb(user, fb_user)
    else
      update_user_with_fb(user, fb_user)
    end

    render json: response
  end

  def register
    response = {
      updated: 1
    }

    uuid = params['fb_uid']
    university = params['university']
    name = params['name']
    tags = params['tags']

    user = User.find_by_fb_uuid(uuid)

    unless user.update_attributes name: name, university: university
      response[:updated] = 0
    end

    user.tag! tags

    render json: response
  end

  private
  def update_user_with_fb user, fb_user
    user.update_attributes(
      name: fb_user['name'],
      fb_uuid: fb_user['id'],
      email: fb_user['email'],
      university: fb_user['education'].last['school']['name']
    )
  end

end
