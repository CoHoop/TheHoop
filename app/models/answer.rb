# == Schema Information
#
# Table name: answers
#
#  id           :integer         not null, primary key
#  microhoop_id :integer
#  user_id      :integer
#  content      :text
#  votes        :integer         default(0), not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#
class Answer < ActiveRecord::Base
  include Voteable

  attr_accessible :content, :votes, :user_id

  belongs_to :user
  belongs_to :microhoop

  validates :content,      presence: true
  validates :microhoop_id, presence: true
  validates :user_id,      presence: true
end
