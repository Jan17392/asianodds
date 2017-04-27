require 'minitest/autorun'
require './lib/asianodds/login'

describe "Login" do
  before do
    @user = Asianodds::Login.new("webapiuser13", "G,'{3M+U[$uwcf4+")
    @invalid_user = Asianodds::Login.new("XXXXX", "XXXXX")
  end

   it "A valid User returns the valid login code 0" do
     @user.code.must_equal 0
   end

   # it "An invalid User returns the invalid login code -1" do
   #   @invalid_user.code.must_equal -1
   # end

   # it "a logged in and registered user must return true for logged in" do
   #   @user.loggedin?.must_equal true
   # end

   # it "an invalid user cannot be registered and must return false for logged in" do
   #   @invalid_user.loggedin?.must_equal false
   # end

  # it "Calling GetFeeds without being logged in should raise an error" do
  #   @invalid_user.get_feeds.must_raise RuntimeError
  # end

  # it "Sending a valid GetFeeds request should return a list of feeds" do
  #   x = @user.get_feeds({})
  # end

  it "get_bet_by_reference should return a bet result for a valid reference" do
    x = @user.get_bet_by_reference("WA-1493188766490")
    p x
  end
end
