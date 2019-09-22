module Lightning
    class Base < Sinatra::Base
        self.abstract_class = true

        register Sinatra::Namespace
        helpers Sinatra::RequiredParams

        configure :development do
            register Sinatra::Reloader
        end

        # Use <%== x %> to output without escaping.
        set :erb, :escape_html => true

        def self.inherited(cls)
            puts "Loaded #{cls}".green
            super cls
        end

        def self.set_app_file(file)
            set :app_file, file
        end

        def self.enable_session
            set :sessions, same_site: :lax, key: 'session'
        end

        def self.enable_csp(**csp)
            use Rack::Protection::ContentSecurityPolicy, **csp
        end

        def self.enable_db
            Lightning::Database.connect_and_select
        end
    end
end
