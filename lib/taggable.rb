module Taggable
  # Public: Add multiple tags to a user: tags a user.
  #
  # names - String of tags, separated by commas (example: "Foo, Bar, World")
  #
  # Returns the name of the tag as a String if the tags alread exists, false otherwise.
  def tag!(names, opts = { save: false })
    # Creates an index of all users tags relationships ids.
    # Example: [<Tag#1 name: 'Hola'>, <Tag#8 name: 'Segoritas'>] => [1, 8]
    tags = self.tags_relationships.map { |r| r.tag_id }

    # Clean each tag name : 'Tag1  , Tag3 , Tag1' => ["Tag1", "Tag3"]
    names.split(',').map(&:strip).to_set.each do |name|
      tag = Tag.where('LOWER(name) = ?', name.downcase).first_or_initialize(name: name)
      if tags.include? tag.id
        return name
      else
        tag.save!

        # If the taggable does not exists, save it
        self.save! if self.id.nil?

        self.tags_relationships.build(tag_id: tag.id)
      end
    end
    self.save! if opts[:save]
  end
end
