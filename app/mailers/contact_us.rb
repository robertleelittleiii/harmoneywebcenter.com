class ContactUs < ActionMailer::Base
  default :from => "admin@votedocbob.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_us.send_mail.subject
  #
  
  def send_mail (body, from, to, subject)
    @body=body
    puts("stuff", body, from, to, subject)
    mail(:to => to,:from=>from, :subject => subject)
  end
end
