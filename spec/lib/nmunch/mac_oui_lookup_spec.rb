require 'spec_helper'

describe Nmunch::MacOuiLookup do
  context 'when given an Apple mac address' do
    it 'returns Apple' do
      Nmunch::MacOuiLookup.instance.lookup('58:b0:35:31:33:73').should == 'Apple'
    end
  end

  context 'when given a Cisco mac address' do
    it 'returns Cisco Systems' do
      Nmunch::MacOuiLookup.instance.lookup('00:01:63:42:42:42').should == 'Cisco Systems'
    end
  end

  context 'when given a mac address with an unknown prefix' do
    it 'returns Unknown' do
      Nmunch::MacOuiLookup.instance.lookup('de:ad:be:ef:de:ad').should == 'Unknown'
    end
  end
end