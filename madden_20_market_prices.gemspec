
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "madden_20_market_prices/version"

Gem::Specification.new do |spec|
  spec.name          = "madden_20_market_prices"
  spec.version       = Madden20MarketPrices::VERSION
  spec.authors       = ["stuart-hahn"]
  spec.email         = ["stuart.a.hahn@gmail.com"]

  spec.summary       = "This gem gets current Madden Ultimate Team item prices from muthead.com"
  spec.homepage      = "https://github.com/stuart-hahn/madden-20-market-cli-gem"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   << "madden_20_market_prices"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
end
