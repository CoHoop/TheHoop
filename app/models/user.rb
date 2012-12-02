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

  # TODO: Should strip special characters like "."
  # Public: Add multiple tags to a user: tags a user.
  #
  # names - String of tags, separated by commas (example: "Foo, Bar, World")
  # opts  - Options to pass, (default: { main: false })
  #         main - If the tag is a main tag or a secondary tag, as a Boolean.
  #
  # Returns the name of the tag as a String if the tags alread exists, false otherwise.
  def tag!(names)
    # Creates an index of all users tags relationships ids.
    # Example: [<Tag#1 name: 'Hola'>, <Tag#8 name: 'Segoritas'>] => [1, 8]
    user_tags = tags_relationships.map { |r| r.tag_id }

    # Clean each tag name : 'Tag1  , Tag3 , Tag1' => ["Tag1", "Tag3"]
    # TODO: Maybe refactor map(&:strip).to_set
    names.split(',').map(&:strip).to_set.each do |name|
      tag = Tag.where('LOWER(name) = ?', name.downcase).first_or_initialize(name: name)
      if user_tags.include? tag.id
        # TODO: Should perhaps display all erors
        return name
      else
        tag.save!
        tags_relationships.build(tag_id: tag.id)
      end
    end
    self.save!
    false
  end

  def add_points points
    self.points += points
    self.save!
  end
end