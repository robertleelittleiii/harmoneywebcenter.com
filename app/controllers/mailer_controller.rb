class MailerController < ApplicationController
  def simple_form
    @subject= params["subject"]
    @from= params["address_from"]
    @to= params["address_to"]
    
    body_field = params.clone
    body_field.delete("authenticity_token")
    body_field.delete("Submit")
    body_field.delete("from_address")
    body_field.delete("to_address")
    body_field.delete("subject")
    

   
    @message_body = body_field.to_yaml
    puts("here", @messsage_body, @from, @to, @subject)
    @mail_item = ContactUs.send_mail(@message_body, @from, @to, @subject)
    @mail_item.deliver
    
    render :nothing=>true;
  end

end
