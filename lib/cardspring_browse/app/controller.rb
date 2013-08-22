require 'sinatra/base'
require_relative 'api_client'

module CardspringBrowse
  module App
    class Controller < Sinatra::Base

      PROPERTY_NAME = 'cardspring_browse.config_file'

      protected

      def api
        @api ||= ApiClient.new(env[PROPERTY_NAME], settings.environment)
      end

    end
  end
end
