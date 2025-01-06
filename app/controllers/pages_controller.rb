class PagesController < ApplicationController
  def home
    @random_products = Product.order("RANDOM()").limit(5)
    @promoted_products = Product.where(on_sale: true).limit(5)
    @google_api_key = ENV['GOOGLE_API_KEY']
  end

  def contact
    if request.post?
      # Procesar el formulario
      name = params[:name]
      email = params[:email]
      phone = params[:phone]
      message = params[:message]
      attachment = params[:attachment]

      # Validaciones simples
      if name.blank? || email.blank? || message.blank?
        flash[:alert] = 'Por favor, completa todos los campos requeridos.'
        render :contact and return
      end

      # Lógica para enviar el correo
      ContactMailer.contact_email(name, email, phone, message, attachment).deliver_now
      redirect_to contact_path, notice: 'Tu mensaje ha sido enviado con éxito.'
    else
      # Renderiza la página de contacto (GET)
    end
  end
end
