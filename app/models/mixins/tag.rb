module Mixins::Tag
  def update_all
    # extracting tags array from posts
    separator = "|_|"
    tag_models = model.select(:tags, :language).to_a
    tag_groups = tag_models.map do |tag_model|
      post_tags = tag_model[:tags].split(" ")
      post_tags.map {|post_tag| post_tag+separator+tag_model[:language]}
    end
    tags = tag_groups.flatten
    tags.uniq!
    tags.sort!

    #clear tags models
    self.delete_all

    #Fill tags models
    tags.each do |tag|
      tag_and_lang = tag.split(separator)
      self.create(value: tag_and_lang[0], language: tag_and_lang[1])
    end
  end
end