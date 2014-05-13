module Desk
  # Custom error class for rescuing from all Desk.com errors
  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, http_headers)
      http_headers ||= {}
      @http_headers = Hash[http_headers]
      super message
    end

    def ratelimit_reset
      @http_headers.values_at('x-rate-limit-reset', 'X-Rate-Limit-Reset').detect {|value| value }.to_i
    end

    def ratelimit_limit
      @http_headers.values_at('x-rate-limit-limit', 'X-Rate-Limit-Limit').detect {|value| value }.to_i
    end

    def ratelimit_remaining
      @http_headers.values_at('x-rate-limit-remaining', 'X-Rate-Limit-Remaining').detect {|value| value }.to_i
    end

    def retry_after
      ratelimit_reset
    end
  end

  # Raised when Desk returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Desk returns the HTTP status code 401
  class Unauthorized < Error; end

  # Raised when Desk returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Desk returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Desk returns the HTTP status code 406
  class NotAcceptable < Error; end

  # Raised when Desk returns the HTTP status code 429
  # Called EnhanceYourCalm because TooManyRequests is taken (see below)
  class EnhanceYourCalm < Error; end
  
  # Raised when Desk max_requests is reached and use_max_requests is set to true
  class TooManyRequests < StandardError; end

  # Raised when Desk returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Desk returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Desk returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Gem Specific Errors
  class DeskError < StandardError; end

  class SupportEmailNotSet < DeskError; end
end
