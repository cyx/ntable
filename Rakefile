require 'cutest'

task :default => :test

task :test do
  $:.unshift('./test')

  Cutest.run(Dir['test/*_test.rb'])
end
