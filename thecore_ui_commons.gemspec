$:.push File.expand_path("lib", __dir__)

require_relative "lib/thecore_ui_commons/version"

Gem::Specification.new do |spec|
  spec.name        = "thecore_ui_commons"
  spec.version     = ThecoreUiCommons::VERSION
  spec.authors     = ["Gabriele Tassoni"]
  spec.email       = ["g.tassoni@bancolini.com"]
  spec.homepage    = "https://github.com/gabrieletassoni/thecore_ui_commons"
  spec.summary     = "Common artifacts for the UIs."
  spec.description = "Engine to serve configurations and rails module useful for all the UIs."
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gabrieletassoni/thecore_ui_commons"
  spec.metadata["changelog_uri"] = "https://github.com/gabrieletassoni/thecore_ui_commons/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "thecore_backend_commons", "~> 3.0"
  spec.add_dependency "haml", "~> 6.0"
  spec.add_dependency "haml-rails", "~> 2.1"
  spec.add_dependency "serviceworker-rails", "~> 0.6"
  spec.add_dependency "groupdate", "~> 6.0"
  spec.add_dependency "apexcharts", "~> 0.2"
end
