Gem::Specification.new do |s|
  s.name = 'ohm'
  s.version = '0.0.4'
  s.summary = %{Object-hash mapping library for Redis.}
  s.date = %q{2009-03-13}
  s.author = "Michel Martens, Damian Janowski"
  s.email = "michel@soveran.com"
  s.homepage = "http://github.com/soveran/ohm"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/ntable/compat-1.8.6.rb", "lib/ntable.rb", "Rakefile", "test/helper.rb", "test/ntable_test.rb"]

  s.require_paths = ['lib']

  s.has_rdoc = false
end
