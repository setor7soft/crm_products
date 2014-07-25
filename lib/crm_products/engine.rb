module CrmProducts
  class Engine < ::Rails::Engine

    config.to_prepare do
      require 'crm_products/crm_products_model.rb'
      require 'crm_products/crm_products_view_helpers'
      require 'crm_products/crm_products_view_hooks'

    end

    #config.generators do |g|
    #  g.test_framework      :rspec,        :fixture => false
    #  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    #  g.assets false
    #  g.helper false
    #end

  end
end
