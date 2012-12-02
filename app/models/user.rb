# == Schema Information
#
# Table name: users
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  email        :string(255)
#  university   :string(255)
#  points       :integer         default: 0
#  device_token :string(255)
#  fb_uuid      :string(255)
#  fb_token     :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#
class User < ActiveRecord::Base
  include Taggable

  attr_accessible :email, :name, :points, :university
  attr_accessible :fb_token, :fb_uuid, :device_token

  # Microhoops & Answers
  has_many :microhoops
  has_many :answers

  # Tags
  has_many :tags_relationships, class_name: 'UsersTagsRelationship', foreign_key: "user_id"
  has_many :tags, through: :tags_relationships

  NAME_VALIDATION = { allow_blank: true, length: { maximum: 25 }, format: { with: /\A[a-zA-Z\'\s]+\z/, message: 'Only letters allowed' } }
  VALID_EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(?:[A-Z]{2}|com|org|net|edu|gov|gouv|mil|biz|info|mobi|name|aero|asia|jobs|museum)$/i

  validates :name, NAME_VALIDATION
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  def add_points points
    self.points += points
    self.save!
  end
end

