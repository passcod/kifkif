require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || 'production').to_sym

module Kifkif
  class << self
    extend Memoist

    def config
      c = Hashie::Mash.new
      ENV.each { |k,v| c[k.downcase] = v }
      return c
    end

    def db
      begin
        Sequel.connect ENV['DATABASE_URL']
      rescue
        Sequel.connect 'sqlite://test.db'
      end
    end

    def root
      __dir__
    end

    memoize :config, :db, :root
  end
end

Kifkif.db # init

require './models'
require './private'
require './public'

map '/pub' do
  run Kifkif::Public
end

run Kifkif::Private
