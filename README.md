# :soccer: Asianodds - Automated Sports Trading

[![Gem Version](https://badge.fury.io/rb/asianodds.svg)](https://badge.fury.io/rb/asianodds) [![Code Climate](https://codeclimate.com/github/Jan17392/asianodds/badges/gpa.svg)](https://codeclimate.com/github/Jan17392/asianodds)

This gem is a wrapper for the Asianodds Web API.
In order to use this gem you need to apply for a Web API account with Asianodds (api@asianodds88.com). Please keep in mind that your regular Asianodds user (for the Web Interface) does not work for your API account and vice versa.

The purpose of the gem is to pre-configure all API calls to make your life as easy as just calling one method. You won't need to MD5 hash your password (as Asianodds requests) and the gem assumes smart pre-configs for your calls, so they will work even without passing in required parameters. Still, it has the same flexibility as the original API without limitations.

With just three lines of code you will be able to start placing real-time bets with multiple bookmakers and automate your trading strategies.

For any bugs, ideas or feature requests don't hesitate to open an issue.

*Disclaimer: This gem is not officially developed by Asianodds and does not belong in any way to the Asianodds service, nor is it supported by their development team and all rights to accept or deny bets made with this gem remain with Asianodds.*


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

All returned objects from the gem are in the form of Ruby Hashes (or plain booleans if specified) with all Keys converted to Symbols.



### Login

Create a new user instance and provide your username and raw password (not hashed):

```ruby
asianodds = Asianodds::Login.new('dagobert_duck', 'secure_password')
#
```
The returned response / initiated user will contain the following keys:

|Key|Value|Description|
|---|-----|-----------|
|@user|dagobert_duck|This is your username|
|@password|secure_password|This is your password|
|@password_md5|hashed MD5 password|The password actually used to login|
|@ao_token|random string ('2220749911057835565404619834') or ('')|Token passed to execute all methods|
|@ao_key|random string ('3c81574f865d1d892d52d7cbc78a18dd') or (nil)|Key used once to register - only valid for 60s|
|@base_url|https://webapi.asianodds88.com/AsianOddsService|Used url base to access the Asianodds service|
|@code|0 or -1|Indicator whether current action was successful: 0 = true, -1 = false|
|@successful_login|boolean|Shows whether user is logged in successfully|
|@message|string ('Successfully Registered.')|Verbose description of the current user status|


### Register

With the instantiation of the login call, you will automatically get registered to the app. There is no need to call the register method separately. The registration message can be read from the current users @message.


### Login Check

You can check whether you are logged in to the service with the isloggedin? method. It returns either true if logged in or false if not.

```ruby
asianodds.isloggedin?
# returns true or false
```

This method is automatically called on each subsequent method to ensure you will be re-registered in case you are not logged in anymore. No need to manually check the logged in status.



### Logout

After finishing all transactions and business logic, it is wise to logout and unregister (happens automatically after 30 min of inactivity) with the logout method

```ruby
asianodds.logout
# { Code: -1, Message: null, Result: "Failed Logout. Have you logged in before ?" }
```
|Key|Value|Description|
|---|-----|-----------|
|@code|0 or -1|Indicator whether current action was successful: 0 = true, -1 = false|
|@message|-|Can be omitted|
|@result|string ('Failed Logout. Have you logged in before ?')|Verbose description of the action result|


### Get Match Feeds

The get_feeds method returns all matches with their respective feed information, (such as running minute, home team, away team etc.) filtered by optional parameters. Parameters have to communicated via a hash. Accepted parameters are:

|Key|Value|Description|
|---|-----|-----------|
|sports_type|see get_sports|Which sports to show (default 1 - football)|
|market_type|0 - Live, 1 - Today, 2 - Early|What betting market to receive (default 1 - Today)|
|bookies|see get_bookies|From which bookies to show odds (default ALL)|
|leagues|see get_leagues|From which leagues to receive matches (default ALL)|
|odds_format|MY - Malaysian, 00 - European, HK - Hong Kong|What oddsformat to show (default 00 - European)|
|since|tbd|Show only match feeds since the timestamp (default none)|

```ruby
asianodds.get_feeds({ sports_type: 1, market_type: 1, bookies: "ALL", leagues: "ALL", odds_format: "00" })
# Works as well and returns the same result (due to auto-filters):
asianodds.get_feeds({})

=begin
Response:
{
  Code: 0,
  Message: "",
  Result: {
    Since: 1493301694214,
    Sports: [
      {
        MatchGames: [
          {
            AwayTeam: {
              Name: "Qaradag Lokbatan",
              RedCards: 0,
              Score: 1
            },
            ExpectedLength: 45,
            Favoured: 1,
            FullTimeHdp: {
              BookieOdds: "IBC=0.530,-0.730;BEST=IBC 0.530,IBC -0.730",
              Handicap: "0.0"
            },
            FullTimeOneXTwo: {
              BookieOdds: ""
            },
            FullTimeOu: {
              BookieOdds: "IBC=-0.310,0.090;BEST=IBC -0.310,IBC 0.090",
              Goal: "3.5"
            },
            GameId: -1895622898,
            HalfTimeHdp: {
              BookieOdds: "",
              Handicap: ""
            },
            HalfTimeOneXTwo: {
              BookieOdds: ""
            },
            HalfTimeOu: {
              BookieOdds: "",
              Goal: ""
            },
            HomeTeam: {
              Name: "PFC Turan Tovuz",
              RedCards: 0,
              Score: 2
            },
            InGameMinutes: 168,
            IsActive: false,
            IsLive: 1,
            LeagueId: 922171774,
            LeagueName: "AZERBAIJAN DIVISION 1",
            MarketType: "Live",
            MarketTypeId: 0,
            MatchId: -1898629925,
            StartTime: 1493294400000,
            StartsOn: "04/27/2017 12:00:00.000 PM",
            ToBeRemovedOn: 1493301984351,
            UpdatedDateTime: 1493301684351,
            WillBeRemoved: true
          }
        ],
        SportsType: 1
      }
    ]
  }
}
=end
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

Getting the account summary of the current user helps to see the current credit, currency and P&L. No additional parameters need to be passed in if logged in.

```ruby
asianodds.get_account_summary

=begin
{
  Code: 0,
  Message: null,
  Result: {
    Credit: 344.69,
    CreditCurrency: 'EUR',
    Message: 'Showing Account Summary for User WEBAPIUSER13',
    Outstanding: 0,
    OutstandingCurrency: 'EUR',
    TodayPnL: 0,
    TodayPnLCurrency: 'EUR',
    YesterdayPnL: 44.69,
    YesterdayPnLCurrency: 'EUR'
  }
}
=end
```


### Get History Statement

```ruby
asianodds.get_history_statement
```


### Get Bookies

This method returns all bookies offered on the Asianodds books with their name and shortname/id. In all other methods a bookie is only referenced by its shortname (such as IBC).

```ruby
asianodds.get_bookies
# { Code: 0, Data: [{ Id: IBC, IsFeedAvailable: true, Name: "IBCBET"}, {...}], Message: "" }
```


### Get Leagues

The get_leagues method returns all leagues offered on the Asianodds books, including the corresponding sports_type as well as an array of bookies offering bets in this league.

```ruby
asianodds.get_leagues

=begin
{
  Code: 0,
  Message: "",
  Result: {
    Sports: [
      {
        League: [
          {
            Bookies: [
              "IBC",
              "PIN",
              "ISN",
              "SIN",
              "SBO"
            ],
            LeagueId: 350374160,
            LeagueName: "EGYPT PREMIER LEAGUE",
            MarketTypeId: 0,
            Since: 1493305406042
          }
        ],
        SportsType: 1
      }
    ]
  }
}
=end
```


### Get Sports

This method returns all the sports offered on the Asianodds books. Currently Football (Soccer) and Basketball are offered. All sports are stored as hashes in the data array.

```ruby
asianodds.get_sports
# { Code: 0, Data: [{ Id: 1, Name: "Football" }, { Id: 2, Name: "Basketball" }], Message: "" }
```


### Get User Information

```ruby
asianodds.get_user_information

=begin
{
  Code: 0,
  Message: "",
  Result: {
    ActiveBookies: [
      "IBC",
      "SBO",
      "SIN",
      "ISN",
      "PIN",
      "GA"
    ],
    BaseCurrency: null,
    CreationDate: 1472636844000,
    DefaultStake: 0,
    ExpiryDate: 4102444800000,
    ExternalIp: "88.72.3.57",
    OddsType: "MY",
    Status: "Active",
    UserId: "WEBAPIUSER13"
  }
}
=end
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
