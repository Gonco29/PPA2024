class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all
    @products = @products.where(category: params[:category]) if params[:category].present?
    @products = @products.where(subcategory: params[:subcategory]) if params[:subcategory].present?
    @products = @products.search_by(params[:query]) if params[:query].present?
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.where(subcategory: @product.subcategory).where.not(id: @product.id).limit(5)
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: 'Producto creado con éxito.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product

    if params[:remove_photos].present?
      params[:remove_photos].each { |photo_id| @product.photos.find(photo_id).purge }
    end

    @product.photos.attach(product_params[:photos]) if product_params[:photos].present?

    if @product.update(product_params.except(:photos))
      redirect_to @product, notice: 'Producto actualizado con éxito.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to products_url, notice: 'Producto eliminado con éxito.'
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
