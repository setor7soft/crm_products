require 'rails/generators/migration'

module CrmProducts
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_product_assets.rb", "db/migrate/create_product_assets.rb"
        migration_template "create_products.rb", "db/migrate/create_products.rb"
        migration_template "add_subscribed_users_to_products.rb", "db/migrate/add_subscribed_users_to_products.rb"
      end
    end
  end
end
