guard :rspec do
  watch(/\Aspec\/.+_spec\.rb\z/)
  watch(/\Alib\/(.+)\.rb\z/) { |_, match| "spec/#{match}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
end
