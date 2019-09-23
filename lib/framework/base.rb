module Lightning
    class Base < Sinatra::Base
        register Sinatra::Namespace

        set :erb, :escape_html => true

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
