shared_examples_for 'a resource' do
  specify { expect(described_class).to include Barge::Resource::Base }

  describe '#faraday' do
    let(:value) { '123' }

    it 'returns the object passed to .new' do
      expect(described_class.new(value).faraday).to be value
    end
  end
end
