require './test/test_helper'

USER = "webapiuser13"
PASSWORD = "G,'{3M+U[$uwcf4+"

class AsianoddsLoginTest < Minitest::Test
  def test_exists
    assert Asianodds::Login
  end


  # Check that the fields are accessible and the login was successful
  def test_login
      login = Asianodds::Login.new(USER, PASSWORD)
      if login.successful_login
        p "juhu"
      else
        p "fucking errors"
      end
      assert_equal Asianodds::Login, login.class
      assert_equal 0, login.code
  end
end
