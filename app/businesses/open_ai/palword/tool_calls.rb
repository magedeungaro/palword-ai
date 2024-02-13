# frozen_string_literal: true

module OpenAI
  module Palword
    class ToolCalls
      class << self
        def fetch_from_database(query)
          ActiveRecord::Base.connection.execute(query).to_a.to_s
        rescue StandardError => e
          Rails.logger.error e
          'Query failed.'
        end
      end
    end
  end
end
