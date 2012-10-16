# require File.dirname(__FILE__) + '/lib/broom'

task :default => :test

task :environment do
  require File.dirname(__FILE__) + '/lib/broom'
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
