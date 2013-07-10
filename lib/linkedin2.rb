module LinkedIn2
  class << self
    attr_accessor :default_profile_fields

    # config/initializers/linkedin.rb (for instance)
    #
    # LinkedIn2.configure do |config|
    #   config.default_profile_fields = ['id', 'first-name', 'last-name', 'maiden-name', 'industry', 'summary', 'specialties', 'picture-url']
    # end
    #
    # elsewhere
    #
    # client = LinkedIn2::Client.new
    def configure
      yield self
      true
    end

  end
  autoload :API,      "linked_in2/api"
  autoload :Strategy, "linked_in2/strategy"
  autoload :Client,   "linked_in2/client"
  autoload :Mash,     "linked_in2/mash"
  autoload :Errors,   "linked_in2/errors"
  autoload :Helpers,  "linked_in2/helpers"
  autoload :Search,   "linked_in2/search"
  autoload :Version,  "linked_in2/version"
  autoload :Config,   "linked_in2/config"
end
