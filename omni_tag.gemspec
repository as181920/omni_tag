$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "omni_tag/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omni_tag"
  s.version     = OmniTag::VERSION
  s.authors     = ["Andersen Fan"]
  s.email       = ["as181920@gmail.com"]
  s.homepage    = ""
  s.summary     = "Common tagging for rails, with context support"
  s.description = "Simple tag support with context, no overkill abstractions"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 6.0.2"

  s.add_development_dependency "sqlite3"
end
