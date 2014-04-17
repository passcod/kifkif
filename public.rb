require 'time'

class Kifkif::Public < Sinatra::Base
  configure do
    enable :cross_origin
  end

  helpers do
    def phalt(*args)
      puts *args
      halt *args
    end
  end

  post '/diff' do
    request.body.rewind
    contents = request.body.read
    content_type 'text/plain'

    phalt 400, 'Empty request' if contents.nil? or contents == ''
    
    lines = contents.split "\n"
    until lines[0] =~ /^---/
      break if lines.shift.nil?
    end
    
    phalt 400, 'Not a diff' if lines.length == 0
    contents = lines.join "\n"

    begin
      diff = UnifiedDiff.parse contents
      row = Diff.new
      row.status = 'new'
      row.date_received = DateTime.now
      row.contents = contents

      phalt 400, 'Need original filename' if diff.original_file.nil?
      row.filename = diff.original_file

      if row.save
        [200, 'Got it']
      else
        phalt 500, 'DB error'
      end
    rescue UnifiedDiff::Diff::UnifiedDiffException
      phalt 400, 'Not a diff'
    end
  end
end
