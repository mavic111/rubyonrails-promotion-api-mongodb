module Api
  module V1
    class Promotion
      include Mongoid::Document
      include Mongoid::Timestamps
      after_create :add_associations
      after_update :update_associations
      before_update :record_activity
      before_destroy :delete_associations
      before_validation :set_default_value
      store_in collection: "promotions"
      field :title, type: String
      field :description, type: String
      field :code, type: String
      field :start_time, type: Time
      field :end_time, type: Time
      field :is_verified, type: Mongoid::Boolean
      field :click_count, type: Integer
      belongs_to :payment
      belongs_to :platform
      validates :title, presence: true
      validates :description, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
      validates :start_time, presence: true
      validates :end_time, presence: true
      def as_json(*args)
        attrs = super
        attrs["platform_id"] = self.platform_id.to_s if attrs.has_key?("platform_id") && self.platform_id != nil 
        attrs["payment_id"] = self.payment_id.to_s if attrs.has_key?("payment_id") && self.payment_id != nil 
        attrs
      end

      private
      def add_associations
        #puts "Adding association with a payment".yellow
        payment.promotions << self if payment.promotions.exclude?(self)
        #puts "Adding association with a platform".yellow
        platform.promotions << self if platform.promotions.exclude?(self)
      end

      def delete_associations
        #puts "Deleting association with a payment"
        payment.promotions.delete(self) if payment.promotions.include?(self)
        #puts "Deleting association with a platform"
        platform.promotions.delete(self) if platform.promotions.include?(self) 
      end

      def update_associations
        if @old_payment_id
          #puts "Deleting old association with a payment".yellow
          old_payment = Payment.find(@old_payment_id)
          old_payment.promotions.delete(self) if old_payment.promotions.include?(self) 
          #puts "Adding new association with a payment".yellow
          payment.promotions << self if payment.promotions.exclude?(self)
        end
        if @old_platform_id
          #puts "Deleting old association with a platform".yellow
          old_platform = Platform.find(@old_platform_id)
          old_platform.promotions.delete(self) if old_platform.promotions.include?(self) 
          #puts "Adding new association with a platform".yellow
          platform.promotions << self if platform.promotions.exclude?(self)
        end
      end

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

