require 'spec_helper'

describe Barge::Resource::Volume do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all volumes' do
      stubbed_request =
        stub_request!(:get, '/volumes')
        .to_return(body: fixture('volumes/all'), status: 200)
      expect(volume.all.volumes)
        .to include a_hash_including(id: "7724db7c-e098-11e5-b522-000f53304e51")
      expect(stubbed_request).to have_been_requested
    end

    it 'accepts an options hash' do
      stubbed_request =
        stub_request!(:get, '/volumes?page=10&per_page=20&region=nyc1')
        .to_return(body: fixture('volumes/all'), status: 200)
      expect(volume.all(per_page: 20, page: 10, region: 'nyc1').volumes)
        .to include a_hash_including(id: "7724db7c-e098-11e5-b522-000f53304e51")
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#create' do
    it 'creates a volume' do
      stubbed_request =
        stub_request!(:post, '/volumes')
        .to_return(body: fixture('volumes/create'), status: 201)
      options = {
        size_gigabytes: 10,
        name: "Example",
        description: "Block store for examples",
        region: "nyc1"
      }
      expect(volume.create(options).volume.id).to eql('7724db7c-e098-11e5-b522-000f53304e51')
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys a volume' do
      stubbed_request =
        stub_request!(:delete, '/volumes/7724db7c-e098-11e5-b522-000f53304e51').to_return(status: 204)
      expect(volume.destroy('7724db7c-e098-11e5-b522-000f53304e51').success?).to be true
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a given volume' do
      stubbed_request =
        stub_request!(:get, '/volumes/7724db7c-e098-11e5-b522-000f53304e51')
        .to_return(body: fixture('volumes/show'), status: 200)
      expect(volume.show('7724db7c-e098-11e5-b522-000f53304e51').volume.name).to eq 'Example'
      expect(stubbed_request).to have_been_requested
    end
  end

end
