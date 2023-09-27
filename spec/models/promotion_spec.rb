require "rails_helper"

module Api
  module V1
    RSpec.describe Promotion, type: :model do
      subject(:promotion) do
        described_class.new(
          title: "Title",
          description: "Description",
          code: "Code",
          platform_id: Platform.new(
            name: "Name",
            type: "Type",
            code: "Code"
          ),
          payment_id: Payment.new(
            name: "Name",
            type: "Type",
            code: "Code"
          ),
          start_time: DateTime.now,
          end_time: DateTime.now + 5000,
          is_verified: true,
          click_count: 0
        )
      end
      it "is valid with valid attributes" do
        expect(promotion).to be_valid
      end

      it "is not valid without a title" do
        promotion.title = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a description" do
        promotion.description = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a code" do
        promotion.code = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a start_time" do
        promotion.start_time = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a end_time" do
        promotion.end_time = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a payment_id" do
        promotion.payment_id = nil
        expect(promotion).not_to be_valid
      end

      it "is not valid without a platform_id" do
        promotion.platform_id = nil
        expect(promotion).not_to be_valid
      end
    end
  end
end
