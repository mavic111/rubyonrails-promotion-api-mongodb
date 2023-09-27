require "docs/v1/payment"

module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: %i[show update destroy]
      include Docs::V1::Payment

      # GET /v1/payments
      api :GET, "/v1/payments", "Get all payments data"
      param :page, :number, desc: "page of the requested data"
      param :limit, :number, desc: "limit of the requested data"
      returns :payment
      def index
        @pagy, @records = pagy_get_items(Payment.all.order(created_at: 1), { items: params[:limit] || 10, offset: 0 })
        if @records
          render json: { code: 200, status: "OK", data: @records, page: @pagy.page, next: @pagy.next,
                         pages: @pagy.pages, count: @pagy.in, limit: @pagy.items }
        else
          render json: { code: 404, status: "NOT_FOUND", data: [] }, status: :not_found
        end
      end

      # GET /v1/payments/1
      api :GET, "/v1/payments/:id", "Get payment data"
      param :id, String, desc: "id of the requested data", required: true
      def show
        if @payment
          render json: { code: 200, status: "OK", data: @payment }
        else
          render json: { code: 404, status: "NOT_FOUND", id: params[:id] }, status: :not_found
        end
      end

      # POST /payments
      api :POST, "/v1/payments", "Add payment data"
      param_group :payment
      def create
        @payment = Payment.new(payment_params)
        if @payment.save
          render json: @payment, status: :created, location: @payment
        else
          render json: @payment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /payments/1
      api :PUT, "/v1/payments/:id", "Update payment data"
      param :id, String, desc: "id of the data", required: true
      param_group :payment
      def update
        if @payment.update(payment_params)
          render json: @payment
        else
          render json: @payment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /payments/1
      api :DELETE, "/v1/payments/:id", "Delete payment data"
      param :id, String, desc: "id of the data", required: true
      def destroy
        @payment.destroy
      rescue Mongoid::Errors::DeleteRestriction
        render json: { code: 403, message: "Cannot delete due to restriction" }, status: :forbidden
      rescue StandardError
        render json: { code: 500, message: "Internal Server Error" }, status: :internal_server_error
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_payment
        @payment = Payment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def payment_params
        params.require(:payment).permit(:name, :type, :code)
      end
    end
  end
end
