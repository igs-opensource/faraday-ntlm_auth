# frozen_string_literal: true

RSpec.describe Faraday::NTLMAuth::Middleware do

  # Can't really test this middleware publicly since I'd need a public ntlm server.

  it 'Can be created against a faraday connection\'s request stack' do
    conn = Faraday.new do |builder|
      builder.adapter :test, lambda { |env|
        [200, {}, '']
      }
      builder.request :ntlm_auth, auth: ['user', 'password', 'domain']
    end

    expect(conn).to be_a(Faraday::Connection)
    expect(conn.builder.handlers).to include(Faraday::NTLMAuth::Middleware)
  end

end
