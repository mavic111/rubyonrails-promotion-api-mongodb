module Api
  module V1
    class Payment
      include Mongoid::Document
      include Mongoid::Timestamps
      store_in collection: "payments"
      field :name, type: String
      field :type, type: String
      field :code, type: String
      has_and_belongs_to_many :promotions
      validates :name, presence: true
      validates :type, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
    end
  end
end

