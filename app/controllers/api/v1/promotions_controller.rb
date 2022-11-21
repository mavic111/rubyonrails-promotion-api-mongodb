require 'docs/v1/promotion'

module Api
  module V1
    class PromotionsController < ApplicationController
      before_action :set_promotion, only: %i[ show update destroy ]
      include Docs::V1::Promotion

      # GET /v1/promotions
      api :GET, '/v1/promotions', 'Get all promotions data'
      param :page, :number, desc: 'page of the requested data'
      param :limit, :number, desc: 'limit of the requested data'
      def index
        @pagy, @records = pagy_get_items(Promotion.all.order(created_at: 1), {items: params[:limit] || 10, offset: 0})
        if @records
          render json: {code: 200, status: "OK", data: @records, page: @pagy.page, next: @pagy.next, pages: @pagy.pages, count: @pagy.in, limit: @pagy.items}
        else
          render json: {code: 404, status: "NOT_FOUND", page: params[:page]}
        end
      end
    
      # GET /promotions/1
      api :GET, '/v1/promotions/:id', 'Get promotion data'
      param :id, String, desc: 'id of the requested data', required: true
      def show
        if @promotion
          render json: {code: 200, status: "OK", data: @promotion}
        else
          render json: {code: 404, status: "NOT_FOUND", id: params[:id]}, status: :not_found
        end
      end
    
      # POST /promotions
      api :POST, '/v1/promotions', 'Add promotion data'
      param_group :promotion
      def create
        @promotion = Promotion.new(promotion_params)
        if @promotion.save
          render json: @promotion, status: :created, location: @promotion
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /v1/promotions/1
      api :PUT, '/v1/promotions/:id', 'Update promotion data'
      param :id, String, desc: 'id of the data', required: true
      param_group :promotion
      def update
        if @promotion.update(promotion_params)
          render json: @promotion
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /v1/promotions/1
      api :DELETE, '/v1/promotions/:id', 'Delete promotion data'
      param :id, String, desc: 'id of the data', required: true
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
