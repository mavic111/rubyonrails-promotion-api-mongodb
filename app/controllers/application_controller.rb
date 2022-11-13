class ApplicationController < ActionController::API
    include Pagy::Backend
    def pagy_get_items(collection, vars={})
        begin
          pagy = Pagy.new(count: collection.count, page: params[:page], **vars)
          [pagy, collection.offset(pagy.offset).limit(pagy.items)]
        rescue
          [nil, nil]
        end
    end
end

