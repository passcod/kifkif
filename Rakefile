require 'sequel'
require 'sequel/extensions/migration'

desc 'Run database migrations'
task :migrate do
  Sequel::Migrator.apply(if ENV['DATABASE_URL']
    Sequel.connect ENV['DATABASE_URL']
  else
    Sequel.connect 'sqlite://test.db'
  end, 'migrations')
end
