class Blog::Post < ActiveRecord::Base
  has_attached_file :image, :styles => { :normal => "400x250>", :large => "800x500>" },
                    :default_url => "/system/missing.png"
  validates_attachment :image,
                       :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  after_commit :update_tags

  before_save :destroy_image?

  attr_accessor :image_delete

  private
  def destroy_image?
    self.image.clear if image_delete == "1"
  end

  def update_tags
    Blog::Tag.update_all
  end
end
