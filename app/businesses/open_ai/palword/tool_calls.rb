# frozen_string_literal: true

module OpenAi
  module Palword
    class ToolCalls
      class << self
        def fetch_from_database(query)
          query = query.gsub(';', '').downcase
          result = ActiveRecord::Base.connection.execute(query)
          result.ntuples.zero? ? 'not found' : result.values.to_s
        rescue StandardError => e
          Rails.logger.error e
          'query failed'
        end
      end
    end
  end
end
