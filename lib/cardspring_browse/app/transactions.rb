require 'json'

module CardspringBrowse
  module App
    class Transactions < Controller

      get "/v1/transactions/new" do
        erb :new_transaction, :locals => {
          :post_url => url("/v1/transactions"),
          :back_url => url("/v1/events")
        }
      end

      post "/v1/transactions" do
        post_data = {
          "amount" => params["transaction"]["amount"],
          "card_token" => params["transaction"]["card_token"]
        }
        post_data["purchase_date_time"] = params['transaction']['purchase_date_time'].upcase unless params['transaction']['purchase_date_time'].to_s.empty?
        post_data["currency"] = params['transaction']['currency'].upcase unless params['transaction']['currency'].to_s.empty?
        post_data["business_id"] = params['transaction']['business_id'] if params['business_or_store'] == 'business'
        post_data["store_id"] = params['transaction']['store_id'] if params['business_or_store'] == 'store'
        result = api.post(request.path_info, post_data)
        body = result.body
        body_hash = JSON.parse(body)
        unless body_hash.has_key?("error")
          redirect to("/v1/events")
        else
          p "errors", body_hash
          redirect to("/v1/transactions/new")
        end
      end
    end
  end
end
