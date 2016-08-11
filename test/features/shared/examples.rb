require "rails_helper"
require "features/shared/contexts"

shared_examples "non-logged-in user" do
  subject { page }

  scenario "user needs to log in" do
    is_expected.to have_title(full_title(""))
    is_expected.to have_content("Log in")
    is_expected.to have_link("Home", href: root_path)
    is_expected.to have_link("About", href: about_path)
    is_expected.to have_link("Sign up", href: new_user_registration_path)
    is_expected.to have_link("Log in", href: new_user_session_path)
    is_expected.to have_selector('footer')
  end
end
