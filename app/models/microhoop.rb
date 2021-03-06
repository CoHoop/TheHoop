# == Schema Information
#
# Table name: microhoops
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  content    :text            not null
#  votes      :integer         default(0), not null
#  location   :string(255)     not null
#  is_meeting :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Microhoop < ActiveRecord::Base
  include Taggable
  include Voteable

  attr_accessible :content, :location, :is_meeting

  belongs_to :user
  has_many :tags_relationships, class_name: 'MicrohoopsTagsRelationship', foreign_key: "microhoop_id"
  has_many :tags, through: :tags_relationships
  has_many :answers

  validates :content,  presence: true
  validates :location, presence: true
  validates :user_id,  presence: true

  def self.related_to params = { user: nil }
    Microhoop.order('created_at DESC').all
    #.where('id in (select r.microhoop_id from microhoops_tags_relationships as r where tag_id in (select r.tag_id from users_tags_relationships as r where user_id = ?))',
    #  params[:user].id)
    
  end

end
