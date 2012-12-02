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
end
