class Image::Tag < ActiveRecord::Base
  def self.update_all
    # extracting tags array from posts
    tag_models = Image.select(:tags).to_a
    tag_groups = tag_models.map do |tag_model|
      tag_model[:tags].split(' ')
    end
    tags = tag_groups.flatten
    tags.uniq!
    tags.sort!

    #clear tags models
    Image::Tag.delete_all

    #Fill tags models
    tags.each do |tag|
      Image::Tag.create(value: tag)
    end
  end

end
