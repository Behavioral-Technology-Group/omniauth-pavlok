require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pavlok < OmniAuth::Strategies::OAuth2
      option :name, :pavlok

      option :client_options, {
        :site => ENV['PAVLOK_SITE_URL'] || 'https://pavlok-mvp.herokuapp.com',
        :authorize_url => ENV['PAVLOK_AUTH_URL'] || 'https://pavlok-mvp.herokuapp.com/oauth/authorize',
        :token_url => ENV['PAVLOK_TOKEN_URL'] || 'https://pavlok-mvp.herokuapp.com/oauth/token'
      }

      uid { raw_info["id"] }

      info do
        { :email => raw_info["email"] }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me').parsed
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def email
        raw_info['email']
      end
    end
  end
end
