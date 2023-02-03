# frozen_string_literal: true

module Errors
  class Base < RuntimeError
    def initialize(message = nil)
      message ||= error_message

      super(message)
    end

    def to_h
      {
        error: {
          code:,
          message:
        },
        success: false
      }
    end

    def code
      raise 'Not implemented'
    end

    private

    def error_message
      'Unknown error'
    end

    def reason
      'unknown-error-reason'
    end
  end
end
