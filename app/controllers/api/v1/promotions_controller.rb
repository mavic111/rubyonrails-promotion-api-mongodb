module Api
  module V1
    class PromotionsController < ApplicationController
      before_action :set_promotion, only: %i[ show update destroy ]

      # GET /promotions
      def index
        @pagy, @records = pagy_get_items(Promotion.all.order(created_at: 1), {items: params[:limit] || 10, offset: 0})
        if @records
          render json: {code: 200, status: "OK", data: @records, page: @pagy.page, next: @pagy.next, count: @pagy.in, limit: @pagy.items}
        else
          render json: {code: 200, status: "OK", data: []}
        end
      end
    
      # GET /promotions/1
      def show
        render json: @promotion
      end
    
      # POST /promotions
      def create
        @promotion = Promotion.new(promotion_params)
        
        if @promotion.save
          update_payment = Payment.find(@promotion[:payment_id])
          update_payment.push(promotion_ids: [@promotion[:id]])
          update_platform = Platform.find(@promotion[:platform_id])
          update_platform.push(promotion_ids: [@promotion._id])
          render json: @promotion, status: :created, location: @promotion
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /promotions/1
      def update
        promotion_id = @promotion[:id]
        old_payment_id = @promotion[:payment_id]
        new_payment_id = params[:payment_id]
        old_platform_id = @promotion[:platform_id]
        new_platform_id = params[:platform_id]
        if @promotion.update(promotion_params)
          if new_payment_id && new_payment_id != old_payment_id
            old_payment = Payment.find(old_payment_id)
            old_payment.pull(promotion_ids: [promotion_id])
            new_payment = Payment.find(new_payment_id)
            new_payment.push(promotion_ids: [promotion_id])
          end
          if new_platform_id && new_platform_id != expired_platform_id
            old_platform = Platform.find(old_platform_id)
            old_platform.pull(promotion_ids: [promotion_id])
            new_platform = Platform.find(new_platform_id)
            new_platform.push(promotion_ids: [promotion_id])
          end
          render json: @promotion
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /promotions/1
      def destroy
        @promotion.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_promotion
          @promotion = Promotion.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def promotion_params
          params.require(:promotion).permit(:title, :description, :code, :start_time, :end_time, :is_verified, :click_count, :payment_id, :platform_id)
        end
    end
  end
end
