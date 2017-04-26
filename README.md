# Asianodds

This gem is not officially developed by Asianodds and does not belong in any way to the Asianodds service, nor is it supported by their development team and all rights to accept or deny bets made with this gem remain with Asianodds.

This gem is a wrapper for the Asianodds Web API.
In order to use this gem you need to apply for a Web API account with Asianodds (api@asianodds88.com). Please keep in mind that your regular Asianodds user (for the Web Interface) does not work for your API account and vice versa.

The purpose of the gem is to preconfigure all API calls to make your life as easy as just calling one method. You won't need to MD5 hash your password (as Asianodds requests) and the gem assumes smart preconfigs for your calls, so they will work even without passing in required parameters.

With just three lines of code you will be able to start placing real-time bets with multiple bookmakers and automate your trading strategies.

For any bugs, ideas or feature requests don't hesitate to open an issue.

For more information on the original API, please refer to the full documentation: https://asianodds88.com/documentation/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'asianodds'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install asianodds

## Usage

### Login

Create a new User instance and provide your username and raw (not hashed) password:

```ruby
user = Asianodds::Login.new(<user>, <password>)
```

### Registering


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/asianodds.

