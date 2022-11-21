require 'rails_helper'

module Api
  module V1
    RSpec.describe "Platform", type: :request do
      Platform.where(:name => "Test Name").destroy
      describe "POST /api/v1/platforms" do
        it "works!" do
          post "/api/v1/platforms", params: {
            platform: {
              name: "Test Name",
              type: "Test Type",
              code: "Test Code" 
            }
          }
          expect(response).to have_http_status(201)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:name]).to eq("Test Name")
          expect(json[:type]).to eq("Test Type")
          expect(json[:code]).to eq("Test Code")
        end
      end
      describe "GET api/v1/platforms" do
        it "works!" do
          get "/api/v1/platforms"
          expect(response).to have_http_status(200)
        end
      end
      describe "GET /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(:name => "Test Name")._id.to_s 
          get "/api/v1/platforms/#{id}" 
          expect(response).to have_http_status(200)
        end
      end  
      describe "PUT /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(:name => "Test Name")._id.to_s
          put "/api/v1/platforms/#{id}", params: {
            platform: {
              name: "Test Name",
              type: "Test Type",
              code: "New Test Code" 
            }
          }
          expect(response).to have_http_status(200)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:name]).to eq("Test Name")
          expect(json[:type]).to eq("Test Type")
          expect(json[:code]).to eq("New Test Code")
        end
      end
      describe "DELETE /api/v1/platforms/:id" do
        it "works!" do
          id = Platform.find_by(:code => "New Test Code")._id.to_s
          delete "/api/v1/platforms/#{id}"

          expect(response).to have_http_status(204)
        end
      end
    end
  end
end

