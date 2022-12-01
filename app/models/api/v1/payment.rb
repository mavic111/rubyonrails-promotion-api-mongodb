module Api
  module V1
    class Payment
      include Mongoid::Document
      include Mongoid::Timestamps
      store_in collection: "payments"
      field :name, type: String
      field :type, type: String
      field :code, type: String
      field :promotion_ids, type: Array
      has_and_belongs_to_many :promotions, dependent: :restrict_with_exception
      validates :name, presence: true
      validates :type, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
      def as_json(*args)
        attrs = super
        attrs["promotion_ids"] = self.promotion_ids.collect {|x| x.to_s} if attrs.has_key?("promotion_ids")
        attrs
      end
    end
  end
end

