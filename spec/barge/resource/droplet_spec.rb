require 'spec_helper'

describe Barge::Resource::Droplet do
  it_behaves_like 'a resource'

  let(:barge) { Barge::Client.new(access_token: 'some_token') }
  let(:droplet) { barge.droplet }

  describe '#show' do
    it 'returns information about a specific droplet' do
      stub_request!(:get, '/droplets/10')
        .to_return(body: fixture('droplets/show'), status: 200)
      expect(droplet.show(10).droplet.name).to eq 'test222'
    end
  end
end
