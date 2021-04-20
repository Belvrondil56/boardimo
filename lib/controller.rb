require "pry"
require "nokogiri"
require "open-uri"
require "tilt"
require "erb"
require "json"
require "sqlite3"
require ".lib/maison"
require ".lib/maison.sanitizer"

class Controller

    attr_accessor :params

    def index
      
    end



    private

    def render(params, code=200)
        [
            code,
            {"Content-Type" => "application/json"},
            [params.to_json]
        ]
    end


end