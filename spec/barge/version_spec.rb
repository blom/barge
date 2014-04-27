require 'spec_helper'

describe 'Barge::Version' do
  describe '.to_s' do
    it 'returns a version string' do
      expect(Barge::Version.to_s).to match(/\A\d+\.\d+\.\d+/)
    end
  end
end
