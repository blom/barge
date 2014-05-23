require 'spec_helper'

module Barge
  module Resource
    class Dummy
      include Barge::Resource::Base

      def dummy
        request(:get, 'dummy')
      end
    end
  end
end

describe Barge::Resource::Base do
  include_context 'resource'

  context 'using a dummy resource' do
    let(:dummy) { Barge::Resource::Dummy.new(barge.send(:faraday)) }

    describe '#request' do
      before { stub_request!(:get, '/dummy').to_return(status: 200) }
      let(:result) { dummy.dummy }

      describe '#response' do
        specify { expect(result.response).to be_instance_of Faraday::Response }

        describe '#status' do
          specify { expect(result.response.status).to be 200 }
        end
      end

      describe '#success?' do
        it 'delegates to #response' do
          expect(result.response).to receive(:success?)
          result.success?
        end
      end
    end
  end
end
