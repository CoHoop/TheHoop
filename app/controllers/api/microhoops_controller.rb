class Api::MicrohoopsController < ApplicationController
	include ActiveSupport

  def create
    response = {}

    content  = params[:content]
    location = params[:location]
    uuid     = params[:fb_uid]
    tags     = params[:tags]

    user = User.find_by_fb_uuid(uuid)

    microhoop = user.microhoops.build(content: content, location: location)
    response[:created] = microhoop.tag!(tags, save: true) ? 1 : 0

    render json: response
  end

  def get
  	microhoop_id = params['microhoop_id']

  	microhoop = Microhoop.find_by_id(microhoop_id) or (microhoop_not_found(microhoop_id) and return)

	  response = {
	  	is_meeting: microhoop.is_meeting,
	  	content: microhoop.content,
	  	location: microhoop.location,
	  	date: microhoop.created_at,
	  	user_name: microhoop.user.name,
	  	microhoop_id: microhoop.id,
	  	votes: microhoop.votes,
	  	answers: microhoop.answers.map do |answer| 
	  		answer.attributes.except('updated_at', 'user_id', 'created_at')
	  	end
	  }

  	render json: response
  end

  def join
  	response = {
  		success: 0
  	}

  	microhoop_id = params['microhoop_id']
  	user_id = params['user_id']

  	microhoop = Microhoop.find_by_id(microhoop_id)

  	if microhoop
  		microhoop.is_meeting = true
  		microhoop.save!
  		response[:success] = 1
  	end

  	render json: response
  end

  private
  def microhoop_not_found id
    render :status => 401, :json => { :success => false, :errors => ["Microhoop does not exists for id #{id}."]}
  end
end
