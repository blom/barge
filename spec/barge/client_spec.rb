require 'spec_helper'

describe Barge::Client do
  let(:token) { 'some_token' }

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

  describe '#request_options' do
    let(:request_options) { { open_timeout: 100, timeout: 200 } }

    it 'can be set using a hash' do
      barge = described_class.new(
        access_token: token,
        request_options: request_options
      )
      expect(barge.request_options).to eq request_options
    end

    it 'can be set using a block' do
      barge = described_class.new do |c|
        c.access_token = token
        c.request_options = request_options
      end
      expect(barge.request_options).to eq request_options
    end

    context 'when left out' do
      describe 'open_timeout' do
        it 'defaults to 10' do
          barge = described_class.new(access_token: token)
          expect(barge.send(:faraday).options.open_timeout).to eq 10
        end
      end

      describe 'timeout' do
        it 'defaults to 10' do
          barge = described_class.new(access_token: token)
          expect(barge.send(:faraday).options.timeout).to eq 10
        end
      end
    end

    context 'when only open_timeout is set' do
      describe 'timeout' do
        it 'defaults to 10' do
          barge = described_class.new(
            access_token: token,
            request_options: { open_timeout: 20 }
          )
          expect(barge.send(:faraday).options.timeout).to eq 10
        end
      end
    end

    context 'when only timeout is set' do
      describe 'open_timeout' do
        it 'defaults to 10' do
          barge = described_class.new(
            access_token: token,
            request_options: { timeout: 20 }
          )
          expect(barge.send(:faraday).options.open_timeout).to eq 10
        end
      end
    end

    it "is used to set faraday's request options" do
      barge = described_class.new do |c|
        c.access_token = token
        c.request_options = request_options
      end
      expect(barge.send(:faraday).options.open_timeout).to be 100
      expect(barge.send(:faraday).options.timeout).to be 200
    end
  end
end
