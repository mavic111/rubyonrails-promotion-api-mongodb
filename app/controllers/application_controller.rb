class ApplicationController < ActionController::API
  include Pagy::Backend
  def pagy_get_items(collection, vars = {})
    pagy = Pagy.new(count: collection.count, page: params[:page], **vars)
    [pagy, collection.offset(pagy.offset).limit(pagy.items)]
  rescue StandardError
    [nil, nil]
  end
end
