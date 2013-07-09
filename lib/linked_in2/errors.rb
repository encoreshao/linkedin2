module LinkedIn2
  module Errors
    class LinkedIn2Error < StandardError
      attr_reader :data
      def initialize(data)
        @data = data
        super
      end
    end

    class UnauthorizedError      < LinkedIn2Error; end
    class GeneralError           < LinkedIn2Error; end
    class AccessDeniedError      < LinkedIn2Error; end

    class UnavailableError       < StandardError; end
    class InformLinkedIn2Error    < StandardError; end
    class NotFoundError          < StandardError; end
  end
end
