ENV['RACK_ENV'] = 'test'

require 'rack/test'

def app
    Web
end
