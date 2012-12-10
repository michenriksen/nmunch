require 'spec_helper'

describe Nmunch::Subscribers::Base do
  let(:options) { {interface: 'en1'} }
  subject { Nmunch::Subscribers::Base.new(options) }

  describe '.initialize' do
    it 'assigns options to instance variable' do
      subject.options.should == options
    end
  end
end