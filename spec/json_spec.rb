# TODO: Remove once base image includes json >= 2.19.9 (CVE-2026-33210, CVE-2026-54696)
require 'json'

RSpec.describe 'json' do
  it 'loads the bundled gem instead of the vulnerable default gem' do
    expect(Gem::Version.new(JSON::VERSION)).to be >= Gem::Version.new('2.19.9')
    expect($LOADED_FEATURES).to include(%r{\A/usr/local/bundle/gems/json-[^/]+/lib/json/version\.rb\z})
  end
end
