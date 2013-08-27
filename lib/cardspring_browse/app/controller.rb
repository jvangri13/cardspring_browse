require 'sinatra/base'
require_relative 'api_client'

module CardspringBrowse
  module App
    class Controller < Sinatra::Base

      PROPERTY_NAME = 'cardspring_browse.config_file'

      protected

      def request_path
        path = request.path_info
        path << "?" + request.query_string unless request.query_string.empty?
        path
      end

      def api
        @api ||= ApiClient.new(env[PROPERTY_NAME], settings.environment)
      end

    end
  end
end
