require 'sinatra/base'
require_relative 'api_client'

module CardspringBrowse
  module App
    class Controller < Sinatra::Base

      protected

      def api
        @api ||= ApiClient.new(env['cardspring.browse.config.file'], settings.environment)
      end

    end
  end
end
