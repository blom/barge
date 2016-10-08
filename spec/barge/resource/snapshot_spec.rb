require 'spec_helper'

describe Barge::Resource::Snapshot do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all snapshots' do
      stubbed_request =
        stub_request!(:get, '/snapshots')
        .to_return(body: fixture('snapshots/all'), status: 200)
      all_snapshots = snapshot.all.snapshots
      expect(all_snapshots)
        .to include a_hash_including(id: '119192817')
      expect(all_snapshots)
        .to include a_hash_including(id: '7724db7c-e098-11e5-b522-000f53304e51')
      expect(stubbed_request).to have_been_requested
    end

    it 'accepts an options hash' do
      stubbed_request =
        stub_request!(:get, '/snapshots?per_page=20&page=10&resource_type=droplet')
        .to_return(body: fixture('snapshots/resource_type'), status: 200)
      expect(snapshot.all(per_page: 20, page: 10, resource_type: :droplet).snapshots)
        .to include a_hash_including(name: 'Ubuntu 13.04')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a given snapshot' do
      stubbed_request =
        stub_request!(:get, '/snapshots/7724db7c-e098-11e5-b522-000f53304e51')
        .to_return(body: fixture('snapshots/show'), status: 200)
      expect(snapshot.show('7724db7c-e098-11e5-b522-000f53304e51').snapshot.name).to eq 'Ubuntu Foo'
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys a snapshot' do
      stubbed_request =
        stub_request!(:delete, '/snapshots/7724db7c-e098-11e5-b522-000f53304e51').to_return(status: 204)
      expect(snapshot.destroy('7724db7c-e098-11e5-b522-000f53304e51').success?).to be true
      expect(stubbed_request).to have_been_requested
    end
  end

end
