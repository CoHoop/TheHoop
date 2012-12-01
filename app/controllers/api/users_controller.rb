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
      user.update_attributes(email: fb_user['email'])
    else
      user.update_attributes(email: fb_user['email'])
    end

    render json: response
  end

  def update
    response = {
      updated: 1
    }

    uuid       = params['fb_uid']
    university = params['university']
    name       = params['name']
    email      = params['email']
    tags       = params['tags']

    user = User.find_by_fb_uuid(uuid) or (user_not_found(uuid) and return)

    unless user.update_attributes name: name, university: university, email: email
      response[:updated] = 0
    end

    user.tag! tags, save: true

    render json: response
  end

  def feed
    uuid = params['fb_uid']

    user = User.find_by_fb_uuid(uuid)

    microhoops = Microhoop.related_to user: user
    
    response = []
    
    ap microhoops

    microhoops.each do |microhoop|
      response << {
        microhoop_id:   microhoop.id,
        user_name:      microhoop.user.name,
        location:       microhoop.location,
        votes:          microhoop.votes,
        is_meeting:     microhoop.is_meeting,
        date:           microhoop.created_at,
        answers_count:  microhoop.answers.length,
        content:        microhoop.content
      }
    end

    render json: response
  end

  private
  def user_not_found uuid
    render :status => 401, :json => { :success => false, :errors => ["User does not exists for uid #{uuid}."]}
  end
end
