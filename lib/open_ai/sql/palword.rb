module OpenAi
  module Sql
    class Palword
      TABLES = %w[pals pal_elements pal_work_suitabilities elements work_suitabilities].freeze
      IGNORE_COLUMNS = %w[created_at updated_at].freeze

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
    end
  end
end
