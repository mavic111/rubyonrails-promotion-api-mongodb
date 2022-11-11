require 'rails_helper'

module Api
  module V1
    RSpec.describe Promotion, type: :model do
      subject {
        described_class.new(title: "Title", description: "Description", code: "Code", platform_id: Platform.first._id.to_s, payment_id: Payment.first._id.to_s, start_time: DateTime.now, end_time: DateTime.now + 5000, is_verified: true, click_count: 0)
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
      it "is not valid without a is_verified" do
        subject.is_verified = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without a click_count" do
        subject.click_count = nil
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

