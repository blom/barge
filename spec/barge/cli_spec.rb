require 'spec_helper'

describe Barge::CLI do
  before do
    allow_any_instance_of(Barge::CLI).to receive(:exit)
    allow_any_instance_of(Barge::CLI).to receive(:puts)
    allow_any_instance_of(Barge::CLI)
      .to receive(:access_token)
      .and_return('some_token')
  end

  context 'options' do
    it 'handles zero' do
      stubbed_request = stub_request!(:get, '/images')
      Barge::CLI.new %w(image all)
      expect(stubbed_request.with(body: '')).to have_been_requested
    end

    it 'handles --name value pairs' do
      options = { name: 'test', image: '10' }
      stubbed_request = stub_request!(:post, '/droplets')
      Barge::CLI.new %w(droplet create --name test --image 10)
      expect(stubbed_request.with(body: options.to_json))
        .to have_been_requested
    end

    it 'handles a single integer' do
      stubbed_request = stub_request!(:delete, '/droplets/20')
      Barge::CLI.new %w(droplet destroy 20)
      expect(stubbed_request.with(body: '')).to have_been_requested
    end
  end
end
