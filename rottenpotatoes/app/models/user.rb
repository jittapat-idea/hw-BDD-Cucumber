class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.nickname = auth.info.nickname
      user.image_url = auth.info.image
      user.token = auth.credentials.token
      user.secret = auth.credentials.secret
    end
  end

end
