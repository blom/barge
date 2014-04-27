require 'spec_helper'

describe Barge::Client do
  describe '#access_token' do
    let(:token) { 'some_token' }

    it 'can be set using a hash' do
      barge = described_class.new(access_token: token)
      expect(barge.access_token).to eq(token)
    end

    it 'can be set using a block' do
      barge = described_class.new { |c| c.access_token = token }
      expect(barge.access_token).to eq(token)
    end
  end
end
