$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hot_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hot_engine"
  s.version     = HotEngine::VERSION
  s.authors     = ["Roger Leite"]
  s.email       = ["roger.barreto@gmail.com"]
  s.homepage    = "https://github.com/rogerleite/hot_engine"
  s.summary     = "A Rails engine to install, start or stop another engines on the fly"
  s.description = "Hot Engine is a rails engine that allow to install another rails engine on the fly."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["WTFPL-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
end
