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
	  	is_meeting: 		microhoop.is_meeting,
	  	content: 				microhoop.content,
	  	location: 			microhoop.location,
	  	date: 					microhoop.created_at,
	  	user_name: 			microhoop.user.name,
	  	microhoop_id: 	microhoop.id,
	  	votes: 					microhoop.votes,
	  	answers: 				filter_attributes(microhoop.answers, 'updated_at', 'user_id', 'created_at')
	  }

  	render json: response
  end

  def join
  	response = {
  		success: 0
  	}

  	microhoop_id = params['microhoop_id']
  	
  	microhoop = Microhoop.find_by_id(microhoop_id)

  	if microhoop
  		microhoop.is_meeting = true
  		microhoop.save!
  		response[:success] = 1
  	end

  	render json: response
  end

  def voteup
    response = {
      success: 1
    }

    microhoop_id = params['microhoop_id']
    microhoop = Microhoop.find_by_id(microhoop_id)

    if microhoop
      microhoop.user.add_points 10
      microhoop.vote_up
    else
      response[:success] = 0
    end

    render json: response
  end

  private
  def microhoop_not_found id
    render :status => 401, :json => { :success => false, :errors => ["Microhoop does not exists for id #{id}."]}
  end

  # Internal: Filters an Array of ActiveRecord objects, removing unwanted attributes
  #
  # array    - An Array of ActiveRecord objects, or relations.
  # except - Multiple arguments as String representing the unwanted attributes
  #
  # Example:
  #
  #   filter_attributes(tags, 'created_at', 'updated_at')
  #
  # Return an Array of filtered Hashes.
  def filter_attributes array, *except
    array.map do |item|
      item.attributes.except(*except)
    end
  end
end
