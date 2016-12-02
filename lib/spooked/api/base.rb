# frozen_string_literal: true

module Spooked
  module API
    class Base
      class << self
        protected

        def client
          Client.default_client
        end
      end
    end
  end
end
