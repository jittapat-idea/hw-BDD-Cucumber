
class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!!"
  end
  
  def twitter
    redirect_to auth_twitter_path
  end

  
  def twitter_callback
    # Handle the Twitter authentication callback
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    user.name = auth['info']['name']
    user.nickname = auth['info']['nickname']
    user.image_url = auth['info']['image']
    user.token = auth['credentials']['token']
    user.secret = auth['credentials']['secret']
    user.save

    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in with Twitter!"
  end
end



