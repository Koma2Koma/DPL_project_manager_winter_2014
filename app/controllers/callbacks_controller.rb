class CallbacksController < ApplicationController

  def github_callback
    user = User.find_by(github_state: params[:state]) if params[:state]
    redirect_to root_path, notice: 'Invalid flow. Something is not right' unless user
    access_token = Apis::Github.get_access_token(user, params[:code])
    redirect_to root_path, notice: 'Invalid flow. Something is not right, could not get access token' unless access_token
    user.authorized_for_github!(access_token)
    user.update_attribute(:github_username, Apis::Github.get_user_information(user))
    redirect_to user_path(user)
  end
end