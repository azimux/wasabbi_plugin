$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wasabbi_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wasabbi_plugin"
  s.version     = WasabbiPlugin::VERSION
  s.authors     = ['azimux']
  s.email       = ['azimux@gmail.com']
  s.homepage    = 'http://github.com/azimux/wasabbi_plugin'
  s.summary     = 'BB style forum integration'
  s.description = 'BB style forum integration'

  s.files = Dir["{app,config,db,lib,public,themes}/**/*"] + ["MIT_LICENSE.txt", "Rakefile", "README"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  # s.add_development_dependency "sqlite3"
end
