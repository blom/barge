require 'spec_helper'

describe Barge::Resource::Account do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#show' do
    it 'returns information about the account' do
      stubbed_request =
        stub_request!(:get, '/account')
        .to_return(body: fixture('account/show'), status: 200)
      expect(account.show.account.droplet_limit).to be 25
      expect(stubbed_request).to have_been_requested
    end
  end
end
