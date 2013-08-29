require 'json'

module CardspringBrowse
  module App
    class Apps < Controller
      helpers do
        def h(text)
          Rack::Utils.escape_html(text)
        end
      end

      get "/v1/apps" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        apps = body_hash['items']
        erb :apps, :locals => {
          :result_body => body,
          :current_url => url(body_hash['_uri']),
          :previous_url => url(body_hash['_previous_page_uri']),
          :next_url => url(body_hash['_next_page_uri']),
          :back_url => url("/"),
          :new_url => "",
          :apps => apps
        }
      end

      get "/v1/apps/:id" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        erb :app_details, :locals => {
          :result_body => body,
          :back_url => url("/v1/apps"),
          :app => body_hash
        }
      end

      delete "/v1/apps/:id" do
        api.delete(request_path)
        redirect to("/v1/apps")
      end

      get "/v1/businesses/:id/apps" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        apps = body_hash['items']
        erb :apps, :locals => {
          :result_body => body,
          :current_url => url(body_hash['_uri']),
          :previous_url => url(body_hash['_previous_page_uri']),
          :next_url => url(body_hash['_next_page_uri']),
          :back_url => url("/v1/businesses/#{params[:id]}"),
          :new_url => url("/v1/businesses/#{params[:id]}/apps/new"),
          :apps => apps
        }
      end

      get "/v1/businesses/:id/apps/new" do
        erb :new_app, :locals => {
          :post_url => url("/v1/businesses/#{params[:id]}/apps"),
          :back_url => url("/v1/businesses/#{params[:id]}")
        }
      end

      post "/v1/businesses/:id/apps" do
        result = api.post(request.path_info, params['app'])
        body = result.body
        body_hash = JSON.parse(body)
        unless body_hash.has_key?("error")
          redirect to(request.path_info)
        else
          p "errors", body_hash
          redirect to("/v1/businesses/:id/apps/new")
        end
      end

      get "/v1/users/:id/apps" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        apps = body_hash['items']
        erb :apps, :locals => {
          :result_body => body,
          :current_url => url(body_hash['_uri']),
          :previous_url => url(body_hash['_previous_page_uri']),
          :next_url => url(body_hash['_next_page_uri']),
          :back_url => url("/v1/users/#{params[:id]}"),
          :new_url => url("/v1/users/#{params[:id]}/apps/new"),
          :apps => apps
        }
      end

      get "/v1/users/:id/apps/new" do
        erb :new_user_app, :locals => {
          :post_url => url("/v1/users/#{params[:id]}/apps"),
          :back_url => url("/v1/users/#{params[:id]}")
        }
      end

      post "/v1/users/:id/apps" do
        result = api.post(request.path_info, params['app'])
        body = result.body
        p "result of user app post", body
        body_hash = JSON.parse(body)
        unless body_hash.has_key?("error")
          redirect to(request.path_info)
        else
          p "errors", body_hash
          redirect to("/v1/users/:id/apps/new")
        end
      end

    end
  end
end
