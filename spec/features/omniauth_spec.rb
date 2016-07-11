require 'rails_helper'

feature "OmniAuth interface" do
  OmniAuth.config.test_mode = true

  let(:omniauth_twitter_button) { ".omniauth-btn-twitter" }

  before { OmniAuth.config.mock_auth[:twitter] = nil }

  describe "new user or non-logged-in user who did not sign up with Twitter" do

    context "when authentication fails" do
      before do
        visit root_path
        set_invalid_omniauth
        find(omniauth_twitter_button).click
      end

      it { expect(page).to have_content('Could not authenticate you from Twitter') }
    end

    context "when authentication is successful" do
      before do
        visit root_path
        set_omniauth
        find(omniauth_twitter_button).click
      end

      it { expect(page).to have_content("Please add your email address") }

      describe "filling out the form" do

        let(:submit) { "Add email" }

        context "with temporary email" do
          before do
            find("#user_email").set "change@me.temporary.com"
            click_button(submit)
          end

          it { expect(page).to have_content("must be given") }
        end

        context "with valid information" do
          before do
            find("#user_email").set "ngjadjdgaldjg@example.com"
            click_button(submit)
          end

          it { expect(page).to have_content("confirmation email") }
        end
      end
    end
  end

  # ---
  # ---

  describe "non-logged-in user who signed up with Twitter" do
    let!(:user) do
      user = create(:user)
      attrs = attributes_for(:social_profile)
      attrs["uid"] = "mock_uid_1234567890"
      user.social_profiles.create(attrs)
      user
    end

    before do
      visit root_path
      set_omniauth
      find(omniauth_twitter_button).click
    end

    it "can log in with Twitter" do
      expect(current_path).to eq movings_path
      expect(page).to have_content("Successfully authenticated")
      expect(page).to have_link("Log out")
    end
  end

  # ---
  # ---

  xdescribe "logged-in user who is an omniauth first-timer" do
    let(:user) { create(:user) }

    before do
      login_as user
      visit root_path
      set_omniauth
    end

    it { is_expected.not_to have_css(".twitter_connected_icon") }

    it "user's twitter info is not saved in database" do
      expect(user.social_profile(:twitter)).to be_nil
    end

    context "clicking on Twitter button in Account page" do
      before do
        visit edit_user_registration_path
        find(".twitter_connected_icon").click
      end

      it { expect(page).to have_content("Successfully authenticated from Twitter account") }
      # it { expect(page).to have_content("Disconnect") }
      it "saves user's twitter info in database" do
        expect(user.social_profile(:twitter)).not_to be_nil
      end

      describe "logging out" do
        before do
          logout :user
          visit root_path
          set_omniauth
          find(omniauth_twitter_button).click
        end

        it { expect(page).to have_content("Disconnect") }

        describe "clicking on Twitter button" do
          before { find(".twitter_connected_icon").click }

          it { expect(page).to have_content("Disconnected") }
          it { expect(page).to have_content("Connect") }

          it "deletes user's twitter info from database" do
            expect(user.social_profile(:twitter)).to be_nil
          end
        end
      end
    end
  end
end
