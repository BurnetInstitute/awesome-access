$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "awesome-access/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "awesome-access"
  s.version     = AwesomeAccess::VERSION
  s.authors     = ["Dyson Simmons"]
  s.email       = ["dysonsimmons@gmail.com"]
  s.homepage    = "http://www.dysonsimmons.com"
  s.summary     = "Basic authorisation, access control and roles."
  s.description = "Uses has_secure_password, ActiveRecord and twitter bootstrap."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0.rc1"
end
