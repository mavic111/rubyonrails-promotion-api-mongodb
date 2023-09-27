# Load the Rails application.
require_relative "application"

env_file = File.join(Rails.root, 'config', 'local_env.yml')  
YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value  
end if File.exist?(env_file)

# Initialize the Rails application.
Rails.application.initialize!
