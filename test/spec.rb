require 'minitest/autorun'
require './lib/asianodds/login'

describe "Login" do
  before do
    @user = Asianodds::Login.new("webapiuser13", "G,'{3M+U[$uwcf4+")
    p @user
    @invalid_user = Asianodds::Login.new("XXXXX", "XXXXX")
    p @invalid_user
  end

   it "A valid User returns the valid login code 0" do
     @user.code.must_equal 0
   end

    #it "An invalid User returns the invalid login code -1" do
    #  @invalid_user.code.must_equal -1
    #end

    #it "a logged in and registered user must return true for logged in" do
    #  @user.loggedin?.must_equal true
    #end

    #it "an invalid user cannot be registered and must return false for logged in" do
    #  @invalid_user.loggedin?.must_equal false
    #end

  # it "Calling GetFeeds without being logged in should raise an error" do
  #   @invalid_user.get_feeds.must_raise RuntimeError
  # end

  # it "Sending a valid GetFeeds request should return a list of feeds" do
  #   x = @user.get_feeds({})
  # end

  #it "get_bet_by_reference should return a bet result for a valid reference" do
  #  x = @user.get_bet_by_reference("WA-1493188766490")
  #  p x
  #end

  #it "calling get_sports should return a list of sports" do
  #  x = @user.get_sports
  #  p x
  #end

  # it "A valid get placement info post request returns a valid object" do
  #   x = @user.get_placement_info({
  #     game_id: -377682094,
  #     game_type: "X",
  #     is_full_time: 1,
  #     market_type: 1,
  #     odds_format: "00",
  #     odds_name: "HomeOdds",
  #     sports_type: 1
  #     })

  #   p x
  # end

  it "A valid place bet post request returns a valid object" do
    x = @user.place_bet({
      game_id: -377682094,
      game_type: "X",
      is_full_time: 1,
      market_type: 1,
      odds_format: "00",
      odds_name: "HomeOdds",
      sports_type: 1,
      amount: 50,
      bookie_odds: "PIN: 2.57,PIN: 3.06,PIN: 3.23"
      })

    p x
  end
end




























