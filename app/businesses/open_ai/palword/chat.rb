# frozen_string_literal: true

module OpenAi
  module Palword
    class Chat
      GPT_MODEL = 'gpt-3.5-turbo-0613'
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
        @client ||= OpenAI::Client.new
      end

      private

      def analyze
        response = chat_completion
        message = response.dig(:choices, 0, :message, :content)
        return response unless is_valid?(message)

        @messages << { role: :assistant, content: message }

        results = execute_function_call(message) if message[:tool_calls].present?
        @messages << {
          role: :function,
          tool_call_id: message.dig(:tool_calls, 0, :id),
          name: message.dig(:tool_calls, 0, :function, :name),
          content: results
        }

        analyze
      end

      def is_valid?(message)
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
        function = message.dig(:tool_calls, 0, :function, :name).to_sym
        return "#{function} is not a valid function." unless ToolCalls.respond_to?(function)

        params = message.dig(:tool_calls, 0, :function, :arguments)
        ToolCalls.method(function).call(params)
      end
    end
  end
end
