require 'rails_helper'

module Api
  module V1
    RSpec.describe Promotion, type: :model do
      subject {
        described_class.new(title: "Title", description: "Description", code: "Code", platform_id: Platform.new(name: "Name", type: "Type", code: "Code"), payment_id: Payment.new(name: "Name", type: "Type", code: "Code"), start_time: DateTime.now, end_time: DateTime.now + 5000, is_verified: true, click_count: 0)
      }
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
      it "is not valid without a title" do
        subject.title = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a description" do
        subject.description = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a code" do
        subject.code = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a start_time" do
        subject.start_time = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a end_time" do
        subject.end_time = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a payment_id" do
        subject.payment_id = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a platform_id" do
        subject.platform_id = nil
        expect(subject).to_not be_valid
      end
    end
  end
end

