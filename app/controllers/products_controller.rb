class ProductsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show, :promotions]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @products = Product.all
    @products = @products.where(category: params[:category]) if params[:category].present?
    @products = @products.where(subcategory: params[:subcategory]) if params[:subcategory].present?

    # Filtro por búsqueda de texto
    if params[:query].present?
      @products = @products.search_by(params[:query])
    end
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.where(category: @product.subcategory).where.not(id: @product.id).limit(5)
  end

  # Acciones restringidas a usuarios administradores
  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product

    # Eliminar fotos marcadas para eliminación
    if params[:remove_photos].present?
      params[:remove_photos].each do |photo_id|
        @product.photos.find(photo_id).purge
      end
    end

    # Adjuntar nuevas fotos
    if product_params[:photos].present?
      @product.photos.attach(product_params[:photos])
    end

    if @product.update(product_params.except(:photos))
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product

    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def promotions
    @promoted_products = Product.where(on_sale: true)
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :price, :category, :subcategory, :details, :stock, :promo_text,
      :on_sale, :discount_percentage, :promotional_price,
      :sku, :warranty, :power, :controls_included, :rack_meters,
      :arms, :usage_type, :gate_max_length, :indication, :installation_included,
      photos: []
    )
  end
end
