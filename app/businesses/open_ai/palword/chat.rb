# frozen_string_literal: true

module OpenAi
  module Palword
    class Chat
      GPT_MODEL = 'gpt-4-1106-preview'
      TEMPERATURE = 0.7

      def initialize
        @messages = [] << instruction
      end

      def ask(query)
        @messages << { role: :user, content: query }
        analyze
        puts @messages.inspect
      end

      def client
        @client ||= OpenAI::Client.new do |f|
          f.response :logger, Logger.new($stdout), bodies: true
        end
      end

      private

      def analyze
        response = chat_completion
        message = response.dig(:choices, 0, :message)
        content = message[:content]
        @messages << { role: :assistant, content: } if content.present?

        return unless function_call?(message)

        @messages << { role: :assistant, content: message[:function_call].to_json }
        results = execute_function_call(message)

        @messages << {
          role: :function,
          name: message.dig(:function_call, :name),
          content: results
        }

        analyze
      end

      def function_call?(message)
        message.try(:[], :role) == 'assistant' && message.try(:[], :function_call)
      end

      def chat_completion
        response = client.chat(
          parameters: {
            model: GPT_MODEL,
            messages: @messages,
            temperature: TEMPERATURE,
            functions: ::OpenAi::Sql::Palword.functions
          }
        )

        response.deep_symbolize_keys if response.is_a?(Hash)
      end

      def instruction
        {
          role: :system,
          content: 'You are a palword expert. Your job is to answer ' \
            'questions about pal word elemental strongness ' \
            'and weaknesses, as well as work suitabilities efficiently. ' \
            'Ask for clarifications if a user request is ambiguous.'
        }
      end

      def execute_function_call(message)
        function = message.dig(:function_call, :name).to_sym
        return "#{function} is not a valid function." unless ToolCalls.respond_to?(function)

        query = JSON.parse(message.dig(:function_call, :arguments))["query"]
        ToolCalls.method(function).call(query)
      end
    end
  end
end
