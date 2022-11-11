require 'rails_helper'

module Api
  module V1
    RSpec.describe Payment, type: :model do
      #puts "[Model] Payment"
      subject {
        described_class.new(name: "Name", type: "Type", code: "Code")
      }
      it "is valid with valid attributes" do
        #puts "is valid with valid attributes"
        expect(subject).to be_valid
      end
      it "is not valid without a name" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a type" do
        subject.type = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a code" do
        subject.code = nil
        expect(subject).to_not be_valid
      end
    end
  end
end

