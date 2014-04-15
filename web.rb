class Kifkif::Web < Sinatra::Base
  get '/' do
    "Hello!"
  end

  post '/diff' do
    request.body.rewind
    puts request.body.read
  end
end
