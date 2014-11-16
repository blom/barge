shared_context 'resource' do
  let(:barge) { Barge::Client.new(access_token: 'some_token') }

  let(:account) { barge.account }
  let(:action) { barge.action }
  let(:domain) { barge.domain }
  let(:droplet) { barge.droplet }
  let(:image) { barge.image }
  let(:key) { barge.key }
  let(:region) { barge.region }
  let(:size) { barge.size }
end
