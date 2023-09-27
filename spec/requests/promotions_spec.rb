require "rails_helper"

module Api
  module V1
    RSpec.describe "Promotions", type: :request do
      Promotion.where(title: "Test").destroy
      describe "POST /api/v1/promotions" do
        it "works!" do
          payment =  Payment.new(name: "Test", type: "ASSOCIATION", code: "CODE")
          platform = Platform.new(name: "Test", type: "ASSOCIATION", code: "CODE")
          payment.save
          platform.save
          post "/api/v1/promotions", params: {
            promotion: {
              title: "Test",
              description: "Rspec Test",
              code: "CODE",
              start_time: Time.now.utc,
              end_time: Time.now.utc + 5000,
              is_verified: false,
              click_count: 0,
              payment_id: payment._id.to_s,
              platform_id: platform._id.to_s
            }
          }.to_json, headers: { 'Content-Type': "application/json" }

          expect(response).to have_http_status(:created)
        end
      end

      describe "GET api/v1/promotions" do
        it "works!" do
          get "/api/v1/promotions"
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(title: "Test")._id.to_s
          get "/api/v1/promotions/#{id}"
          expect(response).to have_http_status(:ok)
        end
      end

      describe "PUT /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(title: "Test")._id.to_s
          put "/api/v1/promotions/#{id}", params: {
            promotion: {
              description: "Rspec Test - Modified",
              code: "CODE2",
              is_verified: true,
              click_count: 3
            }
          }.to_json, headers: { 'Content-Type': "application/json" }

          expect(response).to have_http_status(:ok)
        end
      end

      describe "DELETE /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(title: "Test")._id.to_s
          delete "/api/v1/promotions/#{id}"

          expect(response).to have_http_status(:no_content)
        end
      end

      Platform.where(name: "Test").destroy
      Payment.where(name: "Test").destroy
    end
  end
end
