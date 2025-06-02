# frozen_string_literal: true
require 'rubyntlm'
require 'faraday/net_http_persistent'

module Faraday
  module NTLMAuth
    # This class provides the main implementation for your middleware.
    # Your middleware can implement any of the following methods:
    # * on_request - called when the request is being prepared
    # * on_complete - called when the response is being processed
    #
    # Optionally, you can also override the following methods from Faraday::Middleware
    # * initialize(app, options = {}) - the initializer method
    # * call(env) - the main middleware invocation method.
    #   This already calls on_request and on_complete, so you normally don't need to override it.
    #   You may need to in case you need to "wrap" the request or need more control
    #   (see "retry" middleware: https://github.com/lostisland/faraday-retry/blob/41b7ea27e30d99ebfed958abfa11d12b01f6b6d1/lib/faraday/retry/middleware.rb#L147).
    #   IMPORTANT: Remember to call `@app.call(env)` or `super` to not interrupt the middleware chain!
    class Middleware < Faraday::Middleware
      # This method will be called when the request is being prepared.
      # You can alter it as you like, accessing things like request_body, request_headers, and more.
      # Refer to Faraday::Env for a list of accessible fields:
      # https://github.com/lostisland/faraday/blob/main/lib/faraday/options/env.rb
      #
      # @param env [Faraday::Env] the environment of the request being processed
      def on_request(env)
        ntlm_message = Net::NTLM::Message
        env[:request_headers]['Authorization'] = 'NTLM ' + ntlm_message::Type1.new.encode64
        response = @app.call(env.dup)
        unless response.env[:response_headers]['www-authenticate']
          Logger.new(STDOUT, progname: 'faraday.ntlm_auth').warn('No NTLM challenge found in response headers, skipping NTLM authentication')
          return
        end
        challenge = response.env[:response_headers]['www-authenticate'][/(?:NTLM|Negotiate) (.*)$/, 1]
        message = ntlm_message::Type2.decode64(challenge)
        ntlm_auth = message.response([:user, :password, :domain].zip(@options[:auth]).to_h)
        env[:request_headers]['Authorization'] = "NTLM #{ntlm_auth.encode64}"
      end

    end
  end
end
