require "rails_helper"

module Api
  module V1
    RSpec.describe Payment, type: :model do
      subject(:payment) do
        described_class.new(name: "Name", type: "Type", code: "Code")
      end
      it "is valid with valid attributes" do
        expect(payment).to be_valid
      end

      it "is not valid without a name" do
        payment.name = nil
        expect(payment).not_to be_valid
      end

      it "is not valid without a type" do
        payment.type = nil
        expect(payment).not_to be_valid
      end

      it "is not valid without a code" do
        payment.code = nil
        expect(payment).not_to be_valid
      end
    end
  end
end
