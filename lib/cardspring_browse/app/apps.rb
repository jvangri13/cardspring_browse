
require 'json'

module CardspringBrowse
  module App
    class Apps < Controller
      helpers do
        def h(text)
          Rack::Utils.escape_html(text)
        end
      end

      get "/v1/businesses/:id/apps" do
        get_result = api.get(request_path)
        body = get_result.body
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
        get_result = api.get(request_path)
        body = get_result.body
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
