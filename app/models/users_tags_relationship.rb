# == Schema Information
#
# Table name: users_tags_relationships
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  tag_id     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class UsersTagsRelationship < ActiveRecord::Base
  attr_accessible :tag_id

  belongs_to :user
  belongs_to :tag

  validates :user_id, presence: true
  validates :tag_id,  presence: true
end
