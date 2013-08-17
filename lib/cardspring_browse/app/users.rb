require 'sinatra/base'
require 'faraday'
require 'json'
require 'yaml'

module CardspringBrowse
  class Users < Sinatra::Base
    helpers do
      def users_path
        url("/users")
      end

      def user_path(user_hash)
        url("/users/#{user_hash['id']}")
      end

      def remove_user_path(user_hash)
        url("/users/#{user_hash['id']}/remove")
      end
    end

    get "/users" do
      get_result = conn.get('users')
      body = get_result.body
      users = JSON.parse(body)['items']

      erb :users, :locals => {
        :users => users,
        :result_body => body,
        :previous_url => '',
        :next_url => ''
      }
    end

    get "/users/:id" do
      get_result = conn.get("users/#{params[:id]}")
      body = get_result.body
      user = JSON.parse(body)
      erb :user_details, :locals => {
        :result_body => body,
        :user => user
      }
    end

    post "/users/:id/remove" do
      conn.delete("users/#{params[:id]}")
      redirect to("/users")
    end

    private

    def configuration
      @configuration ||= YAML.load_file(CardspringBrowse::GlobalSettings.current[:cardspring_yaml_path])[settings.environment.to_s]
    end

    def conn
      @conn ||= create_connection
    end

    def create_connection
      conn = Faraday.new(configuration['api_base_url'])
      conn.basic_auth(configuration['api_id'], configuration['api_secret'])
      conn
    end
  end
end

