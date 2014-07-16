require 'spec_helper'

describe Barge::Response do
  let(:faraday_response) do
    Hashie::Mash.new(body: { foo: 'bar' }, success?: 123)
  end

  let(:response) { Barge::Response.new(faraday_response) }

  specify { expect(response).to include foo: 'bar' }

  describe '#response' do
    it 'is the argument given to .new' do
      expect(response.response).to be faraday_response
    end
  end

  describe '#success?' do
    specify { expect(response.success?).to be 123 }

    it 'delegates' do
      expect(response.response).to receive(:success?)
      response.success?
    end
  end
end
