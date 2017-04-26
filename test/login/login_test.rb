require './test/test_helper'

USER = "webapiuser13"
PASSWORD = "G,'{3M+U[$uwcf4+"

class AsianoddsLoginTest < Minitest::Test
  def test_exists
    assert Asianodds::Login
  end


  # Check that the fields are accessible and the login was successful
  def test_login
      user = Asianodds::Login.new(USER, PASSWORD)

      assert_equal Asianodds::Login, user.class
      assert_equal 0, user.code


      x = user.loggedin?
      p "----------------- #{x} -------------------"
  end

  # TODO: Write a test to check that user is logged in and registered if no error occurs

  # TODO: Check the current budget method to return the right value

  # TODO: Check that running bets return the right length of running bets

  # TODO: Place bet should successfully register a new bet with the system
end
