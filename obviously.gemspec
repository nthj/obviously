Gem::Specification.new do |s|
  s.name        = "obviously"
  s.version     = "0.2.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nathaniel Jones"]
  s.email       = ["nj@third.io", ""]
  s.homepage    = "http://github.com/nthj/obviously"
  s.summary     = "Guess obvious association class names in ActiveRecord."
  s.description = "Makes using namespaced model names, like Project::Discussion, much less painful. No more `class_name: 'Project::Discussion'` options required."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "obviously"

  s.add_dependency("activerecord", ">= 4")
  s.add_development_dependency("sqlite3", ">= 0")
  s.add_development_dependency("rspec", ">= 2.0.0")

  s.files        = Dir.glob("{lib}/**/*") + %w(README.md LICENSE.txt)
  s.require_path = 'lib'
end
