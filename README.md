# Asianodds

[![Code Climate](https://codeclimate.com/github/Jan17392/asianodds/badges/gpa.svg)](https://codeclimate.com/github/Jan17392/asianodds)

Disclaimer: This gem is not officially developed by Asianodds and does not belong in any way to the Asianodds service, nor is it supported by their development team and all rights to accept or deny bets made with this gem remain with Asianodds.

This gem is a wrapper for the Asianodds Web API.
In order to use this gem you need to apply for a Web API account with Asianodds (api@asianodds88.com). Please keep in mind that your regular Asianodds user (for the Web Interface) does not work for your API account and vice versa.

The purpose of the gem is to pre-configure all API calls to make your life as easy as just calling one method. You won't need to MD5 hash your password (as Asianodds requests) and the gem assumes smart pre-configs for your calls, so they will work even without passing in required parameters. Still, it has the same flexibility as the original API without limitations.

With just three lines of code you will be able to start placing real-time bets with multiple bookmakers and automate your trading strategies.

For any bugs, ideas or feature requests don't hesitate to open an issue.


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

All returned objects from the gem are in the form of JSON (XML is not yet supported by the Gem).



### Login

Create a new user instance and provide your username and raw password (not hashed):

```ruby
asianodds = Asianodds::Login.new('dagobert_duck', 'fort_knox')
```


### Register

With the instantiation of the login call, you will automatically get registered to the app. There is no need to call the register method separately.


### Login Check

You can check whether you are logged in to the service with the isloggedin? method

```ruby
asianodds.isloggedin?
# returns true or false
```

This method is automatically called on each subsequent method to ensure you will be re-registered in case you are not logged in anymore. No need to manually check the logged in status.



### Logout

After finishing all transactions and business logic, it is wise to logout and unregister (happens automatically after 30 min of inactivity) with the logout method

```ruby
asianodds.logout
# returns true or false
```


### Get Bets

With the get_bets method all (max. 150) outstanding bets of the instantiated user are retrieved

```ruby
asianodds.get_bets
```


### Get a Single Bet by its Reference

This method is very useful and should be used to validate that a bet has been accepted by the bookmaker after the place_bet method. It can be called with a single parameter which is provided by the place_bet method

```ruby
asianodds.get_bet_by_reference("WA-1493188766490")
```


### Get Running Bets

This is a subset of the get_bets method which returns only the currently running bets

```ruby
asianodds.get_running_bets
```


### Get Non-Running Bets

This is a subset of the get_bets method which returns only the currently not running bets

```ruby
asianodds.get_non_running_bets
```


### Get Account Summary

```ruby
asianodds.get_account_summary
```


### Get History Statement

```ruby
asianodds.get_history_statement
```


### Get Bookies

```ruby
asianodds.get_bookies
```


### Get Leagues

```ruby
asianodds.get_leagues
```


### Get Sports

```ruby
asianodds.get_sports
```


### Get User Information

```ruby
asianodds.get_user_information
```


### Get Bet History Summary

```ruby
asianodds.get_bet_history_summary
```


### Get Matches

```ruby
asianodds.get_matches
```


### Get Placement Info

```ruby
asianodds.get_placement_info
```


### Place a New Bet

```ruby
asianodds.place_bet
```


## Original API Documentation

For more information on the original API, please refer to the full documentation: https://asianodds88.com/documentation/


## Examples

Please get in contact to showcase your examples here.


## TODOS

- [ ] Develop logic to re-signin automatically if logout is discovered
- [ ] Add XML support (anyone still using XML if JSON available?!)
- [ ] Write proper mini-tests to ensure test coverage & error-handling
- [ ] Enable custom IDs for easier get_bet_by_reference lookup
- [ ] Improving get_feeds response to format odds and providers nicely (currently string)
- [ ] Improve the get and place bet workflow
- [ ] Enable full date hand-overs for the "since" parameter and convert into milliseconds
- [x] Wait for more feature requests


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Jan17392/asianodds.


## Copyright

MIT License

Copyright (c) 2017 Jan Runo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
