# frozen_string_literal: true

module Spooked
  class Client
    OPTIONS_WITH_CLASS_DEFAULT = [
      :access_token,
      :connection_builder,
      :connection_options,
      :subdomain,
      :url_base,
    ].freeze

    OPTIONS_WITH_CLASS_DEFAULT.each do |option|
      define_singleton_method(option) do
        instance_variable_get("@#{option}")
      end

      define_singleton_method("#{option}=") do |*args|
        instance_variable_set("@#{option}", *args)
      end

      define_method(option) do
        instance_variable_get("@#{option}")
      end

      define_method("#{option}=") do |*args|
        instance_variable_set("@#{option}", *args)
      end
    end

    self.connection_builder = ->(builder) {
      builder.adapter   Faraday.default_adapter
      builder.request   :url_encoded
      builder.response  :json
    }

    self.connection_options = {}

    self.url_base = ->(client) {
      "https://#{subdomain}.ghost.io/ghost/api/v0.1"
    }

    [
      :delete,
      :get,
      :post,
      :put,
    ].each do |http_verb|
      define_method(http_verb) do |*args|
        connection.public_send(http_verb, *args)
      end
    end

    def initialize(**options)
      unknown_options = options.keys - OPTIONS_WITH_CLASS_DEFAULT
      raise ArgumentError, "Unknown option key(s): #{unknown_options.join(", ")}. Valid options are: #{OPTIONS_WITH_CLASS_DEFAULT.join(", ")}." if unknown_options.any?

      OPTIONS_WITH_CLASS_DEFAULT.each do |option|
        value = options[option].nil? ? self.class.public_send(option) : options[option]
        public_send("#{option}=", value)
      end

      self
    end

    protected

    def connection
      @connection ||= Faraday::Connection.new(evaluate_option(url_base), params: { access_token: access_token }, &connection_builder)
    end

    def evaluate_option(option)
      option.is_a?(Proc) ? instance_eval(&option) : option
    end

    class << self
      def default_client
        @default_client ||= new
      end

      def default_client=(client)
        @default_client = client
      end
    end
  end
end
