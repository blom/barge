require 'spec_helper'

describe Barge::Resource::Action do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#all' do
    it 'lists all actions' do
      stubbed_request =
        stub_request!(:get, '/actions')
        .to_return(body: fixture('actions/all'), status: 200)
      expect(action.all.actions)
        .to include a_hash_including(status: 'in-progress')
      expect(stubbed_request).to have_been_requested
    end

    it 'accepts an options hash' do
      stubbed_request =
        stub_request!(:get, '/actions?per_page=5&page=2')
        .to_return(body: fixture('actions/all'), status: 200)
      expect(action.all(per_page: 5, page: 2).actions)
        .to include a_hash_including(status: 'in-progress')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'shows information about a specific action' do
      stubbed_request =
        stub_request!(:get, '/actions/10')
        .to_return(body: fixture('actions/show'), status: 200)
      expect(action.show(10).action).to include resource_type: 'backend'
      expect(stubbed_request).to have_been_requested
    end
  end
end
