require 'docs/v1/platform'

module Api
  module V1
    class PlatformsController < ApplicationController
      before_action :set_platform, only: %i[ show update destroy ]
      include Docs::V1::Platform

      # GET /v1/platforms
      api :GET, '/v1/platforms', 'Get all platforms data'
      param :page, :number, desc: 'page of the requested data'
      param :limit, :number, desc: 'limit of the requested data'
      def index
        @pagy, @records = pagy_get_items(Platform.all.order(created_at: 1), {items: params[:limit] || 10, offset: 0})
        if @records
          render json: {code: 200, status: "OK", data: @records, page: @pagy.page, next: @pagy.next, count: @pagy.in, limit: @pagy.items}
        else
          render json: {code: 200, status: "OK", data: []}
        end
      end
    
      # GET /v1/platforms/1
      api :GET, '/v1/platforms/:id', 'Get platform data'
      param :id, String, desc: 'id of the requested data', required: true
      def show
        if @platform
          render json: {code: 200, status: "OK", data: @platform}
        else
          render json: {code: 404, status: "NOT_FOUND", id: params[:id]}, status: :not_found
        end
      end
    
      # POST /v1/platforms
      api :POST, '/v1/platforms', 'Add platform data'
      param_group :platform
      def create
        @platform = Platform.new(platform_params)
    
        if @platform.save
          render json: @platform, status: :created, location: @platform
        else
          render json: @platform.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /v1/platforms/1
      api :PUT, '/v1/platforms/:id', 'Update platform data'
      param :id, String, desc: 'id of the data', required: true
      param_group :platform
      def update
        if @platform.update(platform_params)
          render json: @platform
        else
          render json: @platform.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /v1/platforms/1
      api :DELETE, '/v1/platforms/:id', 'Delete platform data'
      param :id, String, desc: 'id of the data', required: true
      def destroy
        begin
          @platform.destroy
        rescue Mongoid::Errors::DeleteRestriction
          render json: {code: 403, message: "Cannot delete due to restriction"},status: :forbidden
        rescue
          render json: {code: 500, message: "Internal Server Error"},status: :internal_server_error
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_platform
          @platform = Platform.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def platform_params
          params.require(:platform).permit(:name, :type, :code)
        end
    end
  end
end
