require 'sinatra/base'
require 'json'

module CardspringBrowse
  class Events < Sinatra::Base

    get "/v1/events" do
      get_result = api.get(request.path_info)
      body = get_result.body
      body_hash = JSON.parse(body)
      events = body_hash['items']

      erb :events, :locals => {
        :events => events,
        :result_body => body,
        :current_url => url(body_hash['_uri']),
        :previous_url => url(body_hash['_previous_page_uri']),
        :next_url => url(body_hash['_next_page_uri'])
      }
    end

    private

    def api
      @api ||= CardspringBrowse::ApiClientManager.create_default_client(settings.environment)
    end

  end
end
