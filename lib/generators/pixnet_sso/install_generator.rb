require 'rails/generators'
require 'rails/generators/migration'

module PixnetSso
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)


    # Implement the required interface for Rails::Generators::Migration.
    # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
    def self.next_migration_number(dirname) #:nodoc:
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def create_migration_file
      template 'user.rb', "app/models/#{user_model.singularize.underscore}.rb"
      migration_template 'migration.rb', "db/migrate/create_#{user_model.tableize}.rb"


      if openid_enabled.downcase == 'y'
        template 'openid_associate.rb', "app/models/#{openid_model.singularize.underscore}.rb"
        migration_template 'migration_openid.rb', "db/migrate/create_#{openid_model.tableize}.rb"
      end

      template 'config.rb', 'config/initializers/pixnet-sso.rb'
    end

    def user_model
      @user_model ||= ask('What is your user model name?').classify
    end

    def openid_model
      @openid_model ||= ask('What is your openid model name?').classify
    end

    def openid_enabled
      @openid_enabled ||= ask("Would you want to enable OpenID ?(y/N)")
    end
  end
end


