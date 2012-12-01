class Api::AnswersController < ApplicationController

  def create
    response = {
      created: 1
    }

    uuid = params['fb_uid']
    microhoop_id = params['microhoop_id']
    content = params['content']

    user = User.find_by_fb_uuid(uuid);

    answer = Microhoop.find(microhoop_id).answers.build(user_id: user.id, content: content)

    unless answer.save!
      response[:created] = 0
    end

    render json: response
  end

  def voteup
    response = {
      created: 1
    }

    answer_id = params['answer_id']
    
    answer = Answer.find(answer_id)
    answer.user.add_points 10
    
    answer.add_vote

    render json: response
  end
end