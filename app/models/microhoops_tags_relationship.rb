# == Schema Information
#
# Table name: microhoops_tags_relationships
#
#  id           :integer         not null, primary key
#  microhoop_id :integer
#  tag_id       :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#
class MicrohoopsTagsRelationship < ActiveRecord::Base
  attr_accessible :microhoop_id, :tag_id

  belongs_to :microhoop
  belongs_to :tag

  validates :microhoop_id, presence: true
  validates :tag_id,       presence: true
end
