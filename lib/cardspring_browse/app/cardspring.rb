require_relative 'controller'
require_relative 'users'
require_relative 'events'
require_relative 'businesses'
require_relative 'apps'

module CardspringBrowse
  module App
    class Cardspring < Controller
      use CardspringBrowse::App::Users
      use CardspringBrowse::App::Events
      use CardspringBrowse::App::Businesses
      use CardspringBrowse::App::Apps

      get "/v1" do
        get_result = api.get("")
        body = get_result.body
        publisher = JSON.parse(body)
        erb :index, locals: {
          result_body: body,
          publisher: publisher
        }
      end
    end
  end
end
