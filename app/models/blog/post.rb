class Blog::Post < ActiveRecord::Base
  has_attached_file :image, :styles => { :normal => "400x250>", :thumb => "100x62>" },
                    :default_url => "/images/blog/:style/missing.png"
  validates_attachment :image,
                       :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  after_commit :update_tags

  before_save :destroy_image?

  def image_delete
    @image_delete ||= "0"
  end

  def image_delete=(value)
    @image_delete = value
  end

  private
  def destroy_image?
    self.image.clear if image_delete == "1"
  end

  def update_tags
    Blog::Tag.update_all
  end
end
