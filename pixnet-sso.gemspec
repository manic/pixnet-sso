# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pixnet-sso"
  s.version     = "0.0.4"
  s.authors     = ["Manic Chuang"]
  s.email       = ["manic@pixnet.tw"]
  s.homepage    = "https://github.com/manic/pixnet-sso"
  s.summary     = "Client for PIXNET SSO"
  s.description = "Client for PIXNET SSO"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.0.0"
  s.add_dependency "uuid"
  s.add_dependency "json"

end
