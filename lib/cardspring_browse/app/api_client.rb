require 'faraday'
require 'yaml'

module CardspringBrowse
  module App
    class ApiClient
      def initialize(yaml_path, environment)
        @yaml_path = yaml_path.to_s
        @environment = environment.to_s
      end

      attr_reader :yaml_path, :environment

      def get(url)
        conn.get(url)
      end

      def delete(url)
        conn.delete(url)
      end

      private

      def conn
        @conn ||= create_connection
      end

      def configuration
        @configuration ||= YAML.load_file(yaml_path)[environment]
      end

      def create_connection
        conn = Faraday.new(configuration['api_base_url'])
        conn.basic_auth(configuration['api_id'], configuration['api_secret'])
        conn
      end
    end
  end
end
