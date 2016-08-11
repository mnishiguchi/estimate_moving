require 'rails_helper'

RSpec.feature "Authentications", type: :feature do

  it "requires the user to log in before creating a moving" do
    password = "123456789"
    user = create( :user, password: password,
                          password_confirmation: password )

    visit new_moving_path

    # Log in.
    within "#new_user" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: password
    end

    click_button "Log in"

    # Create a new moving.
    within "#new_moving" do
      fill_in "Name", with: "Moving to Nagoya"
    end

    click_link_or_button "Create"

    # Moving count increments.
    expect( Moving.count ).to eq(1)
    expect( Moving.first.name).to eq("Moving to Nagoya")
  end

  it "allows logged in user to create a new moving" do
     login_as create( :user ), scope: :user

     visit new_moving_path
     # puts page.body

     within "#new_moving" do
       fill_in "Name", with: "Moving to downtown"
     end

     click_link_or_button "Create moving"

     expect( Moving.count ).to eq(1)
     expect( Moving.first.name).to eq("Moving to downtown")
   end
end
