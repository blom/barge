require 'spec_helper'

describe Barge::Resource::Droplet do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#show' do
    it 'returns information about a specific droplet' do
      stub_request!(:get, '/droplets/10')
        .to_return(body: fixture('droplets/show'), status: 200)
      expect(droplet.show(10).droplet.name).to eq 'test222'
    end
  end
end
