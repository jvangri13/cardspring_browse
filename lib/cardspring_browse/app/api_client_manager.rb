module CardspringBrowse
  class ApiClientManager
    class << self

      def create_default_client environment
        yaml_path = CardspringBrowse::GlobalSettings.current[:cardspring_yaml_path]
        CardspringBrowse::ApiClient.new(yaml_path.to_s, environment.to_s)
      end

    end
  end
end
