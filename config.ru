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

    def root
      __dir__
    end

    memoize :config, :root
  end
end

require './web'
run Kifkif::Web
