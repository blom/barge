require 'spec_helper'

describe Barge::Response do
  let(:faraday_response) do
    Hashie::Mash.new(body: { foo: 'bar' }, success?: 123)
  end

  let(:response) { Barge::Response.new(faraday_response) }

  specify { expect(response).to include foo: 'bar' }

  describe '#response' do
    it 'is the argument given to .new' do
      expect(response.response).to be faraday_response
    end
  end

  describe '#success?' do
    specify { expect(response.success?).to be 123 }

    it 'delegates' do
      expect(response.response).to receive(:success?)
      response.success?
    end
  end

  context 'pagination' do
    context 'response without pagination' do
      let(:response) do
        Barge::Response.new(Hashie::Mash.new(body: { links: {} }))
      end

      describe '#paginated?' do
        specify { expect(response.paginated?).to be false }
      end

      describe '#prev_page' do
        specify { expect(response.prev_page).to be nil }
      end

      describe '#next_page' do
        specify { expect(response.next_page).to be nil }
      end

      describe '#last_page' do
        specify { expect(response.last_page).to be nil }
      end
    end

    context 'response with pagination' do
      let(:response) do
        Barge::Response.new(
          Hashie::Mash.new(
            body: {
              links: {
                pages: {
                  prev: '&page=10x',
                  next: '&page=20y',
                  last: '&page=30z'
                }
              }
            }
          )
        )
      end

      describe '#paginated?' do
        specify { expect(response.paginated?).to be true }
      end

      describe '#prev_page' do
        it 'returns the previous page number' do
          expect(response.prev_page).to be 10
        end
      end

      describe '#next_page' do
        it 'returns the next page number' do
          expect(response.next_page).to be 20
        end
      end

      describe '#last_page' do
        it 'returns the last page number' do
          expect(response.last_page).to be 30
        end
      end
    end
  end
end
