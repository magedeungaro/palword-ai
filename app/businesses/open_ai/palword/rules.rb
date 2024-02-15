module OpenAi
  module Palword
    class Rules
      class << self
        @@descriptions = {}

        def work_suitabilities
          return @@descriptions[:work_suitabilities] if @@descriptions[:work_suitabilities].present?

          descriptions = WorkSuitability.pluck(:name, :description)
                                        .map { |name, description| "#{name}: #{description.downcase}" }
          @@descriptions[:work_suitabilities] = descriptions.unshift('Work Suitabilities').join("\n")
        end

        def elements
          return @@descriptions[:elements] if @@descriptions[:elements].present?

          descriptions = Element.pluck(:name, :description)
                                .map { |name, description| "#{name}: #{description.downcase}" }
          @@descriptions[:elements] = descriptions.unshift('Elements').join("\n")
        end
      end
    end
  end
end
