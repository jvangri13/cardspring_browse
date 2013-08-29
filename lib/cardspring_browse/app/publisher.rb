require_relative 'controller'

module CardspringBrowse
  module App
    class Publisher < Controller

      get "/v1" do
        get_result = api.get("")
        body = get_result.body
        publisher = JSON.parse(body)
        erb :publisher, locals: {
          result_body: body,
          publisher: publisher
        }
      end
    end
  end
end
