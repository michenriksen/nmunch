module Nmunch
  module Subscribers

    # Public: Base subscriber class
    class Base
      attr_reader :options

      # Public: Initializer
      #
      # options - A hash of command line options
      #
      # Returns nothing
      def initialize(options)
        @options = options
      end
    end
  end
end