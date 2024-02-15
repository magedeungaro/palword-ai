module OpenAi
  module Palword
    class Rules
      class << self
        def work_suitabilities
          return @@work_suitability_description if @@work_suitability_description.present?

          descriptions = WorkSuitability.pluck(:name, :description)
                                        .map { |name, description| "#{name}: #{description.downcase}" }
          @@work_suitability_description = descriptions.unshift('Work Suitabilities').join("\n")
        end

        def elements
          return @@element_description if @@element_description.present?

          descriptions = Element.pluck(:name, :description)
                                .map { |name, description| "#{name}: #{description.downcase}" }
          @@element_description = descriptions.unshift('Elements').join("\n")
        end
      end
    end
  end
end
