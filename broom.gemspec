Gem::Specification.new do |gem|
  gem.name              = "broom"
  gem.version           = "0.0.1"
  gem.platform          = Gem::Platform::RUBY
  gem.authors           = ["Simon Le Parc"]
  gem.email             = ["lpl.simon@gmail.com"]
  gem.homepage          = "http://github.com/sleparc/broom"
  gem.summary           = "Broom makes your app styles cleaner"
  gem.rubyforge_project = gem.name
  gem.require_path      = 'lib'
  gem.files             = `git ls-files`.split("\n")
end

