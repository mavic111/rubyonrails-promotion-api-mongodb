Apipie.configure do |config|
  config.app_name                = "Rails Promotion"
  config.copyright               = "Muhammad Nizamuddin Aulia"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/docs"
  config.app_info                = "Ruby on Rails API"
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join("app/controllers/**/*.rb").to_s
  config.default_version         = "1.0"
end
