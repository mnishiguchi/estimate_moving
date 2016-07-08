# no_capybara: true\false
def log_in_as(user, options={})
  # For controller specs
  if options[:no_capybara]
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  # For feature specs
  else
    visit new_user_session_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Log in"
  end
  user
end

# ==> RSpec custom matchers

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end
