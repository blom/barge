module SpecHelpers
  def fixture(name)
    File.read(File.expand_path("../../fixtures/#{name}.json", __FILE__))
  end

  def stub_request!(verb, path)
    stub_request(verb, File.join(Barge::Client::DIGITAL_OCEAN_URL, path))
      .with(headers: { authorization: 'Bearer some_token' })
  end
end
