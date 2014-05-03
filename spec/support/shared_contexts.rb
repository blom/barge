shared_context 'resource' do
  let(:barge) { Barge::Client.new(access_token: 'some_token') }
  let(:droplet) { barge.droplet }
end
