module Nmunch
  module Dissectors

    # Public: Internet Protocol dissector
    #
    # Extracts IP and MAC address from IP packet
    #
    # See http://en.wikipedia.org/wiki/Internet_Protocol for protocol details
    class Ip < Nmunch::Dissectors::Base

      # Public: Get sender IP address from IP packet
      #
      # Returns IP address
      def ip_address
        @ip_address ||= pcap_packet.ip_src.to_s
      end

      # Public: Get sender MAC address from IP packet
      #
      # Returns MAC address
      def mac_address
        @mac_address ||= raw_data[6..11].join(':')
      end
    end
  end
end