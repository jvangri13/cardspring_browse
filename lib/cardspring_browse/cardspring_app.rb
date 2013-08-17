require 'sinatra/base'
require_relative './users'

module CardspringBrowse
  class CardspringApp < Sinatra::Base
    use CardspringBrowse::Users

    get "/" do
      erb :index
    end
  end
end
