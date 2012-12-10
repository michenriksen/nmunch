require 'spec_helper'

describe Nmunch::Dissectors::Arp do
  let(:arp_pcap_packet) do
    packet = stub(Pcap::Packet)
    packet.stub(:raw_data).and_return(ARP_PACKET_DATA)
    packet.stub(:ip?).and_return(false)
    packet
  end

  subject { Nmunch::Dissectors::Arp.new(arp_pcap_packet) }

  describe '#ip_address' do
    it 'returns correct IP address' do
      subject.ip_address.should == '192.168.0.125'
    end
  end

  describe '#mac_address' do
    it 'returns correct MAC address' do
      subject.mac_address.should == 'de:ad:be:ef:de:ad'
    end
  end
end