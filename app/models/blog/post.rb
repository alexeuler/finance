class Blog::Post < ActiveRecord::Base
  has_attached_file :image, :styles => { :normal => "400x250>", :large => "800x500>" },
                    :default_url => "/system/missing.png"
  validates_attachment :image,
                       :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  after_commit :update_tags

  belongs_to :video_group, :class_name => 'Video::Group'


  private

  def update_tags
    Blog::Tag.update_all
  end
end
