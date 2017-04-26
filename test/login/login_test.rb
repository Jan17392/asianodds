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
      if user.successful_login
        p "juhu"
        p user
      else
        p "fucking errors"
      end
      assert_equal Asianodds::Login, user.class
      assert_equal 0, user.code


      user.loggedin?
  end
end
