require 'desk/connection'
require 'desk/request'
require 'desk/authentication'

module Desk
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Desk.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def endpoint
      unless self.fulldomain.blank?
        return "https://#{self.subdomain}.desk.com/api/#{self.version}/"
      else
        return "#{self.subdomain}/api/#{self.version}/"
      end
    end

    include Connection
    include Request
    include Authentication
  end
end
