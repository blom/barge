require 'spec_helper'

describe Barge::Resource::Size do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all sizes' do
      stubbed_request = stub_request!(:get, '/sizes')
        .to_return(body: fixture('sizes/all'), status: 200)
      expect(size.all).to include a_hash_including('price_monthly' => '5.0')
      expect(stubbed_request).to have_been_requested
    end
  end
end
