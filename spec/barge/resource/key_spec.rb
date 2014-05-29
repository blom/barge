require 'spec_helper'

describe Barge::Resource::Key do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#create' do
    it 'creates a key' do
      stubbed_request = stub_request!(:post, '/account/keys')
        .to_return(body: fixture('keys/create'), status: 200)
      options = { name: 'default', public_key: 'ssh-rsa AAAAB3N...' }
      expect(key.create(options).id).to be 4
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end
  end

  describe '#all' do
    it 'lists all keys' do
      stubbed_request = stub_request!(:get, '/account/keys')
        .to_return(body: fixture('keys/all'), status: 200)
      expect(key.all).to include a_hash_including(name: 'Example Key')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a given key' do
      stubbed_request = stub_request!(:get, '/account/keys/100')
        .to_return(body: fixture('keys/show'), status: 200)
      expect(key.show(100).name).to eq 'Example Key'
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys a key' do
      stubbed_request = stub_request!(:delete, '/account/keys/101')
        .to_return(body: fixture('keys/destroy'), status: 200)
      expect(key.destroy(101).name).to eq 'Example Key'
      expect(stubbed_request).to have_been_requested
    end
  end
end
