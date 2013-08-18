require 'sinatra/base'

module CardspringBrowse
  class Cardspring < Sinatra::Base
    get "/" do
      get_result = api.get("")
      body = get_result.body
      publisher = JSON.parse(body)
      erb :index, locals: {
        result_body: body,
        publisher: publisher
      }
    end

    private

    def api
      @api ||= CardspringBrowse::ApiClientManager.create_default_client(settings.environment)
    end

  end
end
