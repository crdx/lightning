ENV['RACK_ENV'] = 'test'

require 'rack/test'

def app
    Web
end

require_relative '../framework/test.rb'
include Lightning::Test
