require "./lib/controller"

class Router
  def controller
    @controller ||= Controller.new
  end

  def call(env)

    path = env["REQUEST_PATH"]
    req = Rack::Request.new(env)

    if req.options?
      return [ 
          200,

          {"Content-<type" => "application/json", "
          Access-Control-Allow-Origin" => "*"},
          [{}]
      ]
    end
    #binding.pry
    body = req.body.gets
    params = {}


    params.merge!(body ? JSON.parse(body) : {}) 
    
    controller.params = params

    #binding.pry

    return [ 
      200,

      {"Content-<type" => "application/json", 
      "Access-Control-Allow-Origin" => "*"},
      [{"message" => "salut"}.to_json]
  ]

    case path
    when  "/"
    #controller.index


    end
  end
end
