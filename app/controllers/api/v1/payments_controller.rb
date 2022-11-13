module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: %i[ show update destroy ]
      
      # GET /payments
      def index
        @pagy, @records = pagy_get_items(Payment.all.order(created_at: 1), {items: params[:limit] || 10, offset: 0})
        if @records
          render json: {code: 200, status: "OK", data: @records, page: @pagy.page, next: @pagy.next, count: @pagy.in, limit: @pagy.items}
        else
          render json: {code: 200, status: "OK", data: []}
        end
      end

      # GET /payments/1
      def show
        render json: {code: 200, status: "OK", data: @payment}
      end

      # POST /payments
      def create
        @payment = Payment.new(payment_params)

        if @payment.save
          render json: @payment, status: :created, location: @payment
        else
          render json: @payment.errors, status: :unprocessable_entity
        end
      end
      
      # PATCH/PUT /payments/1
      def update
        if @payment.update(payment_params)
          render json: @payment
        else
          render json: @payment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /payments/1
      def destroy
        @payment.destroy
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
