# frozen_string_literal: true

class TokenVerifier
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    # Skip middleware for 'login' and 'register' routes
    if skip_token_check?(request)
      return @app.call(env)
    end

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

  private

  def skip_token_check?(request)
    # Define paths you want to exclude
    request.path.start_with?('/users/tokens/')
  end
end
