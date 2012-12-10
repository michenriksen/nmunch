require 'spec_helper'

describe Nmunch do
  describe 'PCAP filter expression' do
    it 'allows only ARP and broadcast packets' do
      Nmunch::CAPTURE_FILTER.should == 'arp or broadcast'
    end
  end
end