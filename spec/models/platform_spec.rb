require "rails_helper"

module Api
  module V1
    RSpec.describe Platform, type: :model do
      subject(:platform) do
        described_class.new(name: "Name", type: "Type", code: "Code")
      end
      it "is valid with valid attributes" do
        expect(platform).to be_valid
      end

      it "is not valid without a name" do
        platform.name = nil
        expect(platform).not_to be_valid
      end

      it "is not valid without a type" do
        platform.type = nil
        expect(platform).not_to be_valid
      end

      it "is not valid without a code" do
        platform.code = nil
        expect(platform).not_to be_valid
      end
    end
  end
end
