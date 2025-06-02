# frozen_string_literal: true

require_relative 'lib/faraday/ntlm_auth/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-ntlm_auth'
  spec.version = Faraday::NTLMAuth::VERSION
  spec.authors = ['Luke Ridge']
  spec.email = ['lucas.ridge@igs.com']

  spec.summary = "A Faraday middleware for NTLM authentication"
  spec.license = 'MIT'

  github_uri = "https://github.com/igs-opensource/faraday-ntlm_auth"

  spec.homepage = github_uri

  spec.metadata = {
    'bug_tracker_uri' => "#{github_uri}/issues",
    'changelog_uri' => "#{github_uri}/blob/v#{spec.version}/CHANGELOG.md",
    'documentation_uri' => "http://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => github_uri,
    'wiki_uri' => "#{github_uri}/wiki"
  }

  spec.files = Dir['lib/**/*', 'README.md', 'LICENSE.md', 'CHANGELOG.md']

  spec.required_ruby_version = '>= 3.0', '< 4'

  spec.add_dependency 'faraday', '>= 2.9', '< 3'
  spec.add_dependency 'rubyntlm'
  spec.add_dependency 'faraday-net_http_persistent'
end
