class Kifkif::Web < Sinatra::Base
  configure do
    enable :cross_origin
  end

  get '/' do
    "Hello!"
  end

  post '/diff' do
    request.body.rewind
    puts request.body.read
  end
end
