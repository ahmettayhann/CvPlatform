require 'rails_helper'

RSpec.describe "Api::V1::Resumes", type: :request do
  let(:user) { create(:user) }
  let!(:resume1) { create(:resume, user: user, title: "Software Engineer") }
  let!(:resume2) { create(:resume, user: user, title: "Data Scientist") }
  let!(:inactive_resume) { create(:resume, user: user, title: "Inactive Resume", active: false) }
  let(:token) { user.generate_jwt }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe "GET /api/v1/resumes" do
    it "returns all active resumes" do
      get "/api/v1/resumes", headers: headers
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['resumes'].length).to eq(2)
    end

    it "returns resumes filtered by title" do
      get "/api/v1/resumes", params: { q: { title_cont: "Software" } }, headers: headers
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['resumes'].length).to eq(1)
      expect(json_response['resumes'].first["title"]).to eq("Software Engineer")
    end

    it "does not return inactive resumes" do
      get "/api/v1/resumes", headers: headers
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      titles = json_response['resumes'].map { |resume| resume["title"] }
      expect(titles).not_to include("Inactive Resume")
    end
  end
end