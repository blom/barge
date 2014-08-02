require 'spec_helper'

describe Barge::Resource::Image do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all images' do
      stubbed_request = stub_request!(:get, '/images')
        .to_return(body: fixture('images/all'), status: 200)
      expect(image.all.images)
        .to include a_hash_including(name: 'Ubuntu 13.04')
      expect(stubbed_request).to have_been_requested
    end

    it 'accepts an options hash' do
      stubbed_request = stub_request!(:get, '/images?per_page=20&page=10')
        .to_return(body: fixture('images/all'), status: 200)
      expect(image.all(per_page: 20, page: 10).images)
        .to include a_hash_including(name: 'Ubuntu 13.04')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a given image' do
      stubbed_request = stub_request!(:get, '/images/100')
        .to_return(body: fixture('images/show'), status: 200)
      expect(image.show(100).image.name).to eq 'Ubuntu 13.04'
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#update' do
    it 'updates an image' do
      stubbed_request = stub_request!(:put, '/images/101')
        .to_return(body: fixture('images/update'), status: 200)
      options = { name: 'New Image Name' }
      expect(image.update(101, options).image.name).to eq 'New Image Name'
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys an image' do
      stubbed_request = stub_request!(:delete, '/images/102')
        .to_return(status: 200)
      expect(image.destroy(102).success?).to be true
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#transfer' do
    it 'transfers an image to another region' do
      stubbed_request = stub_request!(:post, '/images/103/actions')
        .to_return(body: fixture('images/transfer'), status: 200)
      expect(image.transfer(103, region: 'sfo1').action.type).to eq 'transfer'
      expect(stubbed_request
        .with(body: { type: :transfer, region: 'sfo1' }.to_json))
        .to have_been_requested
    end
  end

  describe '#show_action' do
    it 'shows action information' do
      stubbed_request = stub_request!(:get, '/images/104/actions/200')
        .to_return(body: fixture('images/show_action'), status: 200)
      expect(image.show_action(104, 200).action.type).to eq 'transfer'
      expect(stubbed_request).to have_been_requested
    end
  end
end
