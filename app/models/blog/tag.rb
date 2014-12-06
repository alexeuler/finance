class Blog::Tag < ActiveRecord::Base
  def self.update_all
    # extracting tags array from posts
    tag_models = Blog::Post.select(:tags).to_a
    tag_strings = tag_models.map {|tag| tag[:tags]}
    tag_string = tag_strings.join(" ")
    tags = tag_string.split(" ")
    tags.uniq!
    tags.sort!

    #clear tags models
    Blog::Tag.delete_all

    #Fill tags models
    tags.each {|tag| Blog::Tag.create(value: tag)}
  end
end
