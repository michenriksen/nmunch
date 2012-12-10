require 'spec_helper'

class TestSubscriber
  def process(node); end
end

describe Nmunch::Report do
  let(:node) { Nmunch::Node.new(ip_address: '192.168.0.1', mac_address: 'de:ad:be:ef:de:ad') }
  let(:options) { {interface: 'en1'} }
  let(:subscriber) { TestSubscriber.new }
  subject { Nmunch::Report.new(options) }

  describe '#publish_node' do
    before(:each) do
      subject.register_subscriber(subscriber)
    end

    it 'delegates the node to the subscriber' do
      subscriber.should_receive(:process).with(node)
      subject.publish_node(node)
    end

    context 'when node has a meta address' do
      it 'does not delegate node to subscribers' do
        node.stub(:ip_address).and_return('0.0.0.0')
        subscriber.should_not_receive(:process)
        subject.publish_node(node)
      end
    end

    context 'when node is already discovered' do
      it 'does not delegate node to subscribers' do
        subject.publish_node(node)
        subscriber.should_not_receive(:process)
        subject.publish_node(node)
      end
    end
  end
end