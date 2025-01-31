class ContactMailer < ApplicationMailer
  default to: 'webppa@madeinwit.com'

  def contact_email(name, email, phone, message, attachment)
    @name = name
    @phone = phone
    @email = email
    @message = message
    attachments[attachment.original_filename] = attachment.read if attachment.present?

    mail(
      from: email,
      to: 'webppa@madeinwit.com',
      bcc: ['contabilidad@ppa.com.uy', 'marketing@ppa.com.uy'],
      subject: 'Nuevo mensaje de contacto'
    )
  end
end
