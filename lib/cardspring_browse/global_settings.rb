module CardspringBrowse
  class GlobalSettings
    class << self
      def current
        initial_setup if :not_set_yet == @@settings
        @@settings
      end

      private

      def initial_setup
        @@settings = Hash.new
        @@settings[:cardspring_yaml_path] = File.expand_path("../../config/cardspring.yml", File.dirname(__FILE__))
      end

      @@settings ||= :not_set_yet

    end
  end
end
