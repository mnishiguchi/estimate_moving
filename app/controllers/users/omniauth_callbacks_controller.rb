class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Invoked after omniauth authentication is done.
  # This method can handle authentication for all the providers.
  # Alias this method as a provider name such as `twitter`, `facebook`, etc.
  def callback_for_all_providers

    # Obtain the authentication data.
    @omniauth = request.env["omniauth.auth"]

    # Ensure that the authentication data exists.
    unless @omniauth.present?
      flash[:danger] = "Authentication data was not provided"
      redirect_to root_url and return
    end

    # Obtain the provider name from the callee.
    provider = __callee__.to_s

    # Search for the user based on the authentication data.
    # Obtain a SocialProfile object that corresponds to the authentication data.
    profile = SocialProfile.find_for_oauth(@omniauth)

    # Obtain logged-in user or user with a registered profile.
    @user = User.current_user || profile.user

    # If user was not found, search by email or create a new user.
    @user ||= find_by_verified_email_or_create_new_user(@omniauth)

    associate_user_with_profile(@user, profile)

    if @user.persisted? && @user.email_verified?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      @user.reset_confirmation!
      flash[:warning] = "Please enter your email address before proceeding."
      redirect_to finish_signup_path(@user)
    end
  end

  # Alias the callback_for_all_providers method for providers.
  alias_method :facebook, :callback_for_all_providers
  alias_method :twitter,  :callback_for_all_providers

  private

    def find_by_verified_email_or_create_new_user(auth)

      # If the authentication data includes verified email, search for user.
      email = verified_email_from_oauth(auth)
      user = User.where(email: email).first if email

      unless user
        # If user has no verified email, give the user a temp email address.
        # Later, we can detect unregistered email based on TEMP_EMAIL_PREFIX.
        # Password is not required for users with social_profiles therefore
        # it is OK to generate a random password for them.
        temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{Devise.friendly_token[0,20]}.com"
        user = User.new(username: auth.extra.raw_info.name,
                        email:    email ? email : temp_email,
                        password: Devise.friendly_token[0,20] )

        # This is to postpone the delivery of confirmation email.
        user.skip_confirmation!

        # Save the temp email to database, skipping validation.
        user.save(validate: false)
        user
      end
    end

    def verified_email_from_oauth(auth)
      auth.info.email if auth.info.email && (auth.info.verified || auth.info.verified_email)
    end

    def associate_user_with_profile(user, profile)
      unless profile.user == user
        profile.update!(user_id: user.id)
      end
    end
end
