# Asianodds

This gem is a wrapper for the Asianodds Web API.
In order to use this gem you need to apply for a Web API account with Asianodds (api@asianodds88.com). Please keep in mind that your regular Asianodds user (for the Web Interface) does not work for your API account and vice versa.

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

1. Login

Create a new User instance and provide your username and raw (not hashed) password:

    $ user = Asianodds::Login.new(<user>, <password>)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/asianodds.

