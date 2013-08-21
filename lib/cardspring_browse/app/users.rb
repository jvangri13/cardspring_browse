require 'json'

module CardspringBrowse
  module App
    class Users < Controller
      helpers do
        def h(text)
          Rack::Utils.escape_html(text)
        end

        def users_path
          url("/v1/users")
        end

        def user_path(user_hash)
          url("/v1/users/#{user_hash['id']}")
        end
      end

      get "/v1/users" do
        get_result = api.get(request.path_info)
        body = get_result.body
        body_hash = JSON.parse(body)
        users = body_hash['items']

        erb :users, :locals => {
          :users => users,
          :result_body => body,
          :current_url => url(body_hash['_uri']),
          :previous_url => url(body_hash['_previous_page_uri']),
          :next_url => url(body_hash['_next_page_uri'])
        }
      end

      get "/v1/users/:id" do
        get_result = api.get(request.path_info)
        body = get_result.body
        user = JSON.parse(body)
        erb :user_details, :locals => {
          :result_body => body,
          :user => user
        }
      end

      post "/v1/users/:id" do
        api.delete(request.path_info)
        redirect to("/v1/users")
      end

      get "/v1/users/:user_id/cards/:id" do
        get_result = api.get(request.path_info)
        body = get_result.body
        card = JSON.parse(body)
        erb :card_details, :locals => {
          :result_body => body,
          :card => card,
          :user => { 'id' => params[:user_id] }
        }
      end

      post "/v1/users/:user_id/cards/:id" do
        api.delete(request.path_info)
        redirect to("/v1/users/#{params[:user_id]}")
      end
    end
  end
end
