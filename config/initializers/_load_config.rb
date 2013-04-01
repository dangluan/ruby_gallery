APP_CONFIG = {development: {}, test: {}, staging: {}, production: {}} if defined?(APP_CONFIG) == false

if File.exists?("#{Rails.root}/config/config.yml")
  APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env].symbolize_keys
end