class ApisController < Devise::OmniauthCallbacksController

  def github_callback
    user = User.find_by(github_state: params[:state]) if params[:state]
    redirect_to root_path, notice: 'Invalid flow. Something is not right' unless user
    access_token = Apis::Github.get_access_token(user, params[:code])
    redirect_to root_path, notice: 'Invalid flow. Something is not right, could not get access token' unless access_token
    user.authorized_for_github!(access_token)
    user.update_attribute(:github_username, Apis::Github.get_user_information(user))
    redirect_to user_path(user)
  end

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end 

end
