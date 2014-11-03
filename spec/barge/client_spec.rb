require 'spec_helper'

describe Barge::Client do
  let(:token) { 'some_token' }
  let(:timeouts) { 100 }
  let(:default_timeouts) { described_class.const_get :TIMEOUTS }

  describe '#access_token' do
    it 'can be set using a hash' do
      barge = described_class.new(access_token: token)
      expect(barge.access_token).to eq(token)
    end

    it 'can be set using a block' do
      barge = described_class.new { |c| c.access_token = token }
      expect(barge.access_token).to eq(token)
    end

    context 'when none is given' do
      specify do
        expect { described_class.new }
          .to raise_error(ArgumentError, 'missing access_token')
      end
    end
  end

  describe '#timeouts' do
    it 'is optional, client should use default TIMEOUTS' do
      barge = described_class.new(access_token: token)
      expect(barge.timeouts).to eq(default_timeouts)
    end
    it 'can be set using a hash' do
      barge = described_class.new(access_token: token, timeouts: timeouts)
      expect(barge.timeouts).to eq(timeouts)
    end

    it 'can be set using a block' do
      barge = described_class.new do |c|
        c.access_token = token
        c.timeouts = timeouts
      end
      expect(barge.timeouts).to eq(timeouts)
    end
  end
end
