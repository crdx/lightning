require 'colorize'

rack_env = ENV['RACK_ENV']

if rack_env.nil? || !%w[development production test].include?(rack_env)
    puts "RACK_ENV invalid: '#{rack_env}'. Ensure it is one of: production, development, test".red
    exit 1
end

require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sinatra/required_params'

require 'rack'
require 'rack/protection'
require 'active_record'
require 'erubis'
require 'dotenv'
require 'logger'
require 'json'

banner = "Environment #{rack_env.bold}"

case rack_env
    when 'production'  then puts banner.red
    when 'development' then puts banner.yellow
    when 'test'        then puts banner.cyan
end

env_file = rack_env + '.env'

unless File.exist?(env_file)
    puts 'File not found: ./%s'.red % env_file
    exit 1
else
    Dotenv.load env_file
    puts 'Loaded %s'.green % env_file
end

require_relative 'framework/base'
require_relative 'framework/migration'
require_relative 'framework/model'
require_relative 'framework/test'
require_relative 'framework/db'

if ENV['DEBUG']
    Lightning::Database.enable_logging
end
