require "nmunch/version"
require "nmunch/dissectors/base"
require "nmunch/dissectors/ip"
require "nmunch/dissectors/arp"
require "nmunch/subscribers/base"
require "nmunch/subscribers/stdout"
require "nmunch/node"
require "nmunch/report"
require "nmunch/mac_oui_lookup"

# Public: Main Nmunch module
#
# Acts as a facade in front of the ruby-pcap gem and abstracts away the packet analysis.
module Nmunch

  # Internal: PCAP filter expression to only get ARP and broadcast packets
  CAPTURE_FILTER = 'arp or broadcast'

  # Public: Start munching on packets on interface or from PCAP file
  #
  # options - Hash of command line options
  #
  # Yields an Nmunch::Node with IP and MAC address information
  def self.munch!(options)
    create_capture_object(options).each_packet do |packet|
      dissector = Nmunch::Dissectors::Base.factory(packet)
      yield Nmunch::Node.create_from_dissector(dissector)
    end
  end

  # Internal: Get the awesome Nmunch ASCII banner
  #
  # Returns ASCII banner
  def self.banner
    banner = <<EOB

 88b 88 8b    d8 88   88 88b 88  dP""b8 88  88
 88Yb88 88b  d88 88   88 88Yb88 dP   `" 88  88
 88 Y88 88YbdP88 Y8   8P 88 Y88 Yb      888888
 88  Y8 88 YY 88 `YbodP' 88  Y8  YboodP 88  88
EOB
  end

  private

  # Internal: Create a capture object from options
  #
  # options - Hash of command line options
  #
  # Returns a Pcap::Capture object on interface or a PCAP file
  def self.create_capture_object(options)
    if options[:interface]
      capture = Pcap::Capture.open_live(options[:interface])
    else
      capture = Pcap::Capture.open_offline(options[:file])
    end
    capture.setfilter(CAPTURE_FILTER)
    capture
  end
end
