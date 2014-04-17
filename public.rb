require 'time'

class Kifkif::Public < Sinatra::Base
  configure do
    enable :cross_origin
  end

  post '/diff' do
    request.body.rewind
    contents = request.body.read
    content_type 'text/plain'
    begin
      diff = UnifiedDiff.parse contents
      if Diff.create do |d|
        d.filename = diff.original_file
        d.contents = contents
        d.date_received = DateTime.now
        d.status = 'new'
      end
        [200, 'Got it']
      else
        ['500', 'DB error']
      end
    rescue UnifiedDiff::Diff::UnifiedDiffException
      [400, 'Not a diff']
    end
  end
end
