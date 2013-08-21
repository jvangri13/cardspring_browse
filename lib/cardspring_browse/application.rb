require 'sinatra/base'
require_relative 'app/cardspring'

module CardspringBrowse
  class Application

    def initialize(config_file)
      @config_file = config_file
    end

    def call(env)
      env['cardspring.browse.config.file'] = @config_file
      app.call(env)
    end

    def app
      @app ||= CardspringBrowse::App::Cardspring.new(self)
    end

  end
end
