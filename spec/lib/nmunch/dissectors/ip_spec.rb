require 'spec_helper'

describe Nmunch::Dissectors::Ip do
  let(:ip_pcap_packet) do
    packet = stub(Pcap::Packet)
    packet.stub(:raw_data).and_return(IP_PACKET_DATA)
    packet.stub(:ip?).and_return(true)
    packet
  end

  subject { Nmunch::Dissectors::Ip.new(ip_pcap_packet) }

  describe '#ip_address' do
    it 'returns correct IP address' do
      ip_pcap_packet.should_receive(:ip_src).and_return('192.168.0.125')
      subject.ip_address.should == '192.168.0.125'
    end
  end

  describe '#mac_address' do
    it 'returns correct MAC address' do
      subject.mac_address.should == 'de:ad:be:ef:de:ad'
    end
  end
end