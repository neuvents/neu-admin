$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "neu/admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "neu-admin"
  s.version     = Neu::Admin::VERSION
  s.authors     = ["Vestimir Markov"]
  s.email       = ["me@vestimir.com"]
  s.homepage    = "http://github.com/neuevents/neu-admin"
  s.summary     = "Administration tools for Neuevents"
  s.description = "Administration tools for Neuevents"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "web-console"
end
