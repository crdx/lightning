module Lightning
    class Middleware < Sinatra::Base
        def top_level
            request.path.split('/')[1]
        end
    end
end
