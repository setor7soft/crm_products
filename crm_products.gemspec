$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crm_products/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crm_products"
  s.version     = CrmProducts::VERSION
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
end
