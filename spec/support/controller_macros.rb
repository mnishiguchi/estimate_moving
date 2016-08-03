module ControllerMacros
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)#controller-specs

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin) # Using factory girl as an example
    end
  end

  # Use `let(:user) { subject.current_user }` to get the reference to the login user.
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in FactoryGirl.create(:user)
    end
  end
end
