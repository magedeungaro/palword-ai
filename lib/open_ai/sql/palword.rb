module OpenAi
  module Sql
    class Palword
      TABLES = %w[pals pal_elements pal_work_suitabilities elements work_suitabilities].freeze
      IGNORE_COLUMNS = %w[created_at updated_at].freeze
      GPT_MODEL = "gpt-3.5-turbo-0613"
      TEMPERATURE = 0.7

      @@schema_string = nil

      def self.mount_schema
        return @@schema_string if @@schema_string.present?

        schema_array = []
        TABLES.each do |table|
          model = ActiveRecord::Base.connection.table_exists?(table) ? table.classify.constantize : nil
          raise ArgumentError, "Table #{table} does not exist" unless model

          columns = model.column_names - IGNORE_COLUMNS
          schema_array << "Table #{table}\nColumns: #{columns.join(', ')}"
        end

        @@schema_string = schema_array.join("\n")
      end

      # https://github.com/alexrudall/ruby-openai?tab=readme-ov-file#functions
      # https://platform.openai.com/docs/guides/function-calling
      # https://cookbook.openai.com/examples/how_to_call_functions_with_chat_models
      def self.functions
        [
          name: :fetch_from_database,
          description: "Use this function to answer questions about pal elemental strongness and weaknesses,
                        as well work suitabilities. The answer should be a fully formed SQL query.",
          parameters: {
            type: :object,
            properties: {
              query: {
                type: :string,
                description: "SQL query extracting info to answer the user's question.
                              SQL should be written using this database schema:
                              #{mount_schema}
                              The query should be returned in plain text, not in JSON.",
              }
            },
            required: %w[query]
          }
        ]
      end
    end
  end
end
