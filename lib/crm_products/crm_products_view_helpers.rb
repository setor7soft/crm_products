module CrmProducts
  module ViewHelpers

    # Generate product links for use on asset index pages.
    #----------------------------------------------------------------------------
    def products_for_index(model)
      model.class.to_s.constantize.find(model.id).products.inject([]) do |arr, product|
        arr << link_to(product.name, product_path(product))
      end.join(", ")
    end

    # Generate the collection select for edit
    #----------------------------------------------------------------------------
    def get_products_colletion_select
      model = self.controller_name.singularize
      @product = Product.find(:all)
      collection_select( model,
                         :product_ids,
                         @product ,
                         :id,
                         :name,
                         { },
                         { :multiple => true, :size => '10', :style => "width:100%", :class => 'select2' })

    end

  end
end

ActionView::Base.send(:include, CrmProducts::ViewHelpers)
