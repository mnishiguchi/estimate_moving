# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)#controller-specs
module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryGirl.create(:admin) # Using factory girl as an example
  #   end
  # end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end

# http://willschenk.com/setting-up-testing
def login_with(user = double('user'), scope = :user)
  current_user = "current_#{scope}".to_sym
  if user.nil?
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => scope})
    allow(controller).to receive(current_user).and_return(nil)
  else
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(current_user).and_return(user)
  end
end
