module FeatureMacros

  def login_as(user)
    visit new_user_session_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Log in"
    user
  end
end
