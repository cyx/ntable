
Gem::Specification.new do |s|
  s.name = 'ohm'
  s.version = 0.0.1
  s.summary = %{Nestable Table for configuration}
  s.date = %q{2010-09-13}
  s.author = "Cyril David"
  s.email = "cyx.ucron@gmail.com"
  s.homepage = "http://github.com/cyx/ntable"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/ntable/compat-1.8.6.rb", "lib/ntable.rb", "LICENSE", "Rakefile", "test/helper.rb", "test/ntable_test.rb"]

  s.require_paths = ['lib']

  s.has_rdoc = false
end

