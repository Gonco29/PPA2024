class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @random_products = Product.order("RANDOM()").limit(5)
    @promoted_products = Product.where(on_sale: true).limit(5)
  end

  def contact
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    message = params[:message]
    attachment = params[:attachment]

    ContactMailer.contact_email(name, email, phone, message, attachment).deliver_now
    redirect_to root_path, notice: 'Tu mensaje ha sido enviado con éxito.'
  end
end
