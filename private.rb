class Kifkif::Private < Sinatra::Base
  configure do
    use Rack::Auth::Basic do |user, pass|
      user == Kifkif.config.user && pass == Kifkif.config.pass
    end
  end

  get '/' do
    "Hello!"
  end
end
