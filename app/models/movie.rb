class Movie < ActiveRecord::Base
  attr_accessor :file
  has_attached_file :file,
                    styles:
                        {
                            :large => {:geometry => '800x500>', :format => 'jpg', :time => 10},
                            :medium => {:geometry => '400x250>', :format => 'jpg', :time => 10},
                            :small => {:geometry => '200x125>', :format => 'jpg', :time => 10},
                            :thumb => {:geometry => '96x60>', :format => 'jpg', :time => 10},
                        },
                    use_timestamp: false,
                    url: '/paperclip/movies/:style/:access_token.:extension',
                    path: ':rails_root/public/:url',
                    processors: [:ffmpeg]
  validates_attachment_presence :file
  validates_attachment :file, content_type: {content_type: ['video/mp4']}

  before_create :generate_access_token

  def as_json(options = {})
    result = super(options)
    result[:url_large] = self.file.url(:large)
    result[:url_medium] = self.file.url(:medium)
    result[:url_small] = self.file.url(:small)
    result[:url_thumb] = self.file.url(:thumb)
    result[:url] = self.file.url
    result
  end

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
