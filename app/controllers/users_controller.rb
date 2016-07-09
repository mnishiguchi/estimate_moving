class UsersController < ApplicationController
  before_action :authenticate_user!, except: :finish_signup

  # GET   /users/:id/finish_signup - Add email form
  # PATCH /users/:id/finish_signup - Update user data based on the form
  def finish_signup
    @user = User.find(params[:id])
    if request.patch? && @user.update(user_params)
      @user.send_confirmation_instructions unless @user.confirmed?
      flash[:info] = 'We sent you a confirmation email. Please find a confirmation link.'
      redirect_to root_url
    end
  end

  private

    def user_params
      accessible = [ :username, :email ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
