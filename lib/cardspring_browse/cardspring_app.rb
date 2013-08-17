require 'sinatra/base'
require_relative './global_settings'
require_relative './app/cardspring'
require_relative './app/users'

module CardspringBrowse
  class CardspringApp < Sinatra::Base
    set :public_dir, File.expand_path("./app/public", File.dirname(__FILE__))
    set :static, true

    get "/favicon.ico" do
    end

    use CardspringBrowse::Cardspring
    use CardspringBrowse::Users
  end
end
