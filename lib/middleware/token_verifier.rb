# frozen_string_literal: true

class TokenVerifier
  def initialize(app)
    @app = app
  end

  def call(env)
    auth_header = env['HTTP_AUTHORIZATION']

    if auth_header.blank?
      return [
        401,
        { 'Content-Type' => 'application/json' },
        [{ error: 'Missing token' }.to_json]
      ]
    end

    @app.call(env)
  end
end
