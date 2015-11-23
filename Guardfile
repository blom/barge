guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{\Aspec/.+_spec\.rb\z})
  watch(%r{\Alib/(.+)\.rb\z}) { |_, match| "spec/#{match}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{\Aspec/fixtures/(.+)/.*\.json\z}) do |_, match|
    "spec/barge/resource/#{match.chop}_spec.rb"
  end
end
