class Api::MicrohoopsController < ApplicationController
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
end
