require 'spec_helper'

describe Nmunch::Dissectors::Base do
  let(:arp_pcap_packet) do
    packet = stub(Pcap::Packet)
    packet.stub(:raw_data).and_return(ARP_PACKET_DATA)
    packet.stub(:ip?).and_return(false)
    packet
  end

  let(:ip_pcap_packet) do
    packet = stub(Pcap::Packet)
    packet.stub(:raw_data).and_return(IP_PACKET_DATA)
    packet.stub(:ip?).and_return(true)
    packet
  end

  subject { Nmunch::Dissectors::Base.new(arp_pcap_packet) }

  describe '#pcap_packet' do
    it 'returns pcap packet given in initializer' do
      subject.pcap_packet.should == arp_pcap_packet
    end
  end

  describe '#raw_data' do
    it 'returns an array of bytes represented in HEX' do
      subject.raw_data.should == ARP_PACKET_DATA.unpack('H*').first.scan(/.{2}/)
    end
  end

  describe '.factory' do
    context 'when given ARP packet' do
      it 'returns an ARP dissector' do
        Nmunch::Dissectors::Base.factory(arp_pcap_packet).should be_a(Nmunch::Dissectors::Arp)
      end
    end

    context 'when given an IP packet' do
      it 'returns an IP dissector' do
        Nmunch::Dissectors::Base.factory(ip_pcap_packet).should be_a(Nmunch::Dissectors::Ip)
      end
    end
  end
end