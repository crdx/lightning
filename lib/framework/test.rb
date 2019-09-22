module Lightning
    module Test
        include Rack::Test::Methods if defined?(Rack::Test)
    end
end
