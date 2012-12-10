require 'singleton'

module Nmunch

  # Public: A utility class to look up a MAC address prefix to get the organizational name.
  class MacOuiLookup
    include Singleton

    # Public: Get organizational name for a MAC address
    #
    # mac_address - A MAC address with format: hh:hh:hh:hh:hh:hh
    #
    # Example:
    #
    #     Nmunch::MacOuiLookup.instance.lookup('58:b0:35:31:33:73')
    #     # => Apple
    #
    # Returns name of organization or Unknown if prefix can't be found
    def lookup(mac_address)
      load_prefix_file! if @prefixes.nil?
      oui = mac_address[0..7].upcase.gsub(':', '').to_sym
      @prefixes[oui] || 'Unknown'
    end

    private

    # Internal: Load the file with prefixes
    #
    # Returns nothing
    def load_prefix_file!
      @prefixes = {}
      File.open("#{File.dirname(__FILE__)}/../../mac-prefixes.txt", 'r').each_line do |line|
        line.strip!
        next if line.empty? || line.start_with?('#', '//')
        oui, organization = line.split(' ', 2)
        @prefixes[oui.to_sym] = organization
      end
    end
  end
end