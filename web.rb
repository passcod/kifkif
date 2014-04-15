class Kifkif::Web < Sinatra::Base
  get '/' do
    "Hello!"
  end

  post '/diff' do
    cross_origin allow_methods: [:get]
    request.body.rewind
    puts request.body.read
  end
end
