require "rails_helper"

module Api
  module V1
    RSpec.describe "Platform", type: :request do
      Platform.where(name: "Test").destroy
      describe "POST /api/v1/platforms" do
        it "works!" do
          post "/api/v1/platforms", params: {
            platform: {
              name: "Test",
              type: "POST",
              code: "CODE"
            }
          }.to_json, headers: { 'Content-Type': "application/json" }

          expect(response).to have_http_status(:created)
        end
      end

      describe "GET api/v1/platforms" do
        it "works!" do
          get "/api/v1/platforms"
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(name: "Test")._id.to_s
          get "/api/v1/platforms/#{id}"
          expect(response).to have_http_status(:ok)
        end
      end

      describe "PUT /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(name: "Test")._id.to_s
          put "/api/v1/platforms/#{id}", params: {
            platform: {
              type: "PUT",
              code: "CODE2"
            }
          }.to_json, headers: { 'Content-Type': "application/json" }

          expect(response).to have_http_status(:ok)
        end
      end

      describe "DELETE /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(name: "Test")._id.to_s
          delete "/api/v1/platforms/#{id}"

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
