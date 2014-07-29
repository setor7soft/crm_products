module ProductsHelper

  def brief_product_info(product)
    text = ""
    name = product.name
    manufacturer = product.manufacturer
    price = product.price
    account_text = ""
    account_text = link_to_if(can?(:read, product), h(product.code), product_path(product)) if product.present?

    text << if name.present? && price.present? && manufacturer.present?
          t(:product_with_name_price_manufacturer, :name => h(name), :price => h(price), :manufacturer => h(manufacturer))
        elsif name.present? && price.present?
          t(:product_with_name_price, :name => h(name), :price => h(price))
        elsif name.present?
          t(:product_with_name, :name => h(name))
        else
          ""
        end
    text.html_safe
  end

  # Output account with title and department
  # - a helper so it is easy to override in plugins that allow for several accounts
  #----------------------------------------------------------------------------
  def product_with_code_and_manufacturer(product)
    text = if product.code.present? && product.manufacturer.present?
        tempStr = ""
        tempStr << "<b>#{t(:code)}:</b> #{product.code}"
        tempStr << "<b>#{t(:manufacturer)}:</b> #{product.manufacturer}<br>"
        tempStr
      elsif  product.code.present?
        "<b>#{t(:code)}:</b> #{product.code}<br>"
      elsif product.manufacturer.present?
        "<b>#{t(:manufacturer)}:</b> #{product.manufacturer}<br>"
      else
        ""
      end
    text.html_safe
  end

end
