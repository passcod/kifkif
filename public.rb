require 'time'

class Kifkif::Public < Sinatra::Base
  configure do
    enable :cross_origin
  end

  post '/diff' do
    request.body.rewind
    contents = request.body.read
    content_type 'text/plain'

    halt 400, 'Empty request' if contents.nil? or contents == ''

    begin
      diff = UnifiedDiff.parse contents
      row = Diff.new
      row.status = 'new'
      row.date_received = DateTime.now
      row.contents = contents

      halt 400, 'Need original filename' if diff.original_file.nil?
      row.filename = diff.original_file

      if row.save
        [200, 'Got it']
      else
        ['500', 'DB error']
      end
    rescue UnifiedDiff::Diff::UnifiedDiffException
      [400, 'Not a diff']
    end
  end
end
