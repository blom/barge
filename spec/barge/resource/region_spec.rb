require 'spec_helper'

describe Barge::Resource::Region do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all regions' do
      stubbed_request = stub_request!(:get, '/regions')
        .to_return(body: fixture('regions/all'), status: 200)
      expect(region.all).to include a_hash_including('slug' => 'nyc1')
      expect(stubbed_request).to have_been_requested
    end
  end
end
