class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @random_products = Product.order("RANDOM()").limit(5)
    @promoted_products = Product.where(on_sale: true).limit(5)
  end
end
