module Api
  module V1
    class Promotion
      include Mongoid::Document
      include Mongoid::Timestamps
      store_in collection: "promotions"
      field :title, type: String
      field :description, type: String
      field :code, type: String
      field :start_time, type: Time
      field :end_time, type: Time
      field :is_verified, type: Mongoid::Boolean
      field :click_count, type: Integer
      belongs_to :payment, autosave: true
      belongs_to :platform, autosave: true
      validates :title, presence: true
      validates :description, presence: true
      validates :code, presence: true, uniqueness: { case_sensitive: false }
      validates :start_time, presence: true
      validates :end_time, presence: true
      validates :is_verified, presence: true
      validates :click_count, presence: true
    end
  end
end

