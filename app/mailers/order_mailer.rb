class OrderMailer < ApplicationMailer
  default to: 'webppa@madeinwit.com'

  def confirmation_email(order)
    @order = order
    mail(
      to: @order.email, # Correo del visitante
      bcc: ['webppa@madeinwit.com', 'contabilidad@ppa.com.uy', 'marketing@ppa.com.uy'],
      subject: "Confirmación de tu pedido ##{@order.id}"
    )
  end
end
