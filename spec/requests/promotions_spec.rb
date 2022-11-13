require 'rails_helper'

module Api
  module V1
    RSpec.describe "Promotions", type: :request do
      Promotion.where(:title => "Test Title").destroy
      describe "POST /api/v1/promotions" do
        it "works!" do
          payment =  Payment.new(name: "Test Name", type: "Test Type", code: "Test Code")
          platform = Platform.new(name: "Test Name", type: "Test Type", code: "Test Code")
          payment.save
          platform.save
          post "/api/v1/promotions", params: {
            promotion: {
              title: "Test Title",
              description: "Test Description",
              code: "Test Code",
              start_time: DateTime.now,
              end_time: DateTime.now,
              is_verified: true,
              click_count: 0,
              payment_id: payment._id.to_s,
              platform_id: platform._id.to_s
            }
          }
          expect(response).to have_http_status(201)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:title]).to eq("Test Title")
          expect(json[:description]).to eq("Test Description")
          expect(json[:code]).to eq("Test Code")
          expect(json[:is_verified]).to eq(true)
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
          
          id = Promotion.find_by(:title => "Test Title")._id.to_s 
          get "/api/v1/promotions/#{id}" 
          expect(response).to have_http_status(200)
        end
      end  
      describe "PUT /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(:title => "Test Title")._id.to_s
          put "/api/v1/promotions/#{id}", params: {
            promotion: {
              description: "New Test Description",
              code: "New Test Code",
              is_verified: true,
              click_count: 3,
            }
          }
          expect(response).to have_http_status(200)

          json = JSON.parse(response.body).deep_symbolize_keys

          expect(json[:title]).to eq("Test Title")
          expect(json[:description]).to eq("New Test Description")
          expect(json[:code]).to eq("New Test Code")
          expect(json[:is_verified]).to eq(true)
          expect(json[:click_count]).to eq(3)
        end
      end
      describe "DELETE /api/v1/promotions/:id" do
        it "works!" do
          id = Promotion.find_by(:code => "New Test Code")._id.to_s
          delete "/api/v1/promotions/#{id}"

          expect(response).to have_http_status(204)
        end
      end
      Platform.where(:name => "Test Name").destroy
      Payment.where(:name => "Test Name").destroy
    end
  end
end

