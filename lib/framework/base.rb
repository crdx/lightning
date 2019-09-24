module Lightning
    class Base < Sinatra::Base
        register Sinatra::Namespace

        # Ensure template output is automatically escaped.
        # Only applies to erb templates at the moment, unfortunately.
        set :erb, :escape_html => true

        # If using shotgun the session (and secret) is reset on each fork.
        # Set it to a known value during development.
        configure :development do
            set :session_secret, 'session_secret'
        end

        # Disable the set of automatically-imported Rack::Protection features.
        # We are minimalist, so let the user include the ones they want.
        # Certain ones pollute the session with tokens you may not even be using.
        disable :protection

        def self.set_app_file(file)
            set :app_file, file
        end

        def self.enable_session
            set :sessions, same_site: :lax, key: 'session'
        end

        def self.enable_csp(str)
            before do
                headers 'Content-Security-Policy' => str.lines.map(&:strip).join(' ')
            end
        end

        def self.enable_db
            Lightning::Database.connect_and_select
        end
    end
end
