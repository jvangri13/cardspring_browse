require 'sinatra/base'
require_relative 'app/cardspring'

module CardspringBrowse
  class Application

    PROPERTY_NAME = 'cardspring_browse.config_file'

    def initialize(config_file)
      @config_file = config_file
    end

    def call(env)
      env[PROPERTY_NAME] = @config_file
      result = app.call(env)
      env.delete(PROPERTY_NAME)
      result
    end

    def app
      @app ||= CardspringBrowse::App::Cardspring.new(self)
    end

  end
end
