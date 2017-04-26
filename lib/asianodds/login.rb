require 'faraday'
require 'json'
require 'digest/md5'
require 'byebug'

BASE_API_URL = "https://webapi.asianodds88.com/AsianOddsService"

module Asianodds
  class Login

    attr_reader :code, :ao_token, :ao_key, :base_url, :successful_login, :message

    # The API has a very standard request format for get requests - Use this one to stay DRY
    def get_request(route)
      response = Faraday.get "#{BASE_API_URL}/#{route}", {}, {
        'Accept': 'application/json',
        'AOToken': @ao_token,
        'AOKey': @ao_key
      }
      return JSON.parse(response.body)
    end

    # -------------------------------------------------------------------------------------
    # Initialize the user with a username and password, as well as hashed password as requested from AO
    def initialize(user, password)
      @user = user
      @password = password
      @password_md5 = Digest::MD5.hexdigest(@password)
      @ao_token = "default"
      @ao_key = "default"

      login
    end
    # -------------------------------------------------------------------------------------

    # -------------------------------------------------------------------------------------
    # Log the user in to receive a token and key
    def login
      response = get_request("Login?username=#{@user}&password=#{@password_md5}")

      @code = response["Code"]
      @ao_token = response["Result"]["Token"]
      @ao_key = response["Result"]["Key"]
      @base_url = response["Result"]["Url"]
      @successful_login = response["Result"]["SuccessfulLogin"]
      @message = response["Result"]["TextMessage"]

      # All logged in users need to be registered with a token and key
      if @successful_login
        register
      end
    end
    # -------------------------------------------------------------------------------------

    # -------------------------------------------------------------------------------------
    # With the token and key the user has to be registered
    def register
      return get_request("Register?username=#{@user}")
    end
    # -------------------------------------------------------------------------------------

    def logout
      response = get_request("Logout")
      return response["Result"]
    end

    # -------------------------------------------------------------------------------------
    # Before executing any request which requires a logged in user (all), check for login
    def loggedin?
      if @ao_token
        response = get_request("IsLoggedIn")
        return response["Result"]["CurrentlyLoggedIn"] ? true : false
      else
        return false
      end
    end
    # -------------------------------------------------------------------------------------

  # Check for all other requests whether user is logged in and if not, log her in

    # Get all the Match Feeds (odds, status, etc.)
    def getfeeds(arguments)
      arguments[:sports_type].nil? ? sports_type = 1 : sports_type = arguments[:sports_type]
      arguments[:market_type].nil? ? market_type = 1 : market_type = arguments[:market_type]
      arguments[:bookies].nil? ? bookies = "ALL" : bookies = arguments[:bookies]
      arguments[:leagues].nil? ? leagues = "ALL" : leagues = arguments[:leagues]
      arguments[:odds_format].nil? ? odds_format = "00" : odds_format = arguments[:odds_format]
      arguments[:since].nil? ? since = "0" : since = arguments[:since]

      if loggedin?
        return get_request("GetFeeds?sportsType=#{sports_type}&marketTypeId=#{market_type}&bookies=#{bookies}&leagues=#{leagues}&oddsFormat=#{odds_format}&since=#{since}")
      else
        #raise NotLoggedIn
      end
    end

    def getbets
      if loggedin?
        return get_request("GetBets")
      else
        #raise NotLoggedIn
      end
    end



  end
end
