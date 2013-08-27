require_relative 'controller'
require_relative 'users'
require_relative 'events'
require_relative 'businesses'
require_relative 'apps'

module CardspringBrowse
  module App
    class Cardspring < Controller
      set :public_dir, File.expand_path("../public", __FILE__)
      enable :static
      enable :logging
      enable :method_override

      configure :development do
        enable :dump_errors
        enable :raise_errors
      end

      use CardspringBrowse::App::Users
      use CardspringBrowse::App::Events
      use CardspringBrowse::App::Businesses
      use CardspringBrowse::App::Apps

      get "/favicon.ico" do
      end

      get "/" do
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
