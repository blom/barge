require 'spec_helper'

describe Barge::Resource::FloatingIP do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all floating IPs' do
      stubbed_request =
        stub_request!(:get, '/floating_ips')
        .to_return(body: fixture('floating_ips/all'), status: 200)
      expect(floating_ip.all.floating_ips)
        .to include a_hash_including(ip: '10.20.30.40')
      expect(stubbed_request).to have_been_requested
    end

    it 'accepts an options hash' do
      stubbed_request =
        stub_request!(:get, '/floating_ips?per_page=3&page=5')
        .to_return(body: fixture('floating_ips/all'), status: 200)
      expect(floating_ip.all(per_page: 3, page: 5).floating_ips)
        .to include a_hash_including(ip: '10.20.30.40')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#create' do
    it 'creates a floating IP' do
      stubbed_request =
        stub_request!(:post, '/floating_ips')
        .to_return(body: fixture('floating_ips/create'), status: 202)
      options = { region: 'lon1' }
      expect(floating_ip.create(options).floating_ip.ip).to eq '10.20.30.40'
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a specific floating IP' do
      stubbed_request =
        stub_request!(:get, '/floating_ips/10.20.30.40')
        .to_return(body: fixture('floating_ips/show'), status: 200)
      expect(floating_ip.show('10.20.30.40').floating_ip.ip)
        .to eq '10.20.30.40'
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys a floating IP' do
      stubbed_request =
        stub_request!(:delete, '/floating_ips/1.2.3.4').to_return(status: 202)
      expect(floating_ip.destroy('1.2.3.4').success?).to be true
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#assign' do
    it 'assigns a floating IP to a droplet' do
      stubbed_request =
        stub_request!(:post, '/floating_ips/1.2.3.4/actions')
        .to_return(body: fixture('floating_ips/assign'), status: 200)
      expect(floating_ip.assign('1.2.3.4', droplet_id: 123).action.region_slug)
        .to eq 'nyc3'
      expect(stubbed_request
        .with(body: { type: :assign, droplet_id: 123 }.to_json))
        .to have_been_requested
    end
  end

  describe '#unassign' do
    it 'unassigns a floating IP' do
      stubbed_request =
        stub_request!(:post, '/floating_ips/5.6.7.8/actions')
        .to_return(body: fixture('floating_ips/unassign'), status: 200)
      expect(floating_ip.unassign('5.6.7.8').action.type)
        .to eq 'unassign_ip'
      expect(stubbed_request
        .with(body: { type: :unassign }.to_json))
        .to have_been_requested
    end
  end
end
