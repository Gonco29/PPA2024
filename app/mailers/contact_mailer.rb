# app/mailers/contact_mailer.rb
class ContactMailer < ApplicationMailer
  default to: 'goncobos@gmail.com'  # !!!!!!REEMPLAZAR CAMBIAR MAIL!!!!!!!!!!!!!

  def contact_email(name, email, phone, message, attachment)
    @name = name
    @phone = phone
    @email = email
    @message = message
    attachments[attachment.original_filename] = attachment.read if attachment.present?
    mail(from: email, subject: 'New Contact Message')
  end
end
