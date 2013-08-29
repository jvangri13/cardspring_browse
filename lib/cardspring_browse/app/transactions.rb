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
        result = api.post(request.path_info, params['transaction'])
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
