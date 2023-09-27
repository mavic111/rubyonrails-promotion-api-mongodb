module Api
  module V1
    class Payment
      include Mongoid::Document
      include Mongoid::Timestamps
      store_in collection: "payments"
      field :name, type: String
      field :type, type: String
      field :code, type: String
      has_many :promotions, inverse_of: :payment, dependent: :destroy
      validates :name, presence: true
      validates :type, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
    end
  end
end
