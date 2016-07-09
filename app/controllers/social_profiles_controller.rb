class SocialProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!

  def destroy
    @profile.destroy
    flash[:success] = "Disconnected from #{@profile.provider.capitalize}"
    redirect_to root_url
  end

  private

    def correct_user!
      @profile = SocialProfile.find(params[:id])
      unless @profile.user_id == current_user.id
        redirect_to root_url and return
      end
    end
end
