require "./lib/controller"

class Router
  def controller
    @controller ||= Controller.new
  end

  def call(env)

    if env["REQUEST_PATH"] == "OPTIONS"
      [ 
          200,

          {"Content-<type" => "application/json", "
          Access-Control-Allow-Origin" => "*"},
          [{}]
      ]
      else

        path = env["REQUEST_PATH"]
    req = Rack::Request.new(env)
    body = req.body.gets
    params = {}


    params.merge!(body ? JSON.parse(body) : {}) 
    
    controller.params = params
    binding.pry
      case path
      when  "/"
        controller.index
      end
    end
  end
end
