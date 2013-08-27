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
          :apps => apps
        }
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
          :apps => apps
        }
      end
    end
  end
end
