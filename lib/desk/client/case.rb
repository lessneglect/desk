module Desk
  class Client
    # Defines methods related to cases
    module Case
      # Returns extended information of cases
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.cases(:case_id => 12345)
      #     Desk.cases(:email => "customer@example.com", :count => 5)
      #     Desk.cases(:since_id => 12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/show
      def cases(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("cases",options)
        response
      end

      # Returns extended information on a single case
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.case(12345)
      #     Desk.case(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/show
      def case(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("cases/#{id}",options)
        response.case
      end

      # Updates a single case
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.update_case(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/update
      def update_case(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("cases/#{id}",options)
        response.case
      end

      #todo: this needs to support custom subdomains
      def case_url(id)
        "https://#{subdomain}.desk.com/agent/case/#{id}"
        #"https://#{fulldomain}/agent/case/#{id}"
      end
    end
  end
end
