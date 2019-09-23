module Lightning
    class Base < Sinatra::Base
        register Sinatra::Namespace
        helpers Sinatra::RequiredParams

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

        def self.enable_csp(str)
            before do
                str = str.lines.map(&:strip).join(' ')
                headers 'Content-Security-Policy' => str
            end
        end

        def self.enable_db
            Lightning::Database.connect_and_select
        end
    end
end
