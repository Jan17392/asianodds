# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asianodds/version"

Gem::Specification.new do |spec|
  spec.name          = "asianodds"
  spec.version       = Asianodds::VERSION
  spec.authors       = ["Jan Runo"]
  spec.email         = ["jan.runo@whu.edu"]

  spec.summary       = %q{A wrapper for the Asianodds web API for automated sports trading}
  spec.description   = %q{Asianodds Disclaimer: This gem is not officially developed by Asianodds and does not belong in any way to the Asianodds service, nor is it supported by their development team and all rights to accept or deny bets made with this gem remain with Asianodds.
    This gem is a wrapper for the Asianodds Web API. In order to use this gem you need to apply for a Web API account with Asianodds (api@asianodds88.com). Please keep in mind that your regular Asianodds user (for the Web Interface) does not work for your API account and vice versa.
    The purpose of the gem is to preconfigure all API calls to make your life as easy as just calling one method. You won"t need to MD5 hash your password (as Asianodds requests) and the gem assumes smart preconfigs for your calls, so they will work even without passing in required parameters. Still, it has the same flexibility as the original API without limitations.
    With just three lines of code you will be able to start placing real-time bets with multiple bookmakers and automate your trading strategies.
    For more information on the usage of the gem, please visit the github page
  }
  spec.homepage      = "https://github.com/Jan17392/asianodds"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
