require "pry"
require "sqlite3"
require "rack"
require "thin"
load "router.rb"

handler = Rack::Handler::Thin
handler.run(
  Router::Builder.new {
      use(Rack::Static, urls: ["/images", "/css"], root: "/assets")
      run lambda { |env| Router.new.(env)}
  }
  Port: 7373
)