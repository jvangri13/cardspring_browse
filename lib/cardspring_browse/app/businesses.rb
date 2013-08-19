require 'sinatra/base'
require 'json'

module CardspringBrowse
  class Businesses < Sinatra::Base
    helpers do
      def h(text)
        Rack::Utils.escape_html(text)
      end

      def businesses_path
        url("/v1/businesses")
      end

      def business_path(business_hash)
        url("/v1/businesses/#{business_hash['id']}")
      end

      def business_stores_path(business_hash)
        url("/v1/businesses/#{business_hash['id']}/stores")
      end
    end

    get "/v1/businesses" do
      get_result = api.get(request.path_info)
      body = get_result.body
      body_hash = JSON.parse(body)
      businesses = body_hash['items']

      erb :businesses, :locals => {
        :businesses => businesses,
        :result_body => body,
        :current_url => url(body_hash['_uri']),
        :previous_url => url(body_hash['_previous_page_uri']),
        :next_url => url(body_hash['_next_page_uri'])
      }
    end

    get "/v1/businesses/:id" do
      get_result = api.get(request.path_info)
      body = get_result.body
      business = JSON.parse(body)
      erb :business_details, :locals => {
        :result_body => body,
        :business => business
      }
    end

    get "/v1/businesses/:business_id/stores" do
      get_result = api.get(request.path_info)
      body = get_result.body
      body_hash = JSON.parse(body)
      stores = body_hash['items']

      erb :stores, :locals => {
        :business => { 'id' => params[:business_id] },
        :stores => stores,
        :result_body => body,
        :current_url => url(body_hash['_uri']),
        :previous_url => url(body_hash['_previous_page_uri']),
        :next_url => url(body_hash['_next_page_uri'])
      }
    end

    get "/v1/businesses/:business_id/stores/:id" do
      get_result = api.get(request.path_info)
      body = get_result.body
      store = JSON.parse(body)
      erb :store_details, :locals => {
        :result_body => body,
        :store => store,
        :business => { 'id' => params[:business_id] }
      }
    end

    private

    def api
      @api ||= CardspringBrowse::ApiClientManager.create_default_client(settings.environment)
    end

  end
end
