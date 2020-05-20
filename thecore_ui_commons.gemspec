$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "thecore_ui_commons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "thecore_ui_commons"
  spec.version     = ThecoreUiCommons::VERSION
  spec.authors     = ["Gabriele Tassoni"]
  spec.email       = ["gabriele.tassoni@gmail.com"]
  spec.homepage    = "https://github.com/gabrieletassoni/thecore_ui_commons"
  spec.summary     = "Common artifacts for the UIs."
  spec.description = "Engine to serve configurations and rails module useful for all the UIs."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "thecore_background_jobs", "~> 2.0"
  spec.add_dependency 'serviceworker-rails',  "~> 0.5"
  spec.add_dependency 'd3-rails',  "~> 5.9"
end
