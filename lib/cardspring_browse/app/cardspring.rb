require 'sinatra/base'

module CardspringBrowse
  class Cardspring < Sinatra::Base
    get "/" do
      erb :index
    end
  end
end
