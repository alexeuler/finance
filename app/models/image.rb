class Image < ActiveRecord::Base
  attr_accessor :file
  has_attached_file :file, styles: {:large => '800x500>', :medium => '400x250>', :small => '200x125>', :thumb => '96x60>'},
                    use_timestamp: false,
                    url: '/paperclip/images/:style/:access_token.:extension',
                    path: ':rails_root/public/:url'
  validates_attachment_presence :file
  validates_attachment :file, content_type: {content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']}


  before_create :generate_access_token

  private


  # simple random salt
  def random_salt(len = 20)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    salt = ""
    1.upto(len) { |i| salt << chars[rand(chars.size-1)] }
    return salt
  end

  # SHA1 from random salt and time
  def generate_access_token
    self.access_token=Digest::SHA1.hexdigest("#{random_salt}#{Time.now.to_i}")
  end

  # interpolate in paperclip
  Paperclip.interpolates :access_token do |attachment, style|
    attachment.instance.access_token
  end


end
