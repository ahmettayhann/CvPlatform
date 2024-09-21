require 'rails_helper'

RSpec.describe "Api::V1::Resumes", type: :request do
  let(:user) { create(:user) }
  let!(:resume1) { create(:resume, user: user, title: "Software Engineer") }
  let!(:resume2) { create(:resume, user: user, title: "Data Scientist") }
  let!(:inactive_resume) { create(:resume, user: user, title: "Inactive Resume", active: false) }
  let(:token) { user.generate_jwt }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe "GET /api/v1/resumes/:id" do
    it "returns a specific resume" do
      get "/api/v1/resumes/#{resume1.id}", headers: headers
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response["resume"]["title"]).to eq("Software Engineer")
    end

    it "returns not found for non-existent resume" do
      get "/api/v1/resumes/0", headers: headers
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Resume not found')
    end
  end
end