# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.search_by(params[:query])
    else
      @products = Product.all
    end
    authorize @products
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
    @related_products = Product.where(category: @product.category).where.not(id: @product.id).limit(5)
  end

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

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product

    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category, :details, :stock, :on_sale, :discount_percentage, :promotional_price, photos: [])
  end
end
