# Load the Rails application.
require_relative "application"

env_file = Rails.root.join("config/local_env.yml").to_s
if File.exist?(env_file)
  YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
  end
end

# Initialize the Rails application.
Rails.application.initialize!
