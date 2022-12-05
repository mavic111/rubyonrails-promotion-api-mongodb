module Api
  module V1
    class Promotion
      include Mongoid::Document
      include Mongoid::Timestamps
      before_update :record_activity
      before_validation :set_default_value
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
        attrs["platform"] = { _id: self.platform._id.to_s, name: self.platform.name } 
        attrs["payment"] = {_id: self.payment._id.to_s, name: self.payment.name}
        attrs.delete("platform_id")
        attrs.delete("payment_id")
        attrs
      end

      private

      def record_activity
        # record an activity
        if self.payment_id_changed?
          @old_payment_id = self.payment_id_was
        end
        if self.platform_id_changed?
          @old_platform_id = self.platform_id_was
        end
      end

      def set_default_value
        self.click_count = 0 if self.click_count == nil
        self.is_verified = false if self.is_verified == nil
      end
    end
  end
end

