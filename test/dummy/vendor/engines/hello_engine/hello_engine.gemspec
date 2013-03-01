# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hello_engine"
  s.version     = "0.0.1" #HelloEngine::VERSION
  s.authors     = ["Chuck Norris"]
  s.email       = ["chuck@norris.com"]
  s.homepage    = ""
  s.summary     = "Hello World Engine"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"
end
