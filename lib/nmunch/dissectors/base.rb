module Nmunch
  module Dissectors

    # Public: Base dissector class
    class Base
      attr_reader :pcap_packet, :raw_data

      # Public: Initializer
      #
      # pcap_packet - An instance of Pcap::Packet
      #
      # Stores the packet and extracts to raw packet data in a way that makes
      # it easy to dissect
      #
      # Returns nothing
      def initialize(pcap_packet)
        @pcap_packet = pcap_packet
        extract_raw_packet_data
      end

      # Public: Dissector factory
      #
      # pcap_packet - An instance of Pcap::Packet
      #
      # Returns an instance of a dissector
      def self.factory(pcap_packet)
        if pcap_packet.ip?
          Nmunch::Dissectors::Ip.new(pcap_packet)
        else
          Nmunch::Dissectors::Arp.new(pcap_packet)
        end
      end

      private

      # Internal: Extract raw packet data and store it in @raw_data
      #
      # Unpacks data to HEX and splits it into an array of bytes
      #
      # Returns nothing
      def extract_raw_packet_data
        @raw_data = pcap_packet.raw_data.unpack('H*').first.scan(/.{2}/)
      end
    end
  end
end