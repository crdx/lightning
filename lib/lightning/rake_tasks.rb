require_relative '../lightning'

namespace :db do
    desc "Database: migrate"
    task :migrate do
        puts 'Migrating database'.yellow
        Lightning::DatabaseAction.migrate
    end

    desc "Database: rollback"
    task :rollback do
        puts 'Rolling back database'.yellow
        Lightning::DatabaseAction.rollback
    end

    desc "Database: create"
    task :create do
        puts 'Creating database'.yellow
        Lightning::DatabaseAction.create
    end

    desc "Database: drop"
    task :drop do
        puts 'Dropping database'.yellow
        Lightning::DatabaseAction.drop
    end

    desc "Database: reset"
    task :reset => [:drop, :create, :migrate]

    desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
    task :dump_schema do
        puts 'Dumping database schema'.yellow
        Lightning::DatabaseAction.dump_schema
    end
end

namespace :g do
    desc "Generate: migration"
    task :migration do
        puts 'Generating migration'.yellow

        if ARGV.length < 2
            raise 'Usage: rake g:migration <name>'.red
        end

        label = ARGV[1]
        timestamp = Time.now.strftime("%Y%m%d%H%M%S")
        path = "db/migrate/#{timestamp}_#{label}.rb"
        migration_class = label.split('_').map(&:capitalize).join

        File.open(path, 'w') do |file|
            file.write <<~EOF
                class #{migration_class} < Lightning::Migration
                    def change
                    end

                    # def up
                    # end
                    # def down
                    # end
                end
            EOF
        end

        puts "Migration #{path} created".green
        abort
    end
end
