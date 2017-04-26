require 'faraday'
require 'json'
require 'digest/md5'

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

    def login
      response = Faraday.get("#{BASE_API_URL}/Login?username=#{@user}&password=#{@password_md5}")
      attributes = JSON.parse(response.body)

      @code = attributes["Code"]
      @ao_token = attributes["Result"]["Token"]
      @ao_key = attributes["Result"]["Key"]
      @base_url = attributes["Result"]["Url"]
      @successful_login = attributes["Result"]["SuccessfulLogin"]
      @message = attributes["Result"]["TextMessage"]
    end

  # Check for all other requests whether user is logged in and if not, log her in



  end
end
