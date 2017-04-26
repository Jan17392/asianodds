require 'faraday'
require 'json'
require 'digest/md5'
require 'byebug'

BASE_API_URL = "https://webapi.asianodds88.com/AsianOddsService"

module Asianodds
  class Login

    attr_reader :code, :ao_token, :ao_key, :base_url, :successful_login, :message

    # Initialize the user with a username and password
    def initialize(user, password)
      @user = user
      @password = password

      # Asianodds requests the password to be MD5 hashed
      @password_md5 = Digest::MD5.hexdigest(@password)


      self.login
    end

    # Log the user in to receive a token and key
    def login
      response = Faraday.get("#{BASE_API_URL}/Login?username=#{@user}&password=#{@password_md5}")
      attributes = JSON.parse(response.body)

      @code = attributes["Code"]
      @ao_token = attributes["Result"]["Token"]
      @ao_key = attributes["Result"]["Key"]
      @base_url = attributes["Result"]["Url"]
      @successful_login = attributes["Result"]["SuccessfulLogin"]
      @message = attributes["Result"]["TextMessage"]

      # All logged in users need to be registered with a token and key
      register
    end

    # With the token and key the user has to be registered
    def register
      response = Faraday.get "#{BASE_API_URL}/Register?username=#{@user}", {}, {
        'Accept': 'application/json',
        'AOToken': @ao_token,
        'AOKey': @ao_key
      }

      p response

    end

    # Before executing any request which requires a logged in user (all), check for login
    def loggedin?
      response = Faraday.get "#{BASE_API_URL}/IsLoggedIn", {}, {'Accept': 'application/json', 'AOToken': @ao_token}

      #p response
      p response
    end


  # Check for all other requests whether user is logged in and if not, log her in



  end
end
