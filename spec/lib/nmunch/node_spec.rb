require 'spec_helper'

describe Nmunch::Node do
  subject { Nmunch::Node.new(ip_address: '192.168.0.1', mac_address: 'de:ad:be:ef:de:ad') }

  describe '#ip_address' do
    it 'returns correct IP address' do
      subject.ip_address.should == '192.168.0.1'
    end
  end

  describe '#mac_address' do
    it 'returns correct MAC address' do
      subject.mac_address.should == 'de:ad:be:ef:de:ad'
    end
  end

  describe '#meta_address?' do
    context 'when IP is not a meta address' do
      it 'returns false' do
        subject.should_not be_meta_address
      end
    end

    context 'when IP is a meta address' do
      it 'returns true' do
        subject.stub(:ip_address).and_return('0.0.0.0')
        subject.should be_meta_address
      end
    end
  end

  describe '.create_from_dissector' do
    let(:dissector) do
      dissector = stub
      dissector.stub(:ip_address).and_return('192.168.0.1')
      dissector.stub(:mac_address).and_return('de:ad:be:ef:de:ad')
      dissector
    end
    subject { Nmunch::Node.create_from_dissector(dissector) }

    it 'returns a node' do
      subject.should be_a(Nmunch::Node)
    end

    it 'has correct IP address' do
      subject.ip_address.should == '192.168.0.1'
    end

    it 'has correct MAC address' do
      subject.mac_address.should == 'de:ad:be:ef:de:ad'
    end
  end
end