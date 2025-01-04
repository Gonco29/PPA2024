class OrderMailer < ApplicationMailer
  default to: 'goncobos@gmail.com' # !!!!!!REEMPLAZAR CAMBIAR MAIL!!!!!!!!!!!!!

  def confirmation_email(order)
    @order = order
    mail(
      to: @order.email, # Correo del visitante
      bcc: 'goncobos@gmail.com', # !!!!!!REEMPLAZAR CAMBIAR MAIL!!!!!!!!!!!!!
      subject: "Confirmación de tu pedido ##{@order.id}"
    )
  end
end
