class ProductsController < EntitiesController
  before_filter :set_current_tab
  before_filter :auto_complete, :only => :auto_complete

  # GET /products
  # GET /products.xml                                                   HTML
  #----------------------------------------------------------------------------
  def index
    @products = get_products(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/new
  # GET /products/new.xml                                               AJAX
  #----------------------------------------------------------------------------
  def new
    @product = Product.new()

    respond_to do |format|
      format.js   # new.js.rjs
      format.xml  { render :xml => @product }
    end
  end

  # GET /contacts/1
  # AJAX /contacts/1
  #----------------------------------------------------------------------------
  def show
    @comment = Comment.new
    @timeline = timeline(@product)
    respond_with(@product)
  end

  # GET /products/1/edit                                                AJAX
  #----------------------------------------------------------------------------
  def edit
    @product = Product.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = Product.find($1)
    end

  rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @product
  end

  # POST /products
  # POST /products.xml                                                  AJAX
  #----------------------------------------------------------------------------
  def create
    @product = Product.new(params[:product])

    respond_with(@product) do |format|
      if @product.save(params)
        @products = get_products if called_from_index_page?
      end
    end

  end

  # PUT /products/1
  # PUT /products/1.xml                                                 AJAX
  #----------------------------------------------------------------------------
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.js   # update.js.rjs
        format.xml  { head :ok }
      else
        format.js   # update.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # GET /products/1/confirm                                             AJAX
  #----------------------------------------------------------------------------
  def confirm
    @product = Product.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # DELETE /products/1
  # DELETE /products/1.xml                                              AJAX
  #----------------------------------------------------------------------------
  def destroy
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.destroy
        format.js   # destroy.js.rjs
        format.xml  { head :ok }
      else
        flash[:warning] = t(:msg_cant_delete_product, @product.name)
        format.js   # destroy.js.rjs
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def redraw
    current_user.pref[:products_per_page] = params[:per_page] if params[:per_page]

    # Sorting and naming only: set the same option for Leads if the hasn't been set yet.
    if params[:sort_by]
      current_user.pref[:products_sort_by] = Product::sort_by_map[params[:sort_by]]
    end
    if params[:naming]
      current_user.pref[:products_naming] = params[:naming]
    end

    @products = get_products(:page => 1, :per_page => params[:per_page]) # Start on the first page.
    set_options # Refresh options

    respond_with(@products) do |format|
      format.js { render :index }
    end
  end


  private
  #----------------------------------------------------------------------------
  alias :get_products :get_list_of_records

end
