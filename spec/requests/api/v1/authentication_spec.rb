require 'rails_helper'

RSpec.describe 'API V1 Authentication', type: :request do
  let(:user) { create(:user, password: 'password123') }
  let(:valid_credentials) { { email: user.email, password: 'password123' } }
  let(:invalid_credentials) { { email: user.email, password: 'wrongpassword' } }

  describe 'POST /api/v1/authenticate' do
    context 'with valid credentials' do
      it 'authenticates the user' do
        post '/api/v1/authenticate', params: valid_credentials
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to include('auth_token')
      end

      it 'returns a valid JWT token' do
        post '/api/v1/authenticate', params: valid_credentials
        token = JSON.parse(response.body)['auth_token']
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        expect(decoded_token.first['id']).to eq(user.id)
      end

      it 'returns a token that expires in the future' do
        post '/api/v1/authenticate', params: valid_credentials
        token = JSON.parse(response.body)['auth_token']
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        expect(Time.at(decoded_token.first['exp'])).to be > Time.now
      end
    end

    context 'with invalid credentials' do
      it 'returns an error for invalid password' do
        post '/api/v1/authenticate', params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid credentials')
      end

      it 'returns an error for non-existent user' do
        post '/api/v1/authenticate', params: { email: 'nonexistent@example.com', password: 'password123' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid credentials')
      end
    end
  end

  describe 'Token Validation' do
    it 'generates a token that can be properly decoded' do
      token = user.generate_jwt
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      expect(decoded_token.first['id']).to eq(user.id)
    end

    it 'raises an error for an invalid token' do
      expect {
        JWT.decode('invalid_token', Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      }.to raise_error(JWT::DecodeError)
    end

    it 'raises an error for an expired token' do
      expired_token = JWT.encode({ id: user.id, exp: 1.day.ago.to_i }, Rails.application.secrets.secret_key_base)
      expect {
        JWT.decode(expired_token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      }.to raise_error(JWT::ExpiredSignature)
    end
  end
end