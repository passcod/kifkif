class Kifkif::Private < Sinatra::Base
  extend Memoist

  configure do
    use Rack::Auth::Basic do |user, pass|
      user == Kifkif.config.user && pass == Kifkif.config.pass
    end

    IO.write 'public/highlight.css', Rouge::Themes::Github.render(scope: '[class^="language-"]')
  end

  helpers do
    def highlight(source, css_class = 'language-diff', lexer = Rouge::Lexers::Diff.new)
      formatter = Rouge::Formatters::HTML.new css_class: css_class
      formatter.format(lexer.lex(source))
    end
  end

  get '/' do
    haml :diffs, locals: {diffs: Diff.all}
  end

  memoize :highlight
end
