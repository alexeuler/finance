class Image < ActiveRecord::Base
  attr_accessor :file
  has_attached_file :file, styles: {:large =>'800x500>', :medium => '400x250>', :small => '200x125>', :thumb => '96x60>' },
                    url: '/:style/image_:access_token.:extension',
                    path: ':rails_root/public/images/:url'

end
