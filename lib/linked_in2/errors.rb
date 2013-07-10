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

    class UnavailableError       < LinkedIn2Error; end
    class InformLinkedInError    < LinkedIn2Error; end
    class NotFoundError          < LinkedIn2Error; end
  end
end
