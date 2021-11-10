module Lightning
    class DatabaseDetails
        def self.database_name
            ENV['DATABASE_NAME']
        end

        def self.database_host
            ENV['DATABASE_HOST'] || 'localhost'
        end

        def self.database_user
            ENV['DATABASE_USER']
        end

        def self.database_pass
            ENV['DATABASE_PASS'] || ''
        end

        def self.default_charset
            'utf8mb4'
        end

        def self.basic
            return {
                adapter:  'mysql2',
                host:     self.database_host,
                username: self.database_user,
                password: self.database_pass,
                encoding: self.default_charset
            }
        end

        def self.full
            basic.merge(database: self.database_name)
        end
    end

    class Database
        def self.enable_logging
            ActiveRecord::Base.logger = Logger.new(STDOUT)
        end

        def self.connect
            ActiveRecord::Base.establish_connection(DatabaseDetails.basic)
        end

        def self.connect_and_select
            ActiveRecord::Base.establish_connection(DatabaseDetails.full)
        end
    end

    class DatabaseAction
        def self.migrate
            Database.enable_logging
            Database.connect_and_select

            ActiveRecord::Base.connection.migration_context.migrate

            # Use this only when we have a task for loading from this schema.
            # Rake::Task["db:dump_schema"].invoke
        end

        def self.rollback
            Database.enable_logging
            Database.connect_and_select

            ActiveRecord::Base.connection.migration_context.rollback

            # Use this only when we have a task for loading from this schema.
            # Rake::Task["db:dump_schema"].invoke
        end

        def self.create
            Database.enable_logging
            Database.connect

            ActiveRecord::Base.connection.create_database(
                DatabaseDetails.database_name,
                charset: DatabaseDetails.default_charset
            )
        end

        def self.drop
            Database.enable_logging
            Database.connect_and_select

            ActiveRecord::Base.connection.drop_database(
                DatabaseDetails.database_name
            )
        end

        def self.dump_schema
            Database.enable_logging
            Database.connect_and_select

            require 'active_record/schema_dumper'
            File.open('db/schema.rb', 'w:utf-8') do |file|
                ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
            end
        end
    end
end
