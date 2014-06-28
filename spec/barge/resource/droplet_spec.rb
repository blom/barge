require 'spec_helper'

describe Barge::Resource::Droplet do
  include_context 'resource'
  it_behaves_like 'a resource'

  describe '#create' do
    it 'creates a droplet' do
      stubbed_request = stub_request!(:post, '/droplets')
        .to_return(body: fixture('droplets/create'), status: 202)
      options = { name: 'x', image: 123 }
      expect(droplet.create(options).id).to be 1
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end
  end

  describe '#all' do
    it 'lists all Droplets' do
      stubbed_request = stub_request!(:get, '/droplets')
        .to_return(body: fixture('droplets/all'), status: 200)
      expect(droplet.all.first).to include name: 'test.example.com'
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show' do
    it 'returns information about a specific droplet' do
      stubbed_request = stub_request!(:get, '/droplets/10')
        .to_return(body: fixture('droplets/show'), status: 200)
      expect(droplet.show(10).snapshots.first.id).to be 32
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#backups' do
    it 'shows droplet backups' do
      stubbed_request = stub_request!(:get, '/droplets/33/backups')
        .to_return(body: fixture('droplets/backups'), status: 200)
      expect(droplet.backups(33).backups)
        .to include a_hash_including(distribution: 'ubuntu')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#snapshots' do
    it 'shows droplet snapshots' do
      stubbed_request = stub_request!(:get, '/droplets/34/snapshots')
        .to_return(body: fixture('droplets/snapshots'), status: 200)
      expect(droplet.snapshots(34).snapshots)
        .to include a_hash_including(distribution: 'ubuntu')
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#destroy' do
    it 'destroys a droplet' do
      stubbed_request = stub_request!(:delete, '/droplets/11')
        .to_return(status: 202)
      expect(droplet.destroy(11).success?).to be true
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#rename' do
    it 'renames a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/12/actions')
        .to_return(body: fixture('droplets/rename'), status: 200)
      expect(droplet.rename(12, 'new_name').type).to eq 'rename'
      expect(stubbed_request
        .with(body: { type: :rename, params: { name: :new_name } }.to_json))
        .to have_been_requested
    end
  end

  describe '#reboot' do
    it 'reboots a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/13/actions')
        .to_return(body: fixture('droplets/reboot'), status: 200)
      expect(droplet.reboot(13).type).to eq 'reboot'
      expect(stubbed_request
        .with(body: { type: :reboot, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#shutdown' do
    it 'shuts down a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/20/actions')
        .to_return(body: fixture('droplets/shutdown'), status: 200)
      expect(droplet.shutdown(20).type).to eq 'shutdown'
      expect(stubbed_request
        .with(body: { type: :shutdown, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#power_off' do
    it 'powers off a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/14/actions')
        .to_return(body: fixture('droplets/power_off'), status: 200)
      expect(droplet.power_off(14).type).to eq 'power_off'
      expect(stubbed_request
        .with(body: { type: :power_off, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#power_cycle' do
    it 'powers cycles a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/15/actions')
        .to_return(body: fixture('droplets/power_cycle'), status: 200)
      expect(droplet.power_cycle(15).type).to eq 'power_cycle'
      expect(stubbed_request
        .with(body: { type: :power_cycle, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#power_on' do
    it 'powers on a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/15/actions')
        .to_return(body: fixture('droplets/power_on'), status: 200)
      expect(droplet.power_on(15).type).to eq 'power_on'
      expect(stubbed_request
        .with(body: { type: :power_on, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#resize' do
    it 'resizes a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/17/actions')
        .to_return(body: fixture('droplets/resize'), status: 200)
      expect(droplet.resize(17, '1024m').type).to eq 'resize'
      expect(stubbed_request
        .with(body: { type: :resize, params: { size: '1024m' } }.to_json))
        .to have_been_requested
    end
  end

  describe '#rebuild' do
    it 'rebuilds a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/18/actions')
        .to_return(body: fixture('droplets/rebuild'), status: 200)
      expect(droplet.rebuild(18, 100).type).to eq 'rebuild'
      expect(stubbed_request
        .with(body: { type: :rebuild, params: { image: 100 } }.to_json))
        .to have_been_requested
    end
  end

  describe '#restore' do
    it 'restores a droplet' do
      stubbed_request = stub_request!(:post, '/droplets/19/actions')
        .to_return(body: fixture('droplets/restore'), status: 200)
      expect(droplet.restore(19, 101).type).to eq 'restore'
      expect(stubbed_request
        .with(body: { type: :restore, params: { image: 101 } }.to_json))
        .to have_been_requested
    end
  end

  describe '#password_reset' do
    it "resets a droplet's password" do
      stubbed_request = stub_request!(:post, '/droplets/21/actions')
        .to_return(body: fixture('droplets/password_reset'), status: 200)
      expect(droplet.password_reset(21).type).to eq 'password_reset'
      expect(stubbed_request
        .with(body: { type: :password_reset, params: {} }.to_json))
        .to have_been_requested
    end
  end

  describe '#actions' do
    it 'shows droplet actions' do
      stubbed_request = stub_request!(:get, '/droplets/51/actions')
        .to_return(body: fixture('droplets/actions'), status: 200)
      expect(droplet.actions(51).actions)
        .to include a_hash_including(resource_id: 23)
      expect(stubbed_request).to have_been_requested
    end
  end

  describe '#show_action' do
    it 'shows action information' do
      stubbed_request = stub_request!(:get, '/droplets/30/actions/40')
        .to_return(body: fixture('droplets/show_action'), status: 200)
      expect(droplet.show_action(30, 40).type).to eq 'create'
      expect(stubbed_request).to have_been_requested
    end
  end
end
