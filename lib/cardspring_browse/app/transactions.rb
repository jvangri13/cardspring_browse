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

      get "/v1/transactions/:transaction_id" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        erb :transaction_details, :locals => {
          :result_body => body,
          :transaction_details => body_hash,
          :back_url => url("/v1/events")
        }
      end

      post "/v1/transactions/create" do
        result = api.put("/v1/transactions/#{params[:transaction_id]}", :type => params[:transaction_type] , :amount => params[:amount])
        body = result.body
        body_hash = JSON.parse(body)
        if body_hash['status'].match(/^4/)
          p "errors", body
        else
          redirect to("/v1/events")
        end
      end

      post "/v1/transactions" do
        post_data = cardspring_transaction_from_params
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

      private

      EmptyValues = lambda { |k,v| v.to_s.empty? }

      def cardspring_transaction_from_params
        form = params["transaction"]
        type_name = "#{params["business_or_store"]}_id"
        {
          type_name            => form[type_name],
          "amount"             => form["amount"],
          "card_token"         => form["card_token"],
          "purchase_date_time" => form["purchase_date_time"],
          "currency"           => form["currency"].upcase
        }.reject &EmptyValues
      end
    end
  end
end
