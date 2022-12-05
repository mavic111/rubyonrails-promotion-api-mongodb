require 'rails_helper'

module Api
  module V1
    RSpec.describe "Promotions", type: :request do
      Promotion.where(:title => "Test").destroy
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
              start_time: Time.now,
              end_time: Time.now,
              is_verified: false,
              click_count: 0,
              payment_id: payment._id.to_s,
              platform_id: platform._id.to_s
            }
          }.to_json,
          headers: {
            'Content-Type': 'application/json'
          }

          expect(response).to have_http_status(201)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:title]).to eq("Test")
          expect(json[:description]).to eq("Rspec Test")
          expect(json[:code]).to eq("CODE")
          expect(json[:is_verified]).to eq(false)
          expect(json[:click_count]).to eq(0)
        end
      end
      describe "GET api/v1/promotions" do
        it "works!" do
          get "/api/v1/promotions"
          expect(response).to have_http_status(200)
        end
      end
      describe "GET /api/v1/promotions/:id" do
        it "works!" do
          
          id = Promotion.find_by(:title => "Test")._id.to_s 
          get "/api/v1/promotions/#{id}" 
          expect(response).to have_http_status(200)
        end
      end  
      describe "PUT /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(:title => "Test")._id.to_s
          put "/api/v1/promotions/#{id}", params: {
            promotion: {
              description: "Rspec Test - Modified",
              code: "CODE2",
              is_verified: true,
              click_count: 3,
            }
          }.to_json,
          headers: {
            'Content-Type': 'application/json'
          }

          expect(response).to have_http_status(200)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:title]).to eq("Test")
          expect(json[:description]).to eq("Rspec Test - Modified")
          expect(json[:code]).to eq("CODE2")
          expect(json[:is_verified]).to eq(true)
          expect(json[:click_count]).to eq(3)
        end
      end
      describe "DELETE /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(:title => "Test")._id.to_s
          delete "/api/v1/promotions/#{id}"

          expect(response).to have_http_status(204)
        end
      end
      Platform.where(:name => "Test").destroy
      Payment.where(:name => "Test").destroy
    end
  end
end

