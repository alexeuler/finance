class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]

  def admin?
    role=='admin'
  end

  def full_name
    if last_name and not last_name.blank?
      first_name + ' ' + last_name
    else
      first_name
    end
  end


  def self.from_omniauth(auth)
    user = self.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    if user.id.nil?
      user.skip_confirmation!
      email = auth.info.email
      user_by_email=User.where(email:email).first
      user = user_by_email unless user_by_email.nil?
      case auth.provider
        when 'facebook'
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.nickname = auth.info.nickname
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.url = auth.info.urls['Facebook']
          user.image = auth.info.image
        when 'twitter'
          names = auth.info.name.split(' ')
          user.nickname = auth.info.nickname
          user.first_name = names[0]
          user.last_name = names[1]
          user.email = "#{user.first_name}.#{user.last_name}@twitter.com"
          user.password = Devise.friendly_token[0, 20]
          user.url = auth.info.urls['Twitter']
          user.image = auth.info.image
        when 'vkontakte'
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.nickname = auth.info.nickname
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.url = auth.info.urls['Vkontakte']
          user.image = auth.info.image
      end
      user.save
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
