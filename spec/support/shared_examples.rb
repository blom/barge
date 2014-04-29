shared_examples_for 'a resource' do
  specify { expect(described_class).to include Barge::Resource::Base }

  describe '.new' do
    it 'takes one argument and returns it from #faraday' do
      expect(described_class.new(123).faraday).to be 123
    end
  end
end
