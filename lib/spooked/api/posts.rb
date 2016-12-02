# frozen_string_literal: true

module Spooked
  module API
    class Posts < Base
      class << self
        def list(
          fields:     nil,
          filter:     nil,
          include_:   nil, # include is a reserved keyword
          limit:      15,
          order:      "published_at desc",
          page:       1
        )
          client.get("posts/", { params: {
            fields:   fields,
            filter:   filter,
            include:  include_,
            limit:    limit,
            order:    order,
            page:     page,
          }.reject { |k, v| v.nil? } })
        end
      end
    end
  end
end
