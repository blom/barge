module SpecHelpers
  def stub_request!(verb, path)
    stub_request(verb, File.join(Barge::Client::DIGITAL_OCEAN_URL, path))
      .with(headers: { authorization: 'some_token' })
  end
end
