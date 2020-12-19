# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  before_action :reject_user, only: [:create]

  protected
  
  def reject_user
    if params[:user]
      @user = User.find_by(name: params[:user][:name])
      if @user
        if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
          flash[:alert] = "BANされたユーザーです"
          redirect_to new_user_session_path
        end
      else
        flash[:alert] = "必須項目を入力して下さい"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
