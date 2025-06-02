# frozen_string_literal: true

require_relative 'ntlm_auth/middleware'
require_relative 'ntlm_auth/version'

module Faraday
  # This will be your middleware main module, though the actual middleware implementation will go
  # into <%= middleware_constant %> for the correct namespacing.
  module NTLMAuth
    # Faraday allows you to register your middleware for easier configuration.
    # This step is totally optional, but it basically allows users to use a
    # custom symbol (in this case, `:<%= middleware_name %>`), to use your middleware in their connections.
    # After calling this line, the following are both valid ways to set the middleware in a connection:
    # * conn.use <%= middleware_constant %>
    # * conn.use :<%= middleware_name %>
    # Without this line, only the former method is valid.
    Faraday::Request.register_middleware(ntlm_auth: Faraday::NTLMAuth::Middleware)

    # Alternatively, you can register your middleware under Faraday::Request or Faraday::Response.
    # This will allow to load your middleware using the `request` or `response` methods respectively.
    #
    # Load middleware with conn.request :<%= middleware_name %>
    # Faraday::Request.register_middleware(<%= middleware_name %>: <%= middleware_constant %>)
    #
    # Load middleware with conn.response :<%= middleware_name %>
    # Faraday::Response.register_middleware(<%= middleware_name %>: <%= middleware_constant %>)
  end
end
