# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :users, through: :users_tags_relationships
  has_many :microhoops, through: :microhoops_tags_relationships

  validates :name, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /^[a-zA-Z](?:[a-zA-z]|\d)*/i }
end
