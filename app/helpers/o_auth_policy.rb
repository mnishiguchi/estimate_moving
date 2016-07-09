module OAuthPolicy
  class Base
    # attr_reader :provider, :uid, :name, :nickname, :email, :url, :image_url,
    #             :description, :others, :credentials, :raw_info
    def params
      {
        uid:         @uid,
        name:        @name,
        nickname:    @nickname,
        email:       @email,
        url:         @url,
        image_url:   @image_url,
        description: @description,
        credentials: @credentials,
        raw_info:    @raw_info
      }
    end
  end

  class Twitter < OAuthPolicy::Base
    def initialize(auth)
      @provider    = auth["provider"]
      @uid         = auth["uid"]
      @name        = auth["info"]["name"]
      @nickname    = auth["info"]["nickname"]
      @email       = ""
      @url         = auth["info"]["urls"]["Twitter"]
      @image_url   = auth["info"]["image"]
      @description = auth["info"]["description"].try(:truncate, 255)
      @credentials = auth["credentials"].to_json
      @raw_info    = auth["extra"]["raw_info"].to_json
      freeze
    end
  end

  class Facebook < OAuthPolicy::Base
    def initialize(auth)
      @provider    = auth["provider"]
      @uid         = auth["uid"]
      @name        = auth["info"]["name"]
      @nickname    = ""
      @email       = ""
      @url         = "https://www.facebook.com/"
      @image_url   = auth["info"]["image"]
      @description = ""
      @credentials = auth["credentials"].to_json
      @raw_info    = auth["extra"]["raw_info"].to_json
      freeze
    end
  end
end
