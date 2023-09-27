module Api
  module V1
    class Promotion
      include Mongoid::Document
      include Mongoid::Timestamps
      before_save :set_default_value
      before_update :record_activity
      store_in collection: "promotions"
      field :title, type: String
      field :description, type: String
      field :code, type: String
      field :start_time, type: Time
      field :end_time, type: Time
      field :is_verified, type: Mongoid::Boolean
      field :click_count, type: Integer
      belongs_to :payment, inverse_of: :promotions, autosave: true
      belongs_to :platform, inverse_of: :promotions, autosave: true
      validates :title, presence: true
      validates :description, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
      validates :start_time, presence: true
      validates :end_time, presence: true

      def as_json(*args)
        attrs = super
        attrs["platform"] = { _id: platform._id.to_s, name: platform.name }
        attrs["payment"] = { _id: payment._id.to_s, name: payment.name }
        attrs.delete("platform_id")
        attrs.delete("payment_id")
        attrs
      end

      private

      def record_activity
        # record an activity
        @old_payment_id = payment_id_was if payment_id_changed?
        return unless platform_id_changed?

        @old_platform_id = platform_id_was
      end

      def set_default_value
        self.click_count = 0 if click_count.nil?
        self.is_verified = false if is_verified.nil?
      end
    end
  end
end
