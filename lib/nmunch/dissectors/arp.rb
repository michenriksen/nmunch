module Nmunch
  module Dissectors

    # Public: Address Resolution Protocol dissector
    #
    # Extracts IP and MAC address from an ARP packet
    #
    # See http://en.wikipedia.org/wiki/Address_Resolution_Protocol for protocol details
    class Arp < Nmunch::Dissectors::Base

      # Public: Get sender IP address from ARP packet
      #
      # Returns IP address
      def ip_address
        @ip_address ||= IPAddr.new(raw_data[28..31].join.hex, Socket::AF_INET).to_s
      end

      # Public: Get sender MAC address from ARP packet
      #
      # Returns MAC address
      def mac_address
        @mac_address ||= raw_data[22..27].join(':')
      end
    end
  end
end