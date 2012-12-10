require 'spec_helper'

describe Nmunch::Subscribers::Stdout do
  let(:node) { Nmunch::Node.new(ip_address: '192.168.0.1', mac_address: 'de:ad:be:ef:de:ad') }
  let(:options) { {interface: 'en1'} }
  subject { Nmunch::Subscribers::Stdout.new(options) }

  describe '#process' do
    it 'prints node details to STDOUT' do
      output = capture_stdout { subject.process(node) }
      output.should include('192.168.0.1')
      output.should include('de:ad:be:ef:de:ad')
      output.should include('Unknown')
    end

    context 'when --no-prefix-lookup option is set' do
      it 'does not look up mac address prefix' do
        options['no-prefix-lookup'] = true
        output = capture_stdout { subject.process(node) }
        output.should include('192.168.0.1')
        output.should include('de:ad:be:ef:de:ad')
        output.should_not include('Unknown')
      end
    end
  end
end